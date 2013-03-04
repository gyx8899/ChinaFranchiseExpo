//
//  ViewController.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "ViewController.h"
#import "TabBarVC.h"

@interface ViewController ()

@end

@implementation ViewController

//#pragma mark - TabBarDelegate
//
//- (void)tabBarDidFinish:(TabBarViewController *)controller
//{
//    ;
//}

#pragma mark - Button Methods

- (IBAction)btnSignIn:(id)sender
{
    TabBarVC *tabBarVC = [[TabBarVC alloc] initWithNibName:@"TabBarVC" bundle:nil];
    tabBarVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:tabBarVC animated:YES completion:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Set background image.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Join.png"]];
    
    // Set center button.
    RoundButton *centerButton = [RoundButton buttonWithType:UIButtonTypeCustom];
    centerButton.frame = CGRectMake(0, 0, 140, 140);
    centerButton.center = CGPointMake(160,278);
    [centerButton setImage:[UIImage imageNamed:@"CenterButton.png"] forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(btnSignIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
