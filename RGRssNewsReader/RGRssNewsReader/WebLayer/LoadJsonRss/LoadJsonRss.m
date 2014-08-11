//
//  LoadJsonRss.m
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "LoadJsonRss.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "RequestHelper.h"


@interface LoadJsonRss ()
@property (nonatomic, strong) NSMutableArray *rssFeed;
@property (nonatomic, strong) NSMutableDictionary *rssItem;
@property (nonatomic, strong) NSString *rssItemKey;
@end


@implementation LoadJsonRss

@synthesize  rssFeed, rssItem, rssItemKey;


- (id)initWithCallback:(LoadJsonRssCallback)block
{
    if (self = [super init])
    {
        self.callbackBlock = block;
    }
    
    return self;
}

- (void)getJsonRssById:(NSUInteger)rssType
{
    rssFeed = [NSMutableArray array];

    NSURLRequest *request =  [[RequestHelper shared] setRequestByType:rssType];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject valueForKey:@"responseStatus"] intValue] == 200)
        {
            if ([[responseObject valueForKeyPath:@"responseData.feed.entries"] count] > 0)
                self.callbackBlock([responseObject valueForKeyPath:@"responseData.feed.entries"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog (@"Error >>> %@", error.description);
    }];
    [operation start];
}

@end
