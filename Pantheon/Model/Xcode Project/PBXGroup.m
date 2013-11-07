//
//  PBXGroup.m
//  Pantheon
//
//  Created by Moshe Berman on 11/5/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXGroup.h"

@implementation PBXGroup

- (id)initWithIdentifier:(NSString *)identifier andDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [super setReference:identifier];    // The superclass holds the identifier.
        _children =  dictionary[@"_children"];
        _sourceTree = dictionary[@"sourceTree"];
        _name = dictionary[@"name"];
        _path = dictionary[@"path"];
    }
    return self;
}

@end
