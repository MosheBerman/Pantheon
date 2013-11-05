//
//  PBXProject.h
//  Pantheon
//
//  Created by Moshe Berman on 11/5/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXObject.h"

@interface PBXProject : PBXObject

/**
 *  The project attributes, including the 
 *  project prefix and the organization name.
 */

@property (nonatomic, strong) NSDictionary *attributes;

/**
 *  A 24 character string that points to the build configuration list.
 */

@property (nonatomic, strong) NSString *buildConfigurationList;

/**
 *  A string that states the compatibility version.
 */

@property (nonatomic, strong) NSString *compatibilityVersion;

/**
 *  A localization key that states what the 
 *  development region is.
 */

@property (nonatomic, strong) NSString *developmentRegion;

/**
 *  I'm not sure what this key does...
 */

@property (nonatomic, assign) BOOL hasScannedForEncodings;

/**
 *  A dictionary that contains the project's localizations.
 */

@property (nonatomic, copy) NSDictionary *knownRegions;

/**
 *  A 24 character string that represents the top level
 *  group of the project.
 */

@property (nonatomic, strong) NSString *mainGroup;

/**
 *  A 24 character string that refers to the group containing the 
 *  products of the build process.
 */

@property (nonatomic, strong) NSString *productRefGroup;

//
//  I'm not sure if these two guys are legacy or what, but they seem extraneous.
//

/**
 *  A path to the project directory. (Relative to the project?)
 */

@property (nonatomic, strong) NSString *projectDirPath;

/**
 *  A path to the project directory. (Relative to the project?)
 */

@property (nonatomic, strong) NSString *projectRoot;

/**
 *  An array of strings that represent the build targets.
 */

@property (nonatomic, copy) NSString *targets;

#pragma mark - Intializer

/**
 *  Takes a dictionary and a 24 character string.
 *
 *  @param dictionary A dictionary containing a project object.
 *  @param uuid A unique identifier that identifier the object.
 *
 *  @return A PBXProject or nil if the initialization fails.
 */

- (id)initWithDictionary:(NSDictionary *)dictionary forUUID:(NSString *)uuid;

@end
