//
//  TimeLineDotLineView.h
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineDotLineView : UIView
@property (assign,nonatomic) BOOL hideLine;
@property (strong,nonatomic,readonly) UIColor *dotColor;
-(void)setHideLine:(BOOL)hideLine anim:(BOOL)anim;
@end
