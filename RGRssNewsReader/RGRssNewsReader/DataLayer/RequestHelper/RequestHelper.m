//
//  RequestHelper.m
//  RGRssNewsReader
//
//  Created by rost on 07.08.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "RequestHelper.h"

@implementation RequestHelper

+ (RequestHelper *)shared
{
    static RequestHelper *shared = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{ shared = [[self alloc] init]; });
    return shared;
}

- (NSURLRequest *)setRequestByType:(NSUInteger)rssType
{
    NSString *urlString = nil;
    NSString *contentType = @"application/rss+xml";
    
    switch (rssType)
    {
        case Apple:
            urlString = kAppleUrl;
            break;
        
        case Google:
        {
            urlString   = kGoogleUrl;
            contentType = @"application/rss+json";
        }
            break;
            
        case Dou:
            urlString = kDouUrl;
            break;
            
        case Habr:
            urlString = kHabrUrl;
            break;
            
        default:
            break;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60.0f];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    
    return request;
}

@end
