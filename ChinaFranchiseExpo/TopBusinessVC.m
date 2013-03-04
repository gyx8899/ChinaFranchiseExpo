//
//  TopBusinessVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "TopBusinessVC.h"
#import "BusinessNewsVC.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"
@interface TopBusinessVC ()

@end

@implementation TopBusinessVC

- (void)news_query
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"news_query" forKey:@"requestCommand"];  
    [params setValue:[NSNumber numberWithInt:1] forKey:@"pageNo"];
    [params setValue:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"newstype"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"newsid"];
    
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
        self.data = [(NSDictionary *)resultStr objectForKey:@"data"];

    }
}

- (void)logoDidLoad
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"image_logo" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"type"];
    NSString *jsonString = [params JSONRepresentation];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL  URLWithString:urlString]];
    [request addRequestHeader:@"Content_type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    NSString *result = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    NSObject *resultStr = [result JSONValue];
    if ([resultStr isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray *dic1 = [(NSDictionary *)resultStr objectForKey:@"data"];
        NSString *stringUrl = [[dic1 objectAtIndex:0] objectForKey:@"url"];
        if (stringUrl != NULL) {
            NSURL *url = [NSURL URLWithString:stringUrl];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            self.logoImage.image = image;
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
    
    self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    [self.view addSubview:self.logoImage];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,140, 320, 227)];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    
    [self logoDidLoad];
    [self news_query];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_data release];
    [_logoImage release];
    [_myTableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UITableView Data Source Methods

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.imageView.image = [UIImage imageNamed:@"GreenStar.png"];
    cell.textLabel.text = [[self.data objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -
#pragma mark - UITableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessNewsVC *BNVC = [[BusinessNewsVC alloc] initWithNibName:@"BusinessNewsVC" bundle:nil];
    BNVC.dataId =[[[self.data objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
    [self.navigationController pushViewController:BNVC animated:YES];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    
    [BNVC release];
}


@end
