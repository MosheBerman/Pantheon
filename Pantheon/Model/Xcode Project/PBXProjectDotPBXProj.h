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
#import "PBXProject.h"
#import "PBXReferenceProxy.h"

@class PBXFrameworksBuildPhase;
@class PBXResourcesBuildPhase;
@class PBXSourcesBuildPhase;
@class PBXTargetDependency;
@class PBXVariantGroup;
@class XCBuildConfiguration;

@interface PBXProjectDotPBXProj : NSObject

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
@property (nonatomic, strong) NSMutableArray *PBXFrameworksBuildPhases;
@property (nonatomic, strong) PBXReferenceProxy *PBXReferenceProxy;
@property (nonatomic, strong) NSMutableArray *PBXFileReferences;
@property (nonatomic, strong) NSMutableArray *PBXGroups;
@property (nonatomic, strong) NSMutableArray *PBXNativeTargets;
@property (nonatomic, strong) PBXProject *PBXProject;
@property (nonatomic, strong) NSMutableArray *PBXResourcesBuildPhases;
@property (nonatomic, strong) NSMutableArray *PBXScriptBuildPhases;
@property (nonatomic, strong) NSMutableArray *PBXSourcesBuildPhases;
@property (nonatomic, strong) NSMutableArray *PBXTargetDependencies;
@property (nonatomic, strong) NSMutableArray *PBXVariantGroups;
@property (nonatomic, strong) NSMutableArray *XCBuildConfigurations;
@property (nonatomic, strong) NSMutableArray *PBXContainerItemProxies;
@property (nonatomic, strong) NSDictionary *XCVersionGroup;

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
