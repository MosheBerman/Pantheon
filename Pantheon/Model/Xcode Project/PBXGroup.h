//
//  PBXGroup.h
//  Pantheon
//
//  Created by Moshe Berman on 11/5/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "PBXObject.h"

@interface PBXGroup : PBXObject

/**
 *  This child nodes of the group.
 */

@property (nonatomic, copy) NSMutableArray *children;

/**
 *  This value says if there's a parent element.
 */

@property (nonatomic, strong) NSString *sourceTree;

/**
 *  The display name of the group (if different from the path)
 */
@property (nonatomic, strong) NSString *name;

/**
 *  The relative path component that the group corresponds to.
 */
@property (nonatomic, strong) NSString *path;

@end
