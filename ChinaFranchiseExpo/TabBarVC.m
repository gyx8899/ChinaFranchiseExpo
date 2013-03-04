//
//  TabBarVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "TabBarVC.h"
#import "AdvisoryExhibitionVC.h"
#import "JoinBrandLibraryVC.h"
#import "JoinTableViewVC.h"
#import "InvestorGuideVC.h"
#import "VentureShareVC.h"
#import "ExhibitonIntroduceVC.h"
#import "TopBusinessVC.h"
#import "AdvanceActivitiesVC.h"
#import "Ivan_UITabBar.h"

@interface TabBarVC ()

@end

@implementation TabBarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Methods

- (void)tabBarDidload
{
    AdvisoryExhibitionVC *AEVC = [[AdvisoryExhibitionVC alloc] init];
    AEVC.title = @"展会资讯";
    AEVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"展会资讯" image:[UIImage imageNamed:@""] tag:101];
    AEVC.tabBarItem.image = [UIImage imageNamed:@"TabBarZhuYe.png"];
    
    JoinBrandLibraryVC *JBVC = [[JoinBrandLibraryVC alloc] init];
    JBVC.title = @"加盟品牌库";
    JBVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"加盟品牌库" image:[UIImage imageNamed:@""] tag:102];
    JBVC.tabBarItem.image = [UIImage imageNamed:@"TabBarJiaMeng.png"];
    
    JoinTableViewVC *JTVC = [[JoinTableViewVC alloc] init];
    JTVC.title = @"我要参与";
    JTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我要参与" image:[UIImage imageNamed:@""] tag:103];
    JTVC.tabBarItem.image = [UIImage imageNamed:@"TabBarCanYuH.png"];
    
    InvestorGuideVC *IGVC = [[InvestorGuideVC alloc] init];
    IGVC.title = @"投资指导";
    IGVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"投资指导" image:[UIImage imageNamed:@""] tag:104];
    IGVC.tabBarItem.image = [UIImage imageNamed:@"TabBarTouzi.png"];
    
    VentureShareVC *VSVC = [[VentureShareVC alloc] init];
    VSVC.title = @"创业分享";
    VSVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"创业分享" image:[UIImage imageNamed:@""] tag:105];
    VSVC.tabBarItem.image = [UIImage imageNamed:@"TabBarChuangYe.png"];
    
    ExhibitonIntroduceVC *EIVC = [[ExhibitonIntroduceVC alloc] init];
    EIVC.title = @"展会介绍";
    EIVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"展会介绍" image:[UIImage imageNamed:@""] tag:106];
    EIVC.tabBarItem.image = [UIImage imageNamed:@"NavBarIcon5.png"];
    
    TopBusinessVC *TBVC = [[TopBusinessVC alloc] init];
    TBVC.title = @"商机头条";
    TBVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商机头条" image:[UIImage imageNamed:@""] tag:107];
    TBVC.tabBarItem.image = [UIImage imageNamed:@"NavBarIcon2.pnpg"];
    
    AdvanceActivitiesVC *AAVC = [[AdvanceActivitiesVC alloc] init];
    AAVC.title = @"活动预告";
    AAVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动预告" image:[UIImage imageNamed:@""] tag:108];
    AAVC.tabBarItem.image = [UIImage imageNamed:@"NavBarIcon8.png"];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:AEVC];
    [AEVC release];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:JBVC];
    [JBVC release];
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:JTVC];
    [JTVC release];
    
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:IGVC];
    [IGVC release];
    
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:VSVC];
    [VSVC release];
    
    UINavigationController *nav6 = [[UINavigationController alloc] initWithRootViewController:EIVC];
    [EIVC release];
    
    UINavigationController *nav7 = [[UINavigationController alloc] initWithRootViewController:TBVC];
    [TBVC release];
    
    UINavigationController *nav8 = [[UINavigationController alloc] initWithRootViewController:AAVC];
    
    NSArray *controllersArray = [[NSArray alloc] initWithObjects:nav1,nav2,nav3,nav4,nav5,nav6,nav7,nav8, nil];
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    [nav5 release];
    [nav6 release];
    [nav7 release];
    [nav8 release];
    
    for (UINavigationController *nav in controllersArray) {
        if ([UINavigationBar instancesRespondToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBack.png"] forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    self.tabBarVC = [[UITabBarController alloc] init];
    self.tabBarVC.viewControllers = controllersArray;
    [controllersArray release];
    
    self.tabBarVC.selectedIndex = 0;
    self.tabBarVC.view.frame = CGRectMake(0, 0, 320, 460);
    [self.view addSubview:self.tabBarVC.view];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self tabBarDidload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_tabBarVC release];
    [super dealloc];
}

@end
