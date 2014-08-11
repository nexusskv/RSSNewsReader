//
//  LoadJsonRss.h
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoadJsonRssCallback)(id);


@interface LoadJsonRss : NSObject

@property (nonatomic, copy) LoadJsonRssCallback callbackBlock;

- (id)initWithCallback:(LoadJsonRssCallback)block;
- (void)getJsonRssById:(NSUInteger)rssType;

@end

