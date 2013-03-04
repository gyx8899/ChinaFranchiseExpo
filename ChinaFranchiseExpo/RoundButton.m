//
//  RoundButton.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "RoundButton.h"

@implementation RoundButton

// 按钮的点击响应区域设置在距离按钮圆心小于0.9倍半径的区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    float distance = sqrt(dx*dx + dy*dy);
    
    if (distance < 0.9*(self.bounds.size.width/2)) {
        return YES;
    } else {
        return NO;
    }
}

@end
