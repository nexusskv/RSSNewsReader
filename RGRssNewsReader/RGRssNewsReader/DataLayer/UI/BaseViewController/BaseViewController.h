//
//  BaseViewController.h
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (UITableView *)getRssTableByRect:(CGRect)frame;
- (void)showAlert:(NSString *)titleStr withMessage:(NSString *)msgStr;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
