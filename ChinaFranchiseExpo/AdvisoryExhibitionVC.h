//
//  AdvisoryExhibitionVC.h
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryExhibitionVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *advisoryArray;

@property (nonatomic, retain) UIImageView *logoImage;

@property (nonatomic, retain) UITableView *myTableView;

@end
