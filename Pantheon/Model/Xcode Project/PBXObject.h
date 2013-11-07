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
 *  A 24 character UUID that identifies the object.
 */
@property (nonatomic, strong) NSString *reference;

@end
