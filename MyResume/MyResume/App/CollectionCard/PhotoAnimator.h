//
//  PhotoAnimator.h
//  MyResume
//
//  Created by pi on 15/12/27.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface PhotoAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (assign,nonatomic) CGRect originalFrame;
@property (assign,nonatomic) BOOL presenting;
@end
