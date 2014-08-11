//
//  RequestHelper.h
//  RGRssNewsReader
//
//  Created by rost on 07.08.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestHelper : NSObject

+ (RequestHelper *)shared;
- (NSURLRequest *)setRequestByType:(NSUInteger)rssType;

@end
