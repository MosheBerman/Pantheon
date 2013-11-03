//
//  PBXBuildFile.m
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXBuildFile.h"

@implementation PBXBuildFile

+ (id)buildFileWithReference:(NSString*)reference andDictionary:(NSDictionary *)dictionary;
{
    PBXBuildFile *buildFile = [[PBXBuildFile alloc] init];
    
    if (buildFile) {
        [buildFile setReference:[[NSUUID alloc] initWithUUIDString:reference]];
        [buildFile setFileRef:dictionary[@"fileRef"]];
        [buildFile setSettings:dictionary[@"settings"]];
    }
    
    return buildFile;
}


@end
