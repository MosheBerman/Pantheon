//
//  PBXObject.h
//  
//
//  Created by Moshe Berman on 11/5/13.
//
//

#import <Foundation/Foundation.h>

@interface PBXObject : NSObject

/**
 *  A 96 bit UUID that identifies the object.
 */
@property (nonatomic, strong) NSUUID *reference;

@end
