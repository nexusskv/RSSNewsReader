//
//  LoadXMLRss.h
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoadXMLRssCallback)(id);


@interface LoadXMLRss : NSObject <NSXMLParserDelegate>

@property (nonatomic, copy) LoadXMLRssCallback callbackBlock;

- (id)initWithCallback:(LoadXMLRssCallback)block;
- (void)getXMLRssById:(NSUInteger)rssType;

@end
