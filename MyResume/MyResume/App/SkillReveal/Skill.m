//
//  Skill.m
//  SkillReveal
//
//  Created by pi on 15/12/2.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "Skill.h"

@implementation Skill

+(Skill *)skillWithDict:(NSDictionary *)dict{
    Skill *skill=[[Skill alloc]init];
    skill.name= dict[@"name"];
    skill.progrss= dict[@"progress"];
    return skill;
}

+(NSArray *)allSkills{
    NSMutableArray *allSkills=[NSMutableArray array];
    NSURL *url= [[NSBundle mainBundle]URLForResource:@"skills" withExtension:@"plist"];
    NSArray *skills=[NSArray arrayWithContentsOfURL:url];
    for (NSDictionary *dic in skills) {
        [allSkills addObject:[Skill skillWithDict:dic]];
    }
    NSArray *rtv =[allSkills sortedArrayUsingSelector:@selector(sortBySkillProgress:)];
    return rtv;
}
/**
 *  按progress大小排序所有skill
 *
 *  @return progress大在前
 */
-(NSComparisonResult)sortBySkillProgress:(id)another{
    Skill *other=(Skill*)another;
    if([self.progrss integerValue]>[other.progrss integerValue]){
        return NSOrderedAscending;
    }else if([self.progrss integerValue]<[other.progrss integerValue]){
        return NSOrderedDescending;
    }else{
        return NSOrderedSame;
    }
}
@end
