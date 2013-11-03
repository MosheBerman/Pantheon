//
//  XcodeCompatibilityVersion.h
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#ifndef Pantheon_XcodeCompatibilityVersion_h
#define Pantheon_XcodeCompatibilityVersion_h

/**
 *  These values represent compatibility with 
 *  corresponding Xcode versions.
 */

NS_ENUM(NSInteger, XcodeCompatibilityVersion){
    XcodeCompatibilityVersion_2_4 = 42, //  Xcode 2.4
    XcodeCompatibilityVersion_3_0 = 44, //  Xcode 3.0
    XcodeCompatibilityVersion_3_1 = 45, //  Xcode 3.1
    XcodeCompatibilityVersion_3_2 = 46, //  Xcode 3.2+
};


#endif
