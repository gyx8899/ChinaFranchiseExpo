//
//  InvestorGuideVC.h
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestorGuideVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UIImageView *logoImage;

@property (nonatomic, retain) UITableView *myTableView;

@property (nonatomic, retain) NSMutableArray *myArray;

@end
