//
//  PNProject.m
//  Pantheon
//
//  Created by Moshe Berman on 10/15/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXProject.h"

@interface PBXProject ()

/** The archive version. */
@property (nonatomic, strong) NSNumber *archiveVersion;

/** A dictionary of classes. */
@property (nonatomic, strong) NSDictionary *classes;

/**
 *  The object version.
 */
@property (nonatomic, strong) NSNumber *objectVersion;

/** Root Object ID. */
@property (nonatomic, strong) NSString *rootObjectID;

/** The URL that the project resides at. */
@property (nonatomic, strong) NSURL *projectURL;

/* The different parts of the objects group... */
@property (nonatomic, strong) NSMutableArray *PBXBuildFiles;
@property (nonatomic, strong) NSMutableArray *PBXContainerItemProxies;
@property (nonatomic, strong) NSMutableArray *PBXFileReferences;
@property (nonatomic, strong) NSMutableArray *PBXFrameworksBuildPhases;
@property (nonatomic, strong) NSMutableArray *PBXGroups;
@property (nonatomic, strong) NSMutableArray *PBXNativeTargets;

// PBXReferenceProxy
// PBXResourcesBuildPhase
// PBXShellScriptBuildPhase
// PBXSourcesBuildPhase
// PBXTargetDependency
// PBXVariantGroup
// XCBuildConfiguration
// XCConfigurationList
// XCVersionGroup

@end

@implementation PBXProject

- (id)projectFromXcodeProjectAtURL:(NSURL *)url error:(NSError **)error
{
    
    PBXProject *project = [[PBXProject alloc] init];
    
    if (project) {
        
        /* If the URL is an Xcode project, we want to look for the pbxproj file. */
        
        if ([[url pathExtension] isEqualToString:@"xcodeproj"]) {
            url = [url URLByAppendingPathComponent:@"project.pbxproj"];
        }
        
        /* Now, we either have a valid project.pbxproj file or not. */
        if ([[url lastPathComponent] isEqualToString:@"project.pbxproj"])
        {
            
            NSError *err = nil;
            NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&err];
            
            /* If the data fails to load, set project to nil and */
            if (!data) {
                project = nil;
                *error = err;
            }
            else {
                
                NSDictionary *projectContents = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                
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
                        NSDictionary *object = objectsInProject[@"key"];
                        
                        /* Based on the kind of object, do the right thing with it. */
                        
                        /* If we've got a file reference, add it to the project. */
                        if ([object[@"isa"] isEqualToString:@"PBXfileReference"]) {
                            [project.PBXFileReferences addObject:[PBXFileReference fileReferenceWithIdentifier:key andDictionary:object]];
                        }
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
