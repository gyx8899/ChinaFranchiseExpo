//
//  ExhibitionLocationVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "ExhibitionLocationVC.h"
#import "LocationTableCell.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

@interface ExhibitionLocationVC ()

@end

@implementation ExhibitionLocationVC

- (void)exhibition_query
{
    NSURL * url=[NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"exhibition_query" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"pageNo"];
    [params setValue:[NSNumber numberWithInt:5] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"type"];
    
    // convert to JSON string
    NSString* jsonString = [params JSONRepresentation];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    NSString *result = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    NSObject *resultStr = [result JSONValue];
    if ([resultStr isKindOfClass:[NSDictionary class]]) {
        self.data = [(NSDictionary *)resultStr objectForKey:@"data"];
    }
    else
        NSLog(@"JSON data wrong");
}


#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 366;
    [self exhibition_query];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_data release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    LocationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LocationTableCell" owner:self options:nil];
        if ([[nib objectAtIndex:0] isKindOfClass:[LocationTableCell class]]) {
            cell = [nib objectAtIndex:0];
        }
    }
    NSString *urlImage = [[self.data objectAtIndex:indexPath.row]objectForKey:@"addressImage"];
    NSURL *url = [NSURL URLWithString:urlImage];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    cell.imageAddressView.image = image;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labelAddress.text = [[self.data objectAtIndex:indexPath.row]objectForKey:@"address"];
    return cell;
}

@end
