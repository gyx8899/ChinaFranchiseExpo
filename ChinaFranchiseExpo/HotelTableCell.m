//
//  HotelTableCell.m
//  ChinaFranchiseExpo
//
//  Created by user on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelTableCell.h"

@implementation HotelTableCell
@synthesize hotelName;
@synthesize starLevel;
@synthesize reservationCall;
@synthesize address;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [hotelName release];
    [starLevel release];
    [reservationCall release];
    [address release];
    [super dealloc];
}
@end
