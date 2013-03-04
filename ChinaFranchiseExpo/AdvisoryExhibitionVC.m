//
//  AdvisoryExhibitionVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "AdvisoryExhibitionVC.h"
#import "ExhibitonIntroduceVC.h"
#import "ExhibitionLocationVC.h"
#import "BusLineVC.h"
#import "SubwayLineVC.h"
#import "NearbyhotelInfoVC.h"
#import "HistoryReviewVC.h"
#import "AdvanceActivitiesVC.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

static NSString *kTitleKey = @"title";
static NSString *kViewControllerKey = @"viewController";

@interface AdvisoryExhibitionVC ()

@end

@implementation AdvisoryExhibitionVC

- (void)tableViewDidLoad
{
    //设置Nav的背景图片
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBack.png"]]];
    self.title = @"展会咨询";
    
    //创建ViewController的数组，并添加到TabBarController
    self.advisoryArray = [NSMutableArray array];
    
    ExhibitionLocationVC *LocVC = [[ExhibitionLocationVC alloc]initWithNibName:@"ExhibitionLocationVC" bundle:nil];
    [self.advisoryArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"展馆位置",kTitleKey,LocVC,kViewControllerKey, nil]];
    [LocVC release];
    
    BusLineVC *BusVC = [[BusLineVC alloc]initWithNibName:@"BusLineVC" bundle:nil];
    [self.advisoryArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"乘车路线",kTitleKey,BusVC,kViewControllerKey, nil]];
    [BusVC release];
    
    SubwayLineVC *subVC = [[SubwayLineVC alloc] initWithNibName:@"SubwayLineVC" bundle:nil];
    [self.advisoryArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"地铁路线",kTitleKey,subVC,kViewControllerKey, nil]];
    [subVC release];
    
    NearbyHotelInfoVC *nearHVC = [[NearbyHotelInfoVC alloc]initWithNibName:@"NearbyHotelInfoVC" bundle:nil];
    [self.advisoryArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"展馆附近酒店信息",kTitleKey,nearHVC,kViewControllerKey, nil]];
    [nearHVC release];
    
    HistoryReviewVC *hisVC = [[HistoryReviewVC alloc] initWithNibName:@"HistoryReviewVC" bundle:nil];
    [self.advisoryArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"往届回顾",kTitleKey,hisVC,kViewControllerKey, nil]];
    [hisVC release];
    
    UIBarButtonItem *ExhibitionIntroduce = [[[UIBarButtonItem alloc] initWithTitle:@"展会介绍" style:UIBarButtonItemStyleBordered target:self action:@selector(exIntro)] autorelease];
    self.navigationItem.leftBarButtonItem = ExhibitionIntroduce;
    
    UIBarButtonItem *AdvanceActivities = [[[UIBarButtonItem alloc] initWithTitle:@"活动预告" style:UIBarButtonItemStyleBordered target:self action:@selector(advanceAc)] autorelease];
    self.navigationItem.rightBarButtonItem = AdvanceActivities;
    
    // iOS 5.0 直接设置背景; iOS 5.0以下通过Catgory 设置背景图
    if ([UINavigationBar instancesRespondToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBack.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

//进入“展会介绍”
- (void)exIntro
{
    ExhibitonIntroduceVC *EI = [[ExhibitonIntroduceVC alloc]initWithNibName:@"ExhibitonIntroduceVC" bundle:nil];
    [self.navigationController pushViewController:EI animated:YES];
    [EI release];
}

//进入“活动预告”
- (void)advanceAc
{
    AdvanceActivitiesVC *AA = [[AdvanceActivitiesVC alloc] initWithNibName:@"AdvanceActivitiesVC" bundle:nil];
    [self.navigationController pushViewController:AA animated:YES];
    [AA release];
}

//加载“展会介绍”的logo
- (void)logoDidLoad
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"image_logo" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:4] forKey:@"type"];
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
            NSURL *url2=[NSURL URLWithString:stringUrl];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url2]];
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
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 320, 227)];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    
    [self tableViewDidLoad];
    [self logoDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_advisoryArray release];
    [_logoImage release];
    [_myTableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UITableView Data Source

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.advisoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (myCell == nil) {
        myCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    myCell.imageView.image = [UIImage imageNamed:@"GreenStar.png"];
    myCell.textLabel.text = [[self.advisoryArray objectAtIndex:indexPath.row]objectForKey:kTitleKey];
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return myCell;
}

#pragma mark -
#pragma mark - UITableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *targetViewController = [[self.advisoryArray objectAtIndex:indexPath.row] objectForKey:kViewControllerKey];
    [[self navigationController] pushViewController:targetViewController animated:YES];
    targetViewController.title = @"展会资讯";
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    [temporaryBarButtonItem release];
}

@end
