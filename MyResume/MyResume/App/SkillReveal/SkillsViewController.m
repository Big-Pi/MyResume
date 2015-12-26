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
#import "FontAwsomeImageHelper.h"

@interface SkillsViewController ()<UINavigationControllerDelegate>
@property (strong,nonatomic) MagicAnimator *animator;
@end

@implementation SkillsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tabBarItem.title=@"技能";
        self.tabBarItem.image=[FontAwsomeImageHelper skillTabbarItemImage];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skillView.animComplete=^(){
        self.navigationController.delegate=self;
        [self performSegueWithIdentifier:@"showSkillList" sender:self];
    };
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.skillView startAnim];
}

-(MagicAnimator *)animator{
    if(!_animator){
        _animator=[[MagicAnimator alloc]init];
    }
    return _animator;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: @"showSkillList"]){
        SkillProgressViewController *skillProgressVC= segue.destinationViewController;
        skillProgressVC.skills=self.skillView.allSkills;
    }
}
#pragma mark - UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    self.animator.operation=operation;
    return self.animator;
}
@end
