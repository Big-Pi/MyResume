//
//  TabBarItemImageHelper.m
//  MyResume
//
//  Created by pi on 15/12/13.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "TabBarItemImageHelper.h"
#import "FontAwesomeKit.h"

@implementation TabBarItemImageHelper
+(UIImage*)aboutMeTabbarItemImage{
    return [[FAKFoundationIcons torsoBusinessIconWithSize:30]imageWithSize:CGSizeMake(44, 44)];
}
+(UIImage*)skillTabbarItemImage{
    return [[FAKFoundationIcons wrenchIconWithSize:30]imageWithSize:CGSizeMake(44, 44)];
}
+(UIImage*)timeLineTabbarItemImage{
    return [[FAKFoundationIcons foundationIconWithSize:30]imageWithSize:CGSizeMake(44, 44)];
}
+(UIImage*)collectionCardsTabbarItemImage{
    return [[FAKFoundationIcons trophyIconWithSize:30]imageWithSize:CGSizeMake(44, 44)];
}
@end
