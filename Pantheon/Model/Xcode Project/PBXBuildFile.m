//
//  PBXBuildFile.m
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXBuildFile.h"

@implementation PBXBuildFile

+ (id)buildFileWithIdentifier:(NSString*)identifier andDictionary:(NSDictionary *)dictionary
{
    /* Create a new BuildFile instance. */
    PBXBuildFile *buildFile = [[PBXBuildFile alloc] init];
    
    /* If creation succeeded, let's load up the properties from the dictionary.*/
    if (buildFile) {
        [buildFile setReference:identifier]; //  The reference is passed in seperately.
        [buildFile setFileRef:dictionary[@"fileRef"]];  //  
        [buildFile setSettings:dictionary[@"settings"]];
    }
    
    return buildFile;
}


@end
