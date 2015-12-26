//
//  TimeLineTableViewCell.h
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineTableViewCell : UITableViewCell
@property (assign,nonatomic) BOOL hideLine;


-(void)setTitle:(NSString*)title;
-(void)setDate:(NSString*)yearAndMonth;
-(void)setCategory:(NSString *)category;
-(void)setHideLine:(BOOL)hideLine anim:(BOOL)anim;
-(void)setCategoryImage:(UIImage*)image;
@end
