//
//  DetailsViewController.h
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : BaseViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSDictionary *detailsDic;
@end
