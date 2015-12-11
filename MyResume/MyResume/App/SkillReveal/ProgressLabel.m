//
//  ProgressLabel.m
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "ProgressLabel.h"

@interface ProgressLabel ()

@end

@implementation ProgressLabel

-(void)setSkill:(Skill *)skill{
    _skill=skill;
    self.nameLabel.text=skill.name;
    CGFloat multiplier=[skill.progrss integerValue]/100.0;
    // little trick on storyboard
    // i set equalWidthConstraint prority to 999 which is lower than this Constraint below;
    // so that there is no Constraints conflict warnings
    NSLayoutConstraint *equalWidthConstraint=[NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.progressView.superview attribute:NSLayoutAttributeWidth multiplier:multiplier constant:0];
    self.equalWidthConstraint=equalWidthConstraint;
    equalWidthConstraint.active=YES;
//    [self layoutIfNeeded];
}

// i set tag for ProgressLabel on storyBoard to sort
// because IBOutletCollection Order is NOT guatantee
-(NSComparisonResult)sortHackByTag:(id)another{
    ProgressLabel *other=(ProgressLabel*)another;
    return self.tag>other.tag;
}
@end
