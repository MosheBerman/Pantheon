//
//  PBXFileEncoding.h
//  Pantheon
//
//  Created by Moshe Berman on 11/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#ifndef Pantheon_PBXFileEncoding_h
#define Pantheon_PBXFileEncoding_h

NS_ENUM(NSInteger, PBXFileEncoding) {
    PBXFileEncodingDefault = 0,
    PBXFileEncodingUTF8 = 4,
    PBXFileEncodingUTF16 = 10,
    PBXFileEncodingUTF16_BE = 2415919360,
    PBXFileEncodingUTF16_LE = 2483028224,
    PBXFileEncodingWestern = 30,
    PBXFileEncodingJapanese = 2147483649,
    PBXFileEncodingTraditionalChinese = 2147483650,
    PBXFileEncodingKorean = 2147483651,
    PBXFileEncodingArabic = 2147483652,
    PBXFileEncodingHebrew = 2147483653,
    PBXFileEncodingGreek = 2147483654,
    PBXFileEncodingCyrillic = 2147483655,
    PBXFileEncodingSimplifiedChinese = 2147483673,
    PBXFileEncodingCentralEuropean = 2147483677,
    PBXFileEncodingTurkish = 2147483683,
    PBXFileEncodingIcelandic = 2147483685,
};

#endif
