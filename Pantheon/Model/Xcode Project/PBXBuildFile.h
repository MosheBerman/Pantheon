//
//  PBXBuildFile.h
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXObject.h"

@interface PBXBuildFile : PBXObject

/**
 *  A 24 character string reference to the backing file.
 */
@property (nonatomic, strong) NSString *fileRef;

/**
 *  Special settings. For example, compiler flags for the given file.
 */
@property (nonatomic, strong) NSDictionary *settings;

/** 
 *  Create a PBXBuildFile reference using a given dictionary.
 *  
 *  @param reference A 96 bit identifier.
 *  @param dictionary A dictionary that represents a file reference.
 *
 *  @return A configured PBXBuildFile.
 */

+ (id)buildFileWithIdentifier:(NSString*)identifier andDictionary:(NSDictionary *)dictionary;

@end
