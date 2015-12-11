//
//  SkillProgressView.h
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillProgressView : UIView
@property (strong,nonatomic) IBOutletCollection(UIView) NSArray *progressLabels;
@property (strong,nonatomic) NSArray *skills;
@end
