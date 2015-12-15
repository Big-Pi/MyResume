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
    BOOL isShowUp=self.operation==UINavigationControllerOperationPush;
    
    UIView *containerView= [transitionContext containerView];
    UIViewController *fromVC=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if(isShowUp){
        [containerView addSubview:toVC.view];
        
        SkillsViewController *skillVC=(SkillsViewController*)fromVC;
        SkillProgressViewController *skillProgressVC=(SkillProgressViewController*)toVC;
        //
        NSArray *fromLabels= skillVC.skillView.skillLabels;
        NSArray *toLabels= skillProgressVC.skillProgrssView.progressLabels;
        //
        [skillProgressVC.view layoutIfNeeded];
    
        //anim every skill label
        for (int i=0;i<fromLabels.count; i++) {
            UILabel *fLabel=fromLabels[i];
            ProgressLabel *progressLabel=toLabels[i];
            UILabel *tLabel= progressLabel.nameLabel;
    
            [progressLabel bringSubviewToFront:tLabel];

            CGPoint fromP=[progressLabel convertPoint:fLabel.center fromView:fLabel.superview];
            CGPoint toP=tLabel.center;
            // prepare for anim
            
            tLabel.center=fromP;
            progressLabel.backgroundColor=[UIColor clearColor];
            progressLabel.progressView.alpha=0.0;
            [UIView animateWithDuration:self.duration/2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                tLabel.center=toP;
            } completion:^(BOOL finished) {
                //anim progress view constraint
                CGFloat progressWidth= progressLabel.progressView.bounds.size.width;
                progressLabel.equalWidthConstraint.constant=-progressWidth/1.1;
                [progressLabel layoutIfNeeded];
                [UIView animateWithDuration:self.duration/2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    progressLabel.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.85];
                    progressLabel.progressView.alpha=1.0;
                    progressLabel.equalWidthConstraint.constant=0;
                    [progressLabel layoutIfNeeded];
                } completion:^(BOOL finished) {
                    //all the label anim complete: so completeTransition
                    [self.animCompleteLabels addObject:tLabel];
                    if(self.animCompleteLabels.count==toLabels.count){
                        [transitionContext completeTransition:YES];
                    }
                }];
                
            }];
        }
    }else{
        
        SkillsViewController *skillVC=(SkillsViewController*)toVC;
        SkillProgressViewController *skillProgressVC=(SkillProgressViewController*)fromVC;
        //
        NSArray *toLabels= skillVC.skillView.skillLabels;
        NSArray *fromLabels= skillProgressVC.skillProgrssView.progressLabels;
        //
        [skillProgressVC.view layoutIfNeeded];
        
        //anim every skill label
        for (int i=0;i<fromLabels.count; i++) {
            UILabel *tLabel=toLabels[i];
            ProgressLabel *progressLabel=fromLabels[i];
            UILabel *fLabel= progressLabel.nameLabel;
            
            [progressLabel bringSubviewToFront:tLabel];
            
            CGPoint fromP=[containerView convertPoint:fLabel.center fromView:fLabel.superview];
            CGPoint toP=tLabel.center;
            // prepare for anim
            tLabel.center=fromP;
            
            //
            CGFloat progressWidth= progressLabel.progressView.bounds.size.width;
            [UIView animateWithDuration:self.duration/2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                progressLabel.progressView.alpha=0.0;
                progressLabel.backgroundColor=[UIColor clearColor];
                progressLabel.equalWidthConstraint.constant=-progressWidth/1.1;
                [progressLabel layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:self.duration/2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [containerView addSubview:toVC.view];
                    tLabel.center=toP;
                } completion:^(BOOL finished) {
                    [self.animCompleteLabels addObject:tLabel];
                    if(self.animCompleteLabels.count==toLabels.count){
                        [transitionContext completeTransition:YES];
                    }
                }];
            }];
        }
    }
}


-(NSMutableArray *)animCompleteLabels{
    if(!_animCompleteLabels){
        _animCompleteLabels=[NSMutableArray array];
    }
    return _animCompleteLabels;
}
@end
