//
//  VentureShareVC.h
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VentureShareVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView *myTableView;

@property (nonatomic, retain) NSMutableArray *ventureArray;

@property (nonatomic, retain) UIImageView *logoImage;

@end
