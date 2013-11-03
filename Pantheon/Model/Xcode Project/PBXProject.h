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

- (id)projectFromXcodeProjectAtURL:(NSURL *)url error:(NSError **)error;

@end
