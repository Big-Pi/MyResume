//
//  UIColor+PiRandomColor.m
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "UIColor+PiRandomColor.h"
#import "Chameleon.h"

static UIColor *lastColor;

@implementation UIColor (PiRandomColor)

+(UIColor *)randomColor{
    return [UIColor randomFlatColor];
}
@end
