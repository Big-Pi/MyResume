//
//  TimeLineDotLineView.m
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "TimeLineDotLineView.h"
#import "UIColor+PiRandomColor.h"

@interface TimeLineDotLineView ()
@property (strong,nonatomic) UIColor *dotColor;
@property (assign,nonatomic) CGFloat paddingLeftRightTop;
//
@property (strong,nonatomic) UIBezierPath *path;
@property (strong,nonatomic) UIBezierPath *dotPath;
@property (strong,nonatomic) UIBezierPath *linePath;
@property (assign,nonatomic) CGRect dotRectRef;
@end

@implementation TimeLineDotLineView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self privateInit];
        self.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self privateInit];
}

-(void)privateInit{
    self.paddingLeftRightTop=self.bounds.size.width/10.0;
}

-(UIBezierPath *)dotPath{
    
    CGPoint dotOrigin= CGPointMake(self.bounds.origin.x+2*self.paddingLeftRightTop,self.paddingLeftRightTop);
    CGFloat dotWidth=self.bounds.size.width-4*self.paddingLeftRightTop;
    CGSize dotSize=CGSizeMake(dotWidth, dotWidth);
    CGRect dotRect=CGRectMake(dotOrigin.x, dotOrigin.y, dotSize.width, dotSize.height);
    self.dotRectRef=dotRect;
    _dotPath=[UIBezierPath bezierPathWithOvalInRect:dotRect];
    return _dotPath;
}

-(UIBezierPath *)linePath{
    if(!_linePath){
        
        CGFloat lineY=CGRectGetMaxY(self.dotRectRef) +self.paddingLeftRightTop;
        CGPoint lineOrigin=CGPointMake(self.bounds.origin.x+self.bounds.size.width/3, lineY);
        CGSize lineSize=CGSizeMake(self.bounds.size.width/3, self.bounds.size.height-30);
        CGRect lineRect=CGRectMake(lineOrigin.x, lineOrigin.y, lineSize.width, lineSize.height);
        _linePath=[UIBezierPath bezierPathWithRect:lineRect];
    }
    return _linePath;
}

- (void)drawRect:(CGRect)rect {
    [self.dotColor setFill]; //TODO animate dot colors
    [self.dotPath fill];
    if(self.hideLine){
        return;
    }
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]setFill];
    [self.linePath fill];
}


-(UIColor *)dotColor{
    if(!_dotColor){
        _dotColor=[UIColor randomColor];
    }
    return _dotColor;
}

-(void)setHideLine:(BOOL)hideLine{
    _hideLine=hideLine;
    [self setNeedsDisplay];
}


@end
