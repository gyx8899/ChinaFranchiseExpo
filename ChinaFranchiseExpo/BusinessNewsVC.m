//
//  BusinessNewsVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "BusinessNewsVC.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

@interface BusinessNewsVC ()

@end

@implementation BusinessNewsVC

- (void)news_detail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"news_detail" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:self.dataId] forKey:@"id"];
    NSURL *url = [NSURL URLWithString:urlString];
	NSString *jsonString = [params JSONRepresentation];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request addRequestHeader:@"Content-type" value:@"application/json"];
	[request setRequestMethod:@"POST"];
	[request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
	[request startSynchronous];
    NSString *result = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    NSObject *resultStr = [result JSONValue];
    if ([resultStr isKindOfClass:[NSDictionary class]])
    {
        NSString *textStr = [(NSDictionary *)resultStr objectForKey:@"content"];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
        [self.webView loadHTMLString:textStr baseURL:nil];
    }
    
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // iOS 5.0 直接设置背景; iOS 5.0以下通过Catgory 设置背景图
    if ([UINavigationBar instancesRespondToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBack.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, 320, 367)];
    [self.view addSubview:self.webView];
    
    [self news_detail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_webView release];
    [super dealloc];
}

@end
