//
//  FontAwsomeImageHelper.m
//  MyResume
//
//  Created by pi on 15/12/13.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "FontAwsomeImageHelper.h"
#import "FontAwesomeKit.h"

@implementation FontAwsomeImageHelper

#pragma mark - TabBarImage
+(UIImage*)aboutMeTabbarItemImage{
    return [self imageSize44:[FAKFoundationIcons torsoBusinessIconWithSize:38]];
}

+(UIImage*)skillTabbarItemImage{
    return [self imageSize44:[FAKFoundationIcons wrenchIconWithSize:38]];
}

+(UIImage*)timeLineTabbarItemImage{
    return [self imageSize44:[FAKFoundationIcons foundationIconWithSize:38]];
}

+(UIImage*)collectionCardsTabbarItemImage{
    return [self imageSize44:[FAKFoundationIcons trophyIconWithSize:38]];
}

#pragma mark - TimeLine
//扳手 🔧
+(UIImage*)wrenchImage{
    return [self imageSize60:[FAKFoundationIcons wrenchIconWithSize:60]];
}

+(UIImage*)bookImage{
    return [self imageSize60:[FAKFoundationIcons bookIconWithSize:60]];
    return [[FAKFoundationIcons bookIconWithSize:60]imageWithSize:CGSizeMake(60, 60)];
}

+(UIImage *)graduationCapImage{
    return [self imageSize60:[FAKFontAwesome graduationCapIconWithSize:60]];
}

#pragma mark - Private
+(UIImage *)image:(FAKIcon *)img Withsize:(CGSize)size{
    return [img imageWithSize:size];
}

+(UIImage *)imageSize60:(FAKIcon *)img{
    return  [self image:img Withsize:CGSizeMake(60, 60)];
}

+(UIImage *)imageSize44:(FAKIcon *)img{
    return  [self image:img Withsize:CGSizeMake(44, 44)];
}


@end
