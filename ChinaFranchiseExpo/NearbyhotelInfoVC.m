//
//  NearbyHotelInfoVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "NearbyHotelInfoVC.h"
#import "HotelTableCell.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

static NSString *kHotelName = @"HotelName";
static NSString *kStarLevel = @"StarLevel";
static NSString *kReservationCall = @"ReservationCall";
static NSString *kAddress = @"Address";

@interface NearbyHotelInfoVC ()

@end

@implementation NearbyHotelInfoVC

- (void)hotel_query
{
    NSURL * url=[NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"hotel_query" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"pageNo"];
    [params setValue:[NSNumber numberWithInt:5] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"exhibitionid"];
    
    // convert to JSON string
    NSString* jsonString = [params JSONRepresentation];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    NSString *result = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    
    NSObject *resultStr = [result JSONValue];
    if ([resultStr isKindOfClass:[NSDictionary class]])
    {
        self.myArray = [(NSDictionary *)resultStr objectForKey:@"data"];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hotel_query];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_myArray release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.myArray count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    HotelTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HotelTableCell" owner:self options:nil];
        if([[nib objectAtIndex:0] isKindOfClass:[HotelTableCell class]])
        {
            cell = [nib objectAtIndex:0];
        }
    }
    NSDictionary *dic = [self.myArray objectAtIndex:indexPath.section];
    cell.hotelName.text = [dic objectForKey:@"name"];
    cell.starLevel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"star"]];
    cell.reservationCall.text = [dic objectForKey:@"phone"];
    cell.address.text = [dic objectForKey:@"address"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
@end
