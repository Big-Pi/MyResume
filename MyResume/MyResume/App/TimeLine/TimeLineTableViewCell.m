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

@end

@implementation TimeLineTableViewCell
-(void)prepareForReuse{
    [super prepareForReuse];
}

-(void)setHideLine:(BOOL)hideLine{
    self.dotLineView.hideLine=hideLine;
}

-(BOOL)hideLine{
    return self.dotLineView.hideLine;
}

#pragma mark - Getter Setter
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
