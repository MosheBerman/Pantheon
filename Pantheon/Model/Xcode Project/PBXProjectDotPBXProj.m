//
//  PNProject.m
//  Pantheon
//
//  Created by Moshe Berman on 10/15/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXProjectDotPBXProj.h"

@interface PBXProjectDotPBXProj ()

@property (nonatomic, strong) NSMutableDictionary *fileAndGroupRelationshipTable;

@end

@implementation PBXProjectDotPBXProj

- (id)init
{
    self = [super init];
    if (self)
    {
        _PBXBuildFiles = [[NSMutableArray alloc] init];
        _PBXFrameworksBuildPhases = [[NSMutableArray alloc] init];
        _PBXReferenceProxy = [[PBXReferenceProxy alloc] init];
        _PBXFileReferences = [[NSMutableArray alloc] init];
        _PBXGroups = [[NSMutableArray alloc] init];
        _PBXNativeTargets = [[NSMutableArray alloc] init];
        _PBXProject = [[PBXProject alloc] init];
        _PBXResourcesBuildPhases = [[NSMutableArray alloc] init];
        _PBXScriptBuildPhases = [[NSMutableArray alloc] init];
        _PBXSourcesBuildPhases = [[NSMutableArray alloc] init];
        _PBXTargetDependencies = [[NSMutableArray alloc] init];
        _PBXVariantGroups = [[NSMutableArray alloc] init];
        _XCBuildConfigurations = [[NSMutableArray alloc] init];
        _PBXContainerItemProxies = [[NSMutableArray alloc] init];
        _XCVersionGroup = [[NSDictionary alloc] init];
        
        /**
         *  Keep a hash table for reverse file-group relationship lookups.
         */
        _fileAndGroupRelationshipTable = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (id)projectFromXcodeProjectAtURL:(NSURL *)url error:(NSError **)error
{
    
    PBXProjectDotPBXProj *project = [[PBXProjectDotPBXProj alloc] init];
    
    if (project) {
        
        /* If the URL is an Xcode project, we want to look for the pbxproj file. */
        
        if ([[url pathExtension] isEqualToString:@"xcodeproj"]) {
            
            /* Save the original project URL before we manipulate it. */
            [project setProjectURL:url];
            
            url = [url URLByAppendingPathComponent:@"project.pbxproj"];
        }
        
        /* Now, we either have a valid project.pbxproj file or not. */
        if ([[url lastPathComponent] isEqualToString:@"project.pbxproj"])
        {
            
            NSError *err = nil;
            
            NSDictionary *projectContents = [NSDictionary dictionaryWithContentsOfFile:[url path]];
            
            /* */
            if (!projectContents) {
                project = nil;
                *error = err;
            }
            
            /*  If we've had a successful load, populate the object. */
            else {
                
                [project setArchiveVersion:projectContents[@"archiveVersion"]];
                
                [project setClasses:projectContents[@"classes"]];
                
                [project setObjectVersion:projectContents[@"objectVersion"]];
                
                [project setRootObjectID:projectContents[@"rootObject"]];
                
                /* Load the objects... */
                
                NSDictionary *objectsInProject = projectContents[@"objects"];
                
                for (NSString *key in [objectsInProject allKeys]) {
                    
                    /* Get the object itself. */
                    NSDictionary *object = objectsInProject[key];
                    
                    /* Based on the kind of object, do the right thing with it. */
                    
                    /**
                     *  If we find the PXBProject, save it.
                     *
                     *  We're going to have to build the hierarchy later.
                     *
                     */
                    if ([object[@"isa"] isEqualToString:@"PBXProject"]) {
                        [project setPBXProject:[[PBXProject alloc] initWithDictionary:object forUUID:key]];
                    }
                    
                    /**
                     *  Add groups...
                     */
                    
                    if ([object[@"isa"] isEqualToString:@"PBXGroup"]) {
                        PBXGroup *group = [[PBXGroup alloc] initWithIdentifier:key andDictionary:object];
                        [[project PBXGroups] addObject:group];
                        
                        /**
                         *  Populate the reference table to help build paths out later.
                         */
                        for (NSString *child in group.children)
                        {
                            [project fileAndGroupRelationshipTable][child] = [group reference];
                        }
                    }
                    
                    /**
                     *  Add file references.
                     */
                    
                    if ([object[@"isa"] isEqualToString:@"PBXFileReference"]) {
                        PBXFileReference *file = [PBXFileReference fileReferenceWithIdentifier:key andDictionary:object];
                        [[project PBXFileReferences] addObject:file];
                    }
                    
                    /**
                     *  TODO: Load other data here.
                     *
                     *  1. Ensure that a corresponding model class exists.
                     *  2. Check the class type and instantate the correct object.
                     *  3. Add to the correct collection.
                     *  4. Profit.
                     */
                }
            }
        }
    }
    
    /* Else, we don't have a valid Xcode project, so let's just quit. */
    else {
        project = nil;
    }
    
    return project;
}

/**
 *  Returns a complete relative path for a given file.
 *
 *  @param fileReference The file reference object that we want a path to.
 *
 *  @return A complete relative (or absolute) path to the fileReference.
 *
 */
- (NSString *)resolvePathToFileReference:(PBXFileReference *)fileReference
{
    
    /* We're going to need a place to put the path. */
    NSString *path = [fileReference path];
    
    /* The identifier of the file we're looking up. */
    NSString *referenceIdentifier = [fileReference reference];
    
    /* The key we're using to look up the next level of hierarchy. */
    NSString *lookupKey = referenceIdentifier;
    
    /* Walk the hierearchy, using the lookup table. */
    BOOL lookupExists = [[[self fileAndGroupRelationshipTable] allKeys] containsObject:lookupKey];
    
    while (lookupExists) {
        
        /* Convert the lookup key to the parent's key. */
        NSString *groupKey = [self fileAndGroupRelationshipTable][lookupKey];
        
        /* Look at the groups object for the referenced parent... */
        PBXGroup *group = [self groupForReferenceIdentifier:groupKey];
        
        /* ... if we have one.. */
        if (group) {
            
            /* ...then look for a group path... */
            if ([group path]) {
                
                /* If it exists, prepend the path component to the parent. */
                path = [[group path] stringByAppendingPathComponent:path];
                
            }
            
            /* Set the lookup to the group's id. */
            lookupKey = groupKey;
    
        }
        
        /* If there's no parent, we're done, nil out the lookupKey to break the loop. */
        else {
            lookupKey = nil;
        }
        
        /* */
        lookupExists = [[[self fileAndGroupRelationshipTable] allKeys] containsObject:groupKey];
    }
    
    return path;
}

/**
 *  Finds the group matching the key.
 *
 *  @param key The unique key of the group.
 *  @return A group object, or nil if it's not found.
 */

- (PBXGroup *)groupForReferenceIdentifier:(NSString *)key
{
    PBXGroup *group = nil;
    
    for (PBXGroup *g in [self PBXGroups]) {
        if ([[g reference] isEqualToString:key]) {
            group = g;
        }
    }
    return group;
}


@end
