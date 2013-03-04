//
//  ExhibitonIntroduceVC.m
//  ChinaFranchiseExpo
//
//  Created by shou on 12-7-21.
//  Copyright (c) 2012年 Guoyingxin. All rights reserved.
//

#import "ExhibitonIntroduceVC.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Constant.h"

@interface ExhibitonIntroduceVC ()

@end

@implementation ExhibitonIntroduceVC

- (void)logoDidLoad
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"image_logo" forKey:@"requestCommand"];
    [params setValue:[NSNumber numberWithInt:5] forKey:@"type"];
    NSString *jsonString = [params JSONRepresentation];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL  URLWithString:urlString]];
    [request addRequestHeader:@"Content_type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    NSString *result = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    NSObject *resultStr = [result JSONValue];
    if ([resultStr isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray *dic1 = [(NSDictionary *)resultStr objectForKey:@"data"];
        NSString *stringUrl = [[dic1 objectAtIndex:0] objectForKey:@"url"];
        if (stringUrl != NULL) {
            NSURL *url = [NSURL URLWithString:stringUrl];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            self.logoImage.image = image;
        }
    }
}


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // iOS 5.0 直接设置背景; iOS 5.0以下通过Catgory 设置背景图
    if ([UINavigationBar instancesRespondToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBack.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    [self.view addSubview: self.logoImage];
    self.content = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 367)];
    [self.view addSubview:self.content];
    self.content.text = @"　　中国特许展，亚洲最大的特许经营专业展览会，多年来被公认为中国国特许经营领域的年度盛会，以其独一无二的专业性、权威性、规范性赢得公众的良好口碑和积极参与。中国特许展分为“北京站”和“上海站”，每年5月和9月分别在北京和上海举办。展览会期间，还将举办“中国特许加盟大会”、“特许百强CEO 高峰论坛”等系列活动，汇聚行业智慧，展望行业趋势，树立行业标杆，是业内人士分享经验与共同提升的聚会。中国特许展不仅是特许企业宣传树立品牌形象，扩大品牌影响，展望行业发展趋势，了解投资动向，招募加盟商的最佳平台，也是潜在投资人寻找加盟项目，了解加盟总部，决定投资方向的高效渠道.在未来的几年里，中国经济将持续繁荣，城市化进程不断推进，拉动内需与消费升级仍将得到政府鼓励与政策扶持，连锁企业将继续受到资本市场的青睐，连锁加盟的兴旺将是大概率事件。以此为契机，中国特许展将通过更宏大的展出规模，更严格的参展要求，更精准的媒体宣传，更周到的展览服务，更成熟的专业观众，搭起特许品牌与潜在加盟商之间的桥梁，构建招商与投资双方高效沟通的最佳平台。展会的主办单位中国连锁经营协会是特许经营领域唯一的全国性行业组织，拥有1000多家会员，一直致力于促进行业的稳定发展。我们愿与您携手，共同打造世界一流的特许加盟展览会，树立更多的中国品牌，引进更好的海外品牌，扶持更多的中小企业，创造更多的就业岗位，促进中国经济的健康发展与持续繁荣。";
    self.content.editable = NO;
    
    [self logoDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_logoImage release];
    [_content release];
    [super dealloc];
}

@end
