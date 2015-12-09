//
//  TextPathHelper.h
//
//  Created by pi on 15/12/5.
//
//

#import <Foundation/Foundation.h>
@class UIBezierPath;

@interface TextPathHelper : NSObject
+(UIBezierPath*)pathForText:(NSString*)text;
@end
