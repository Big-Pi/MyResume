//
//  ProgressLabel.h
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Skill.h"

@interface ProgressLabel : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (strong,nonatomic) Skill *skill;
@property (weak, nonatomic) NSLayoutConstraint *equalWidthConstraint;
@property (weak, nonatomic) IBOutlet UIView *progressView;

-(NSComparisonResult)sortHackByTag:(id)another;
@end
