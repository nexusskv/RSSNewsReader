//
//  BaseViewController.m
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "BaseViewController.h"
#import "DSActivityView.h"

@interface BaseViewController ()
@property (nonatomic, weak) DSActivityView *indicatorView;
@end

@implementation BaseViewController

#pragma mark - Constructor
- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
    }
    return self;
}
#pragma mark -


#pragma mark - Destructor
- (void)dealloc
{
    self.indicatorView = nil;
}
#pragma mark -

#pragma mark - getRssTableByRect:
- (UITableView *)getRssTableByRect:(CGRect)frame
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.backgroundColor   = [UIColor clearColor];
    tableView.scrollEnabled     = YES;
    
    return tableView;
}
#pragma mark -


#pragma mark - showAlert:withMessage:
- (void)showAlert:(NSString *)titleStr withMessage:(NSString *)msgStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr
                                                    message:msgStr
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
#pragma mark -

#pragma mark - Activity indicator lib methods
- (void)showActivityIndicatorWithTitle:(NSString *)title
{
    self.indicatorView = [DSBezelActivityView activityViewForView:self.view withLabel:title];
}

- (void)showActivityIndicator
{
	[self showActivityIndicatorWithTitle:nil];
}

- (void)changeActivityIndicatorTitleTo:(NSString *)title
{
	[DSBezelActivityView currentActivityView].activityLabel.text = title;
    self.indicatorView = [DSBezelActivityView currentActivityView];
}

- (void)hideActivityIndicator
{
	[DSBezelActivityView removeViewAnimated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [DSActivityView removeView];
    self.indicatorView = nil;
}
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
