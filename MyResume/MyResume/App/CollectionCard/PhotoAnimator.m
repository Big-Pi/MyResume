//
//  PhotoAnimator.m
//  MyResume
//
//  Created by pi on 15/12/27.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "PhotoAnimator.h"
#import "PhotoViewController.h"
#import "CollectionCardViewController.h"
#import "ColorCollectionCell.h"
#import "MainViewController.h"

@interface PhotoAnimator ()
@property (assign,nonatomic) NSTimeInterval duration;
@end

@implementation PhotoAnimator

-(NSTimeInterval)duration{
    if(_duration==0.0){
        _duration=0.35;
    }
    return _duration;
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView= [transitionContext containerView];
    if(self.presenting){
        PhotoViewController *photoVC=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //
        [containerView addSubview:photoVC.view];
        [photoVC.view layoutIfNeeded];
        //
        UIImageView *animView=photoVC.imageView;
        CGPoint toCenter=animView.center;
        CGPoint fromCenter=CGPointMake(CGRectGetMidX(self.originalFrame), CGRectGetMidY(self.originalFrame));
        CGFloat xScale=self.originalFrame.size.width/animView.frame.size.width;
        CGFloat yScale=self.originalFrame.size.height/animView.frame.size.height;
        //
        animView.center=fromCenter;
        animView.transform=CGAffineTransformMakeScale(xScale, yScale);
        //
        [UIView animateWithDuration:self.duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animView.center=toCenter;
            animView.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{
        MainViewController *mainVC= (MainViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        PhotoViewController *photoVC= (PhotoViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        //
        CollectionCardViewController *cardVC;
        for (UIViewController *vc in mainVC.childViewControllers) {
            if([vc isMemberOfClass:[UINavigationController class]]){
                UINavigationController *navVC=(UINavigationController*)vc;
                UIViewController *topVC= navVC.topViewController;
                if([topVC isMemberOfClass:[CollectionCardViewController class]]){
                    cardVC=(CollectionCardViewController*)topVC;
                }
            }
        }
        UIImageView *animView=cardVC.selectedCell.archivementImageView;
        
        UIView *originalSuper= cardVC.view.superview;
        [containerView addSubview:cardVC.view];
        [cardVC.view layoutIfNeeded];
        //
        CGPoint fromCenter= [photoVC.imageView.superview convertPoint:photoVC.imageView.center toView:animView.superview];
        
        CGPoint toCenter=animView.center;
        CGFloat xScale=photoVC.imageView.frame.size.width/animView.frame.size.width;
        CGFloat yScale=photoVC.imageView.frame.size.height/animView.frame.size.height;
        //
        animView.center=fromCenter;
        animView.transform=CGAffineTransformMakeScale(xScale, yScale);
        //
        [UIView animateWithDuration:self.duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animView.center=toCenter;
            animView.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [originalSuper addSubview:cardVC.view];
            [transitionContext completeTransition:YES];
        }];
    }
    
}
@end
