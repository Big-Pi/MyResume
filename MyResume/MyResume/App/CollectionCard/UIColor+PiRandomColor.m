//
//  UIColor+PiRandomColor.m
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "UIColor+PiRandomColor.h"
#import "Colours.h"

static UIColor *lastColor;

@implementation UIColor (PiRandomColor)
+(void)initialize{
    lastColor=[UIColor randomColor];
}

+(UIColor *)randomColor{
    
    NSArray *array=@[[UIColor pinkLipstickColor], [UIColor infoBlueColor],[UIColor successColor],[UIColor grapeColor],[UIColor skyBlueColor],[UIColor pastelPurpleColor],[UIColor pastelOrangeColor]];
    UIColor *randomColor=array[arc4random()%(array.count-1)];
    //保证最新的和前一个color不同
    randomColor = [randomColor isEqual:lastColor] ? [UIColor randomColor] :randomColor;
    lastColor=randomColor;
    return randomColor;
}
@end
