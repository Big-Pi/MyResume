//
//  Experience.m
//  TimeLineTableView
//
//  Created by pi on 15/11/25.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "Experience.h"


@interface Experience ()
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *content;
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *category;

@end

@implementation Experience
+(NSArray*)allExperience{
    NSURL *url= [[NSBundle mainBundle]URLForResource:@"timeLine" withExtension:@"plist"];
    
    NSArray *rawAllExperience=[NSArray arrayWithContentsOfURL:url];
    NSMutableArray *allExperience=[NSMutableArray array];
    
    for (NSArray *rawYearExperience in rawAllExperience) {
        
        NSMutableArray *yearExperience=[NSMutableArray array];
        for(NSDictionary *expDic in rawYearExperience){
            Experience *exp=[Experience experienceWithDic:expDic];
            [yearExperience addObject:exp];
        }
        [allExperience addObject:yearExperience];
    }

    return allExperience;
}

-(NSString *)categoryStr{
    switch ([_category integerValue]) {
        case 0:
            return @"教育经历";
            break;
        case 1:
            return @"学习经历";
            break;
        case 2:
            return @"实践经验";
            break;
    }
    return nil;
}

+(instancetype)experienceWithDic:(NSDictionary *)dic{
    Experience *exp=[[Experience alloc]init];
    exp.time = dic[@"time"];
    exp.content=dic[@"content"];
    exp.title=dic[@"title"];
    exp.img=dic[@"img"];
    exp.category=dic[@"category"];
    return exp;
}

-(NSString *)yearStr{
    return [_time componentsSeparatedByString:@"."][0];
}
@end
