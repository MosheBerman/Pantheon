//
//  PBXProject.m
//  Pantheon
//
//  Created by Moshe Berman on 11/5/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXProject.h"

@implementation PBXProject

- (id)initWithDictionary:(NSDictionary *)dictionary forUUID:(NSString *)uuid
{
    self = [super init];
    if (self) {
        [super setReference:uuid];
        _attributes = dictionary[@"attributes"];
        _buildConfigurationList = dictionary[@"buildConfigurationList"];
        _compatibilityVersion = dictionary[@"compatibilityVersion"];
        _developmentRegion = dictionary[@"developmentRegion"];
        _hasScannedForEncodings = [dictionary[@"hasScannedForEncodings"] boolValue];
        _knownRegions = dictionary[@"knownRegions"];
        _mainGroup = dictionary[@"mainGroup"];
        _productRefGroup = dictionary[@"productRefGroup"];
        _projectDirPath = dictionary[@"productRefGroup"];
        _projectRoot = dictionary[@"projectRoot"];
        _targets = dictionary[@"targets"];
    }
    return self;
}

@end
