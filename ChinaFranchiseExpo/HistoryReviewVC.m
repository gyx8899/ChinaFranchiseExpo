//
//  HistoryReviewVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "HistoryReviewVC.h"
#import "HistoryTableCell.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

@interface HistoryReviewVC ()

@end

@implementation HistoryReviewVC

- (void)oldExh_query
{
    NSURL * url=[NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"oldExh_query" forKey:@"requestCommand"];
    
    NSString* jsonString = [params JSONRepresentation];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    NSString *result = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    
    NSObject *resultStr = [result JSONValue];
    if ([resultStr isKindOfClass:[NSDictionary class]])
    {
        self.myArray = [(NSDictionary *)resultStr objectForKey:@"data"];
    }
}

#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myArray = [NSMutableArray array];
    [self oldExh_query];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_myArray release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myArray count];
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 196;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    HistoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HistoryTableCell" owner:self options:nil];
        if([[nib objectAtIndex:0] isKindOfClass:[HistoryTableCell class]])
        {
            cell = [nib objectAtIndex:0];
        }
    }
    cell.describe.text = [[self.myArray objectAtIndex:indexPath.row] objectForKey:@"describe"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    NSString *imageAddress = [[self.myArray objectAtIndex:indexPath.row] objectForKey:@"Image_url"];
    NSURL *urlImage = [NSURL URLWithString:imageAddress];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlImage]];
    cell.imageView.image = img;
    return cell;
}

@end
