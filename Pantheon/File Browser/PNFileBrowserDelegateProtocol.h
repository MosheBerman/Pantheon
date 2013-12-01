//
//  PNFileBrowserDelegateProtocol.h
//  Pantheon
//
//  Created by Moshe Berman on 11/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PBXFileReference;
@class PBXProjectDotPBXProj;

@protocol PNFileBrowserDelegateProtocol <NSObject>

/**
 *  Inform the delegate that a file was selected.
 *
 *  @param file A file reference.
 *  @param project A reference to the project. (This may be useful for renaming operations 
 */
- (void)fileBrowserDidSelectFile:(PBXFileReference *)file inProject:(PBXProjectDotPBXProj *)project;

@end
