//
//  DateFormatter.m
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+ (DateFormatter *)shared
{
    static DateFormatter *shared = nil;
    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (NSString *)setString:(NSString *)incStr byFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];    
    NSDate *date = [formatter dateFromString:incStr];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

@end
