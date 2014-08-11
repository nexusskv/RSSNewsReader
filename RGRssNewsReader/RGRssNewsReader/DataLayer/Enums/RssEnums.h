//
//  RssEnums.h
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

typedef enum kTypeRSS : NSInteger kTypeRSS;
enum kTypeRSS : NSInteger {
    Apple,
    Google,
    Dou,
    Habr,
};

#define kRSSTypesArray @[@"Apple Hot News", @"Google Hot News", @"Интересное на ДОУ", @"Habrahabr RSS"]


#ifndef RGRssNewsReader_RssEnums_h
#define RGRssNewsReader_RssEnums_h

#endif
