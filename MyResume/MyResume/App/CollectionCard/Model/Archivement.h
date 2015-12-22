//
//  Archivement.h
//  MyResume
//
//  Created by pi on 15/12/22.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Archivement : NSObject
@property (copy,nonatomic) NSString *imgName;
@property (copy,nonatomic) NSString *title;

+(NSArray*)allArchivement;
+(instancetype)archivementWithDict:(NSDictionary*)dict;
@end
