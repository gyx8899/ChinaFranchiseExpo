//
//  InvestorGuideVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "InvestorGuideVC.h"
#import "ArticleGuideVC.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

static NSString *kTitleKey = @"VentureTitle";
static NSString *kContentKey = @"VentureContent";

@interface InvestorGuideVC ()

@end

@implementation InvestorGuideVC

#pragma mark - Http and json

- (void)logoDidLoad
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"image_logo" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:3] forKey:@"type"];
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
        if ([dic1 count] > 0) {
            NSString *stringUrl = [[dic1 objectAtIndex:0] objectForKey:@"url"];
            if (stringUrl != NULL) {
                NSURL *url = [NSURL URLWithString:stringUrl];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                self.logoImage.image = image;
            }
        }
    }
}

- (void)news_query
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"news_query" forKey:@"requestCommand"];
    
    [params setValue:[NSNumber numberWithInt:1] forKey:@"pageNo"];
    [params setValue:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInt:3] forKey:@"newstype"];
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
        self.myArray = [(NSDictionary *)resultStr objectForKey:@"data"];
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
    
    // Design the interface
    self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    [self.view addSubview:self.logoImage];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 320, 227)];
    [self.view addSubview:self.myTableView];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    // Loading the logo and news
    [self logoDidLoad];
    [self news_query];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_logoImage release];
    [_myTableView release];
    [_myArray release];
    [super dealloc];
}

#pragma mark - UITableView Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.imageView.image = [UIImage imageNamed:@"GreenStar.png"];
    cell.textLabel.text = [[self.myArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -
#pragma mark - UITableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleGuideVC *AGVC = [[ArticleGuideVC alloc] initWithNibName:@"ArticleGuideVC" bundle:nil];
    AGVC.industry_id = [[[self.myArray objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
    [self.navigationController pushViewController:AGVC animated:YES];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    
    [AGVC release];
}


@end
