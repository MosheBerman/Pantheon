//
//  PNProject.h
//  Pantheon
//
//  Created by Moshe Berman on 10/15/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PBXBuildFile.h"
#import "PBXFileReference.h"

@interface PBXProject : NSObject

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

/**
 *  Loads an Xcode project out from a given url.
 *
 *  @param url The url to an xcodeproj or pbxproj file.
 *  @param error An error object to pass to the initializer.
 *
 *  @return A configured Xcode project.
 */

+ (id)projectFromXcodeProjectAtURL:(NSURL *)url error:(NSError **)error;

@end
