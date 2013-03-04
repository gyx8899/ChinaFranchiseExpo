//
//  SubwayLineVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "SubwayLineVC.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

@interface SubwayLineVC ()

@end

@implementation SubwayLineVC

- (void)traffic_query
{
    NSURL * url=[NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"traffic_query" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:2] forKey:@"type"];
    [params setValue:@"" forKey:@"fromplace"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"exhibitionid"];
    
    // convert to JSON string
    NSString* jsonString = [params JSONRepresentation];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    NSString *result = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    
    NSObject *resultStr = [result JSONValue];
    if ([resultStr isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *lineArray = [(NSDictionary *)resultStr objectForKey:@"data"];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
        if ([lineArray count] > 0)
        {
            NSString *webviewText = [[lineArray objectAtIndex:0] objectForKey:@"trfficontent"];
            [self.webView loadHTMLString:webviewText baseURL:nil];
        }
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
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:self.webView];
    
    [self traffic_query];
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
