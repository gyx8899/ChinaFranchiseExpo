//
//  AdvanceTableCell.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "AdvanceTableCell.h"

@implementation AdvanceTableCell
@synthesize labelName;
@synthesize labelTime;
@synthesize labelLocation;

- (void)dealloc {
    [labelName release];
    [labelTime release];
    [labelLocation release];
    [super dealloc];
}
@end
