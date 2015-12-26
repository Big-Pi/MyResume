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
@property (strong,nonatomic) CAShapeLayer *dotLayer;
@property (strong,nonatomic) CAShapeLayer *lineLayer;

@end

@implementation TimeLineDotLineView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self privateInit];
        _dotColor=[UIColor randomColor];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self privateInit];
}

-(void)privateInit{
//    self.contentMode=UIViewContentModeRedraw;
    self.paddingLeftRightTop=self.bounds.size.width/10.0;
    
    static CGColorRef lineColor;
    if(!lineColor){
        lineColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    }
    //
    self.dotLayer=[CAShapeLayer layer];
    self.dotLayer.path=self.dotPath.CGPath;
    self.dotLayer.fillColor=self.dotColor.CGColor;
    [self.layer addSublayer:self.dotLayer];
    //
    self.lineLayer=[CAShapeLayer layer];
    self.lineLayer.path=self.linePath.CGPath;
    self.lineLayer.fillColor=lineColor;
    [self.layer addSublayer:self.lineLayer];
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
        CGSize lineSize=CGSizeMake(self.bounds.size.width/3, self.bounds.size.height-self.paddingLeftRightTop*2-self.dotRectRef.size.height);
        CGRect lineRect=CGRectMake(lineOrigin.x, lineOrigin.y, lineSize.width, lineSize.height);
        _linePath=[UIBezierPath bezierPathWithRect:lineRect];
    }
    return _linePath;
}

-(void)setHideLine:(BOOL)hideLine anim:(BOOL)anim{
    _hideLine=hideLine;
    if(_hideLine){
        self.lineLayer.opacity=0.0;
    }else{
        self.lineLayer.opacity=1.0;
        if(anim){
            CABasicAnimation *alphaAnim=[CABasicAnimation animationWithKeyPath:@"opacity"];
            alphaAnim.fromValue=@0.0;
            alphaAnim.toValue=@1.0;
            alphaAnim.duration=1.0;
            [self.lineLayer addAnimation:alphaAnim forKey:nil];
        }
    }
}


@end
