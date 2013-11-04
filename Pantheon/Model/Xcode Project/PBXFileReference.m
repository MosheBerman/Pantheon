//
//  PBXFileReference.m
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXFileReference.h"

@implementation PBXFileReference

/**
 *  Convenience Initializer
 */

+ (id)fileReferenceWithIdentifier:(NSString *)string andDictionary:(NSDictionary *)dictionary
{
    PBXFileReference *fileReference = [[PBXFileReference alloc] init];
    
    if (fileReference) {
        
        [fileReference setFileEncoding:dictionary[@"fileEncoding"]];
        
        [fileReference setLastKnownFileType:dictionary[@"lastKnownFileType"]];
        
        [fileReference setPath:dictionary[@"path"]];
        
        [fileReference setName:dictionary[@"name"]];
        
        /* If there's no name, use the path's last component .*/
        if (![fileReference name]) {
            [fileReference setName:[[fileReference path] lastPathComponent]];
        }
        
        [fileReference setSourceTree:dictionary[@"sourceTree"]];
    }
    
    return fileReference;
}

@end
