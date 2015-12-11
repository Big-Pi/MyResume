//
//  DateFormatter.m
//  TimeLineTableView
//
//  Created by pi on 15/11/25.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "DateFormatter.h"

@interface DateFormatter ()
@property (strong,nonatomic) NSDateFormatter *date2Str;
@property (strong,nonatomic) NSDateFormatter *str2Date;
@end

@implementation DateFormatter

-(NSDateFormatter *)date2Str{
    if(!_date2Str){
        _date2Str=[[NSDateFormatter alloc]init];
        [_date2Str setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
        [_date2Str setDateFormat:@"yyyy MMMM"];
    }
    return _date2Str;
}

-(NSDateFormatter *)str2Date{
    if(!_str2Date){
        _str2Date=[[NSDateFormatter alloc]init];
        [_str2Date setDateFormat:@"yyyy.MM"];
    }
    return  _str2Date;
}

+(instancetype)sharedFromatter{
    static dispatch_once_t onceToken;
    static id formatter;
    dispatch_once(&onceToken, ^{
        formatter=[[self class]new];
    });
    return formatter;
}

-(NSArray*)yearAndMonthFromDate:(NSDate*)date{
    NSString *yearAndMonth= [self.date2Str stringFromDate:date];
    NSArray *yearMonthArray=[yearAndMonth componentsSeparatedByString:@" "];
    return yearMonthArray;
}

-(NSDate*)dateFromYearAndMonthStr:(NSString*)str{
    return [self.str2Date dateFromString:str];
}

-(NSArray*)yearMonthFromStr:(NSString*)str{
    return [self yearAndMonthFromDate:[self dateFromYearAndMonthStr:str]];
}
@end
