//
//  DateFormatter.h
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

+ (id)shared;
- (NSString *)setString:(NSString *)incStr byFormat:(NSString *)format;

@end
