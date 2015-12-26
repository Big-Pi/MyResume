//
//  Experience.h
//  TimeLineTableView
//
//  Created by pi on 15/11/25.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Experience : NSObject
@property (copy,nonatomic,readonly) NSString *time;
@property (copy,nonatomic,readonly) NSString *title;
@property (copy,nonatomic,readonly) NSString *content;
@property (copy,nonatomic,readonly) NSString *img;
@property (copy,nonatomic,readonly) NSString *yearStr;
@property (copy,nonatomic,readonly) NSString *category;

+(NSArray*)allExperience;
-(NSString*)categoryStr;
@end
