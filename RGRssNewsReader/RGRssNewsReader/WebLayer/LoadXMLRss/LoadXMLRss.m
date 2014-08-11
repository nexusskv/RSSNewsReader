//
//  LoadXMLRss.m
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "LoadXMLRss.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "RequestHelper.h"


@interface LoadXMLRss ()
@property (nonatomic, strong) NSMutableArray *rssFeed;
@property (nonatomic, strong) NSMutableDictionary *rssItem;
@property (nonatomic, strong) NSString *rssItemKey;
@property (nonatomic, assign) NSUInteger rssTypeId;
@end


@implementation LoadXMLRss

@synthesize  rssFeed, rssItem, rssItemKey;


- (id)initWithCallback:(LoadXMLRssCallback)block
{
    if (self = [super init])
    {
        self.callbackBlock = block;
    }

    return self;
}


- (void)getXMLRssById:(NSUInteger)rssType
{
    rssFeed = [NSMutableArray array];
    
    self.rssTypeId = rssType;
    
    NSURLRequest *request =  [[RequestHelper shared] setRequestByType:rssType];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:responseObject];
        [rssParser setDelegate:self];
        [rssParser setShouldProcessNamespaces:NO];
        [rssParser setShouldReportNamespacePrefixes:NO];
        [rssParser setShouldResolveExternalEntities:NO];
        [rssParser parse];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog (@"Error >>> %@", error.description);
    }];
    [operation start];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Error parsing XML: %@", parseError.description);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ( [elementName isEqualToString:@"item"])
    {
        rssItem = [NSMutableDictionary dictionary];
        return;
    }
    
    switch (self.rssTypeId)
    {
        case Apple:
        {
            if (([elementName isEqualToString:@"title"])        ||
                ([elementName isEqualToString:@"link"])         ||
                ([elementName isEqualToString:@"description"])  ||
                ([elementName isEqualToString:@"pubDate"]))
            {
                self.rssItemKey = elementName;
            }
        }
            break;
            
        case Dou:
        {
            if (([elementName isEqualToString:@"title"])        ||          // FOR DOU ONLY
                ([elementName isEqualToString:@"guid"])         ||
                ([elementName isEqualToString:@"pubDate"]))
            {
                self.rssItemKey = elementName;
            }
        }
            break;
            
        case Habr:
            break;
            
        default:
            break;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ((self.rssItemKey.length > 0) && (![string isEqualToString:@"\n"]))
    {
        if ([self.rssItemKey isEqualToString:@"pubDate"])
            string = [[DateFormatter shared] setString:string byFormat:@"dd.MM.yyyy HH:mm"];
        
        if ([self.rssItemKey isEqualToString:@"guid"])      // FOR DOU ONLY
            self.rssItemKey = @"link";
        
        if ((string) && (string.length > 0))
            [rssItem setObject:string forKey:self.rssItemKey];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qNam
{
    if ([elementName isEqualToString:@"item"])
    {
        if ([[rssItem allKeys] count] > 0)
            [rssFeed addObject:rssItem];
        return;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.callbackBlock(self.rssFeed);
}

@end
