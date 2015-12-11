//
//  SkillProgressViewController.m
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "SkillProgressViewController.h"
#import "SkillProgressView.h"
@interface SkillProgressViewController ()


@end

@implementation SkillProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skillProgrssView.skills=self.skills;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
