//
//  PBXFileReference.h
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBXFileReference : NSObject

/** 
 *  A numeric code representing the file encoding. 
 */
@property (nonatomic, strong) NSNumber *fileEncoding;

/**
 *  A string representing the last known file type.
 */
@property (nonatomic, strong) NSString *lastKnownFileType;

/**
 *  The display name of the file reference.
 */
@property (nonatomic, strong) NSString *name;

/**
 *  A path to the file. 
 *
 *  @discussion The sourceTree variable provides additional information about the location of the file.
 *
 */

@property (nonatomic, strong) NSString *path;

/**
 *  Information about where the file's path is.
 */

@property (nonatomic, strong) NSString *sourceTree;

/**
 *  Convenience Initializer that returns a file reference.
 *
 *  @param string A 96 bit identifier.
 *  @param dictionary A dictionary containing the data for the file reference.
 *
 *  @return A PBXFileReference object.
 */

+ (id)fileReferenceWithIdentifier:(NSString *)string andDictionary:(NSDictionary *)dictionary;

@end
