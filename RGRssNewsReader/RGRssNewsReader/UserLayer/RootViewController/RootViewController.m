//
//  RootViewController.m
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "RootViewController.h"
#import "RssViewController.h"



@interface RootViewController ()

@end


@implementation RootViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Developers RSS";

    UITableView *titlesTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, VIEW_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
    titlesTable.delegate       = self;
    titlesTable.dataSource     = self;
    titlesTable.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    titlesTable.backgroundColor   = [UIColor clearColor];
    titlesTable.scrollEnabled     = YES;
    [self.view addSubview:titlesTable];
}

#pragma mark - TableView Delegate & DataSourse Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowsCount = 0;
    
	if ([kRSSTypesArray count] > 0)
        rowsCount = [kRSSTypesArray count];
    
    return rowsCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *rssType = @"RssType";
	
	UITableViewCell *cell = nil;
    
	if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rssType];
        
        cell.textLabel.text = [kRSSTypesArray objectAtIndex:indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RssViewController *rssVC = [[RssViewController alloc] init];
    rssVC.rssType = indexPath.row;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:rssVC animated:NO];
}
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
