//
//  RssViewController.h
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RssViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSUInteger rssType;
@end
