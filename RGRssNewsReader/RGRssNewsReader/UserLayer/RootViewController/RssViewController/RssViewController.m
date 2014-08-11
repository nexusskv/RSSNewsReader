//
//  RssViewController.m
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "RssViewController.h"
#import "DetailsViewController.h"
#import "LoadXMLRss.h"
#import "LoadJsonRss.h"


@interface RssViewController ()
@property (nonatomic, strong) NSArray *rssArr;
@end


@implementation RssViewController


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
    
    UITableView *titlesTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, VIEW_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
    titlesTable.delegate       = self;
    titlesTable.dataSource     = self;
    titlesTable.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    titlesTable.backgroundColor   = [UIColor clearColor];
    
    [self.view addSubview:titlesTable];

    
    [self showActivityIndicator];
    
    switch (self.rssType) {
            
        case Apple: case Dou:
        {
            LoadXMLRss *rss = [[LoadXMLRss alloc] initWithCallback:^(id resultObject) {
            
            [self hideActivityIndicator];
                
                if ([resultObject isKindOfClass:[NSArray class]])
                    if ([(NSArray *)resultObject count] > 0)
                    {
                        self.rssArr = resultObject;
                        [titlesTable reloadData];
                    }
            }];
            
            [rss getXMLRssById:self.rssType];
        }
            break;
            
        case Google:
        {
            LoadJsonRss *rss = [[LoadJsonRss alloc] initWithCallback:^(id resultObject) {
                
                [self hideActivityIndicator];
                
                if ([resultObject isKindOfClass:[NSArray class]])
                    if ([(NSArray *)resultObject count] > 0)
                    {
                        self.rssArr = resultObject;
                        [titlesTable reloadData];
                    }
            }];
            
            [rss getJsonRssById:self.rssType];
        }
            break;
            
        case Habr:
            break;

            
        default:
            break;
    }
    
    self.title = [kRSSTypesArray objectAtIndex:self.rssType];
}

#pragma mark - TableView Delegate & DataSourse Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowsCount = 0;
    
	if ([self.rssArr count] > 0)
        rowsCount = [self.rssArr count];
    
    return rowsCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *rssFeed = @"RssFeed";
	
	UITableViewCell *cell = nil;
    
	if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:rssFeed];
        
        cell.textLabel.text = [[self.rssArr objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.detailTextLabel.text = [[self.rssArr objectAtIndex:indexPath.row] valueForKey:@"pubDate"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
    detailsVC.detailsDic = [self.rssArr objectAtIndex:indexPath.row];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:detailsVC animated:NO];
}
#pragma mark -


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
