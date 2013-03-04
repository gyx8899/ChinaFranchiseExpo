//
//  HotelTableCell.h
//  ChinaFranchiseExpo
//
//  Created by user on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelTableCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *hotelName;
@property (retain, nonatomic) IBOutlet UILabel *starLevel;
@property (retain, nonatomic) IBOutlet UILabel *reservationCall;
@property (retain, nonatomic) IBOutlet UILabel *address;

@end
