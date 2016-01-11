//
//  TimeLineTableViewCell.m
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "TimeLineTableViewCell.h"
#import "TimeLineDotLineView.h"
#import "DateFormatter.h"

@interface TimeLineTableViewCell ()
@property (weak, nonatomic) IBOutlet TimeLineDotLineView *dotLineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

@end

@implementation TimeLineTableViewCell

@dynamic hideLine;

-(void)prepareForReuse{
    [super prepareForReuse];
}

#pragma mark - Getter Setter
-(BOOL)hideLine{
    return  self.dotLineView.hideLine;
}

-(void)setHideLine:(BOOL)hideLine{
    [self setHideLine:hideLine anim:NO];
}

-(void)setHideLine:(BOOL)hideLine anim:(BOOL)anim{
    [self.dotLineView setHideLine:hideLine anim:anim];
}

-(void)setCategoryImage:(UIImage*)image{
    self.categoryImageView.image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.categoryImageView.tintColor=self.dotLineView.dotColor;
}

-(void)setDate:(NSString *)yearAndMonth{
    NSArray *yearMonth= [[DateFormatter sharedFromatter]yearMonthFromStr:yearAndMonth];
    self.yearLabel.text= yearMonth[0];
    self.monthLabel.text=yearMonth[1];
}

-(void)setTitle:(NSString *)title{
    self.titleLabel.text=title;
}

-(void)setCategory:(NSString *)category{
    self.categoryLabel.textColor=self.dotLineView.dotColor;
    self.categoryLabel.text=category;
}
@end
