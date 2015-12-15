//
//  SkillProgressViewController.h
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SkillProgressView;

@interface SkillProgressViewController : UIViewController
@property (weak, nonatomic) IBOutlet SkillProgressView *skillProgrssView;
@property (strong,nonatomic) NSArray *skills;
@end
