//
//  MagicTransitionSegue.m
//  MyResume
//
//  Created by pi on 15/12/9.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "MagicTransitionSegue.h"
#import "TextPathHelper.h"
#import "HandWrittingViewController.h"

@implementation MagicTransitionSegue
-(void)perform{
    
    UIView *destView=self.destinationViewController.view;
    UIView *sourceView= self.sourceViewController.view;
    HandWrittingViewController *sourceVC= self.sourceViewController;
    //
    [sourceView addSubview:destView];
    
    //add maskView
    CAShapeLayer *l= [TextPathHelper textLayerWithText:@"Pi" frame:destView.bounds];
    UIView *maskView= [[UIView alloc]initWithFrame:destView.frame];
    [maskView.layer addSublayer:l];
    destView.maskView=maskView;
    //prepare for anim
    destView.alpha=0.1;
    maskView.alpha=0.8;
    CGAffineTransform transform= CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, 10), CGAffineTransformMakeScale(80.0, 80.0));
    //
    [UIView animateWithDuration:4.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        sourceVC.pathLayer.hidden=YES;
        maskView.transform=transform;
        destView.alpha=1.0;
    } completion:^(BOOL finished) {
        //remove text maskView
        destView.maskView=nil;
        //fade in destView
        destView.alpha=0.2;
        [UIView animateWithDuration:1.0 animations:^{
            destView.alpha=1.0;
        } completion:^(BOOL finished) {
            sourceVC.pathLayer.hidden=NO;
            [[self sourceViewController]presentViewController:[self destinationViewController] animated:NO completion:nil];
        }];
        
    }];
}

@end
