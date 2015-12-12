//
//  MagicAnimator.m
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "MagicAnimator.h"
#import "SkillsViewController.h"
#import "SkillProgressViewController.h"
#import "SkillView.h"
#import "SkillProgressView.h"
#import "ProgressLabel.h"
#import "MainViewController.h"

@interface MagicAnimator ()
@property (strong,nonatomic) NSMutableArray *animCompleteLabels;
@property (assign,nonatomic)CGFloat duration;
@end

@implementation MagicAnimator

-(CGFloat)duration{
    if(_duration==0.0){
        _duration=2.0;
    }
    return _duration;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self.animCompleteLabels removeAllObjects];
    //!!为什么fromVC是MainViewcontroller！
    //而不是 SkillsViewController
    MainViewController *mainVC= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SkillsViewController *fromVC;
    for(UIViewController *vc in mainVC.viewControllers){
        if([vc isMemberOfClass:[SkillsViewController class]]){
            fromVC=(SkillsViewController*)vc;
        }
    }
    SkillProgressViewController *toVC= [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView= [transitionContext containerView];
    //
    NSArray *fromLabels= fromVC.skillView.skillLabels;
    NSArray *progressLabels= toVC.skillProgrssView.progressLabels;
    //
    [containerView addSubview:toVC.view];
    [toVC.view snapshotViewAfterScreenUpdates:YES];//big hack here to force toVC.view update subViews
    
    //anim every skill label
    for (int i=0;i<fromLabels.count; i++) {
        UILabel *fLabel=fromLabels[i];
        ProgressLabel *progressLabel=progressLabels[i];
        UILabel *tLabel= progressLabel.nameLabel;
        
        [progressLabel bringSubviewToFront:tLabel];
        CGRect fromRect=[progressLabel convertRect:fLabel.bounds fromView:fLabel];
        CGRect toRect=tLabel.frame;
        // prepare for anim
        tLabel.frame=fromRect;
        progressLabel.backgroundColor=[UIColor clearColor];
        progressLabel.progressView.alpha=0.0;
        [UIView animateWithDuration:self.duration/2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            tLabel.frame=toRect;
            progressLabel.backgroundColor=[UIColor whiteColor];
        } completion:^(BOOL finished) {
            //anim progress view constraint
            CGFloat progressWidth= progressLabel.progressView.bounds.size.width;
            progressLabel.equalWidthConstraint.constant=-progressWidth/1.1;
            [progressLabel layoutIfNeeded];
            [UIView animateWithDuration:self.duration/2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                progressLabel.progressView.alpha=1.0;
                progressLabel.equalWidthConstraint.constant=0;
                [progressLabel layoutIfNeeded];
            } completion:^(BOOL finished) {
                //all the label anim complete: so completeTransition
                [self.animCompleteLabels addObject:tLabel];
                if(self.animCompleteLabels.count==progressLabels.count){
                    [transitionContext completeTransition:YES];
                }
            }];
            
        }];
    }
    
    
//    for (int i=0;i<fromLabels.count; i++) {
//        UILabel *fLabel=fromLabels[i];
//        UILabel *tLabel=toLabels[i];
//        UIView *snipShot= [fLabel snapshotViewAfterScreenUpdates:YES];
//        [containerView addSubview: snipShot];
//        CGRect fromRect=fLabel.frame;
////        CGRect toRect=tLabel.frame;
//        CGRect toRect= [containerView convertRect:tLabel.frame fromView:tLabel.superview];
//        
//        snipShot.frame=fromRect;
//        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            snipShot.frame=toRect;
//        } completion:^(BOOL finished) {
//            [self.animCompleteLabels addObject:tLabel];
//            if(self.animCompleteLabels.count==toLabels.count){
//                [transitionContext completeTransition:YES];
//            }
//        }];
//    }
    
}

-(NSMutableArray *)animCompleteLabels{
    if(!_animCompleteLabels){
        _animCompleteLabels=[NSMutableArray array];
    }
    return _animCompleteLabels;
}
@end
