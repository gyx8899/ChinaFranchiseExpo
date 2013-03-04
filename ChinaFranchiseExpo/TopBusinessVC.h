//
//  TopBusinessVC.h
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBusinessVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UIImageView *logoImage;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) UITableView *myTableView;

@end
