//
//  DetailsViewController.m
//  RGRssNewsReader
//
//  Created by rost on 28.07.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "DetailsViewController.h"
#import "VersionComparator.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController

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
    
    self.title = [self.detailsDic valueForKey:@"title"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        webView.paginationMode = UIWebPaginationModeTopToBottom;

    if ([(NSString *)[self.detailsDic valueForKey:@"link"] length] > 0)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.detailsDic valueForKey:@"link"]]
                                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:30];
        [webView loadRequest:request];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showActivityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideActivityIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideActivityIndicator];
    
    if (error.description.length > 0)
        [self showAlert:@"Loading Feed Error!" withMessage:error.description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
