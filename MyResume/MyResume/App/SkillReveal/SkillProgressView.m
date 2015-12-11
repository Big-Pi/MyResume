//
//  SkillProgressView.m
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "SkillProgressView.h"
#import "ProgressLabel.h"

@interface SkillProgressView ()

@end

@implementation SkillProgressView

-(void)setSkills:(NSArray *)skills{
    _skills=skills;
    self.progressLabels = [self.progressLabels sortedArrayUsingSelector:@selector(sortHackByTag:)];
    for (int i=0; i<_skills.count; i++) {
        ProgressLabel *pl= self.progressLabels[i];
        pl.skill=_skills[i];
    }
}

@end
