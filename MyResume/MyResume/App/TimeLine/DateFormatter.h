//
//  DateFormatter.h
//  TimeLineTableView
//
//  Created by pi on 15/11/25.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject
+(instancetype)sharedFromatter;
-(NSArray*)yearMonthFromStr:(NSString*)str;
@end
