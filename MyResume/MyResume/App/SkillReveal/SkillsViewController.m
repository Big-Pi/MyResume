//
//  SkillsViewController.m
//  SkillReveal
//
//  Created by pi on 15/11/30.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "SkillsViewController.h"
#import "SkillView.h"
#import "SkillProgressViewController.h"
#import "MagicAnimator.h"

@interface SkillsViewController ()<UIViewControllerTransitioningDelegate>
@property (strong,nonatomic) MagicAnimator *animator;
@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skillView.animComplete=^(){
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"SkillReveal" bundle:nil];
        SkillProgressViewController *spvc= [sb instantiateViewControllerWithIdentifier:@"SkillProgressViewController"];
        spvc.animLabels=self.skillView.skillLabels;
        spvc.skills=self.skillView.allSkills;
        spvc.transitioningDelegate=self;
        [self presentViewController:spvc animated:YES completion:nil];
    };
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(MagicAnimator *)animator{
    if(!_animator){
        _animator=[[MagicAnimator alloc]init];
    }
    return _animator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.animator;
}
@end
