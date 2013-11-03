//
//  PNProject.m
//  Pantheon
//
//  Created by Moshe Berman on 10/15/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXProject.h"

@interface PBXProject ()

@end

@implementation PBXProject

- (id)init
{
    self = [super init];
    if (self) {
        _PBXBuildFiles = [[NSMutableArray alloc] init];
        _PBXContainerItemProxies = [[NSMutableArray alloc] init];
        _PBXFileReferences = [[NSMutableArray alloc] init];
        _PBXFrameworksBuildPhases = [[NSMutableArray alloc] init];
        _PBXGroups = [[NSMutableArray alloc] init];
        _PBXNativeTargets = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id)projectFromXcodeProjectAtURL:(NSURL *)url error:(NSError **)error
{
    
    PBXProject *project = [[PBXProject alloc] init];
    
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
                    
                    /* If we've got a file reference, add it to the project. */
                    if ([object[@"isa"] isEqualToString:@"PBXfileReference"]) {
                        [project.PBXFileReferences addObject:[PBXFileReference fileReferenceWithIdentifier:key andDictionary:object]];
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
