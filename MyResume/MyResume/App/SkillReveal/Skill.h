//
//  Skill.h
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Skill : NSObject
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *progrss;
+(Skill*)skillWithDict:(NSDictionary*)dict;
+(NSArray*)allSkills;
@end
