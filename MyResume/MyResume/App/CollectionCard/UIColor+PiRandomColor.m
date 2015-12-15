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
    static NSMutableArray *colors;
    if(!colors||colors.count==0){
        colors=[NSMutableArray array];
        [colors addObjectsFromArray:@[[UIColor flatRedColor],[UIColor flatBlueColor],[UIColor flatGreenColor],[UIColor flatOrangeColor],[UIColor flatPinkColor],[UIColor flatPurpleColor],[UIColor flatMaroonColor],[UIColor flatWatermelonColor],[UIColor flatGrayColor],[UIColor flatCoffeeColor],[UIColor flatMintColor],[UIColor flatPowderBlueColor]]];
    }
    int random= arc4random()%colors.count;
    UIColor *randomColor= colors[random];
    [colors removeObject:randomColor];
    return randomColor;
}
@end
