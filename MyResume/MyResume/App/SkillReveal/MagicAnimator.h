//
//  MagicAnimator.h
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface MagicAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (assign,nonatomic) UINavigationControllerOperation operation;
@end
