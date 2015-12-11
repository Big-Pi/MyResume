//
//  SkillView.h
//  SkillReveal
//
//  Created by pi on 15/11/30.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface SkillView : UIView
@property (strong,nonatomic) NSArray *allSkills;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *skillLabels;
@property (copy,nonatomic) void(^animComplete)();
@end
