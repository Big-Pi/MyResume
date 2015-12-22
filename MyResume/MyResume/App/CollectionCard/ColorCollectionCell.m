//
//  ColorCollectionCell.m
//  
//
//  Created by pi on 15/11/20.
//
//

#import "ColorCollectionCell.h"

@interface ColorCollectionCell ()

@property (assign,nonatomic) CGPoint panLastPoint;
@property (assign,nonatomic) CGPoint panStartPoint;
@property (assign,nonatomic) CGFloat xDeltaToDelete;
@property (assign,nonatomic) CGFloat yDeltaToDelete;

@end

@implementation ColorCollectionCell

- (void)awakeFromNib {
    UIPanGestureRecognizer *pan= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //
    self.xDeltaToDelete=self.bounds.size.width/1.6;
    self.yDeltaToDelete=self.bounds.size.height*2.2/5.0;
    //在这设置阴影 此时自己的bounds已经由autolayout设置完了。。在awakefromnib里self.bounds＝50*50;
//    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    self.colorView.layer.cornerRadius=25;
    self.archivementImageView.layer.cornerRadius=25;
    self.archivementImageView.clipsToBounds=YES;
    self.layer.shadowOffset=CGSizeMake(1, -1);
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowRadius=6;
    self.layer.cornerRadius=25;
    self.layer.shadowOpacity=0.3;
    self.layer.masksToBounds=NO;
    //    NSLog(@"%@",NSStringFromCGRect(self.colorView.frame));
    //不设置这个非常卡。。模拟器
    self.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    //把layer渲染成image 据说不卡。。边缘平滑了。。但是非常卡。。模拟器
        self.layer.shouldRasterize=YES;
        self.layer.rasterizationScale=[UIScreen mainScreen].scale;
}


- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    CGPoint currentPoint=[sender translationInView:self];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            self.panStartPoint=currentPoint;
            self.panLastPoint=currentPoint;
            if([self.delegate respondsToSelector:@selector(ColorCollectionCell:beginPan:)]){
                [self.delegate ColorCollectionCell:self  beginPan:currentPoint];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            self.transform=CGAffineTransformTranslate(self.transform,currentPoint.x-self.panLastPoint.x, currentPoint.y-self.panLastPoint.y);
            self.panLastPoint=currentPoint;
            if([self.delegate respondsToSelector:@selector(ColorCollectionCell:panning:)]){
                [self.delegate ColorCollectionCell:self panning:currentPoint];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            CGFloat finalDeltaX=currentPoint.x-self.panStartPoint.x;
            CGFloat finalDeltaY=currentPoint.y-self.panStartPoint.y;
            if(fabs(finalDeltaX)>self.xDeltaToDelete || fabs(finalDeltaY)>self.yDeltaToDelete){
                //移动一定的距离。。就是删除cell
                if([self.delegate respondsToSelector:@selector(ColorCollectionCell:delete:)]){
                    [self.delegate ColorCollectionCell:self delete:CGVectorMake(finalDeltaX, finalDeltaY)];
                }
            }else{
                if([self.delegate respondsToSelector:@selector(ColorCollectionCell:endPan:)]){
                    [self.delegate ColorCollectionCell:self endPan:currentPoint];
                }
            }
            break;
        }
        case  UIGestureRecognizerStatePossible:
            break;
    }
}

@end
