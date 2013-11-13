//
//  PNProject.m
//  Pantheon
//
//  Created by Moshe Berman on 10/15/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXProjectDotPBXProj.h"

@interface PBXProjectDotPBXProj ()

@end

@implementation PBXProjectDotPBXProj

- (id)init
{
    self = [super init];
    if (self) {
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
                    }
                    
                    /**
                     *  Add file references.
                     */
                    
                    if ([object[@"isa"] isEqualToString:@"PBXFileReference"]) {
                        PBXFileReference *file = [PBXFileReference fileReferenceWithIdentifier:key andDictionary:object];
                        [[project PBXFileReferences] addObject:file];
                    }
                     
                     
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


@end
