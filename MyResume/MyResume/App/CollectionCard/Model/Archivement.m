//
//  Archivement.m
//  MyResume
//
//  Created by pi on 15/12/22.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "Archivement.h"

@implementation Archivement
+(instancetype)archivementWithDict:(NSDictionary *)dict{
    Archivement *archivement= [[Archivement alloc]init];
    archivement.title=dict[@"title"];
    archivement.imgName=dict[@"img"];
    return archivement;
}

+(NSArray *)allArchivement{
    NSMutableArray *array=[NSMutableArray array];
    NSString *path= [[NSBundle mainBundle]pathForResource:@"prize" ofType:@"plist"];
    NSArray *rawArchivementsArray=[NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in rawArchivementsArray) {
        [array addObject:[Archivement archivementWithDict:dict]];
    }
    return array;
}

-(NSString*)imgName_high_resolution{
    return [self.imgName stringByAppendingString:@"_high"];
}
@end
