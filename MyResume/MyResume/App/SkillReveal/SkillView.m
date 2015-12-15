//
//  SkillView.m
//  SkillReveal
//
//  Created by pi on 15/11/30.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "SkillView.h"
#import "Skill.h"

@interface SkillView ()
@property (weak, nonatomic) NSMutableArray *animCompleteLabels;
@end

@implementation SkillView

-(void)initPrivate{
//    for(int i=0;i<6;i++){
//        UILabel *lable=[[UILabel alloc]init];
//        lable.text=[NSString stringWithFormat:@"%d",i];
//        lable.font=[UIFont boldSystemFontOfSize:[self randomFontSize]];
//        [lable sizeToFit];
//        CGPoint origin= [self randomOrigin];
//        lable.frame=CGRectMake(origin.x, origin.y, lable.frame.size.width, lable.frame.size.height);
//        lable.layer.shadowColor=[UIColor blackColor].CGColor;
//        lable.layer.shadowRadius=5;
//        lable.layer.shadowOffset=CGSizeMake(5, 5);
//        lable.layer.shadowOpacity=0.4;
//        [self addSubview: lable];
//        [UIView animateWithDuration:8.0 animations:^{
//            NSInteger offsetX= [self randomOffset];
//            NSInteger offsetY= [self randomOffset];
//            CGFloat scale=[self randomScale];
//            CGAffineTransform scaleTransform= CGAffineTransformMakeScale(scale, scale);
//            CGAffineTransform translateTransform=CGAffineTransformMakeTranslation(offsetX, offsetY);
//            CGAffineTransform concat = CGAffineTransformConcat(scaleTransform, translateTransform);
//            lable.transform=concat;
//        } completion:^(BOOL finished) {
//            
//        }];
//    }
    [self.animCompleteLabels removeAllObjects];
    
    for (int i=0; i<self.skillLabels.count; i++) {
        UILabel *label=self.skillLabels[i];
        Skill *skill=self.allSkills[i];
        label.text=skill.name;
        label.layer.shadowColor=[UIColor blackColor].CGColor;
        label.layer.shadowRadius=6;
        label.layer.shadowOffset=CGSizeMake(8, 8);
        label.layer.shadowOpacity=1.0;
        label.layer.masksToBounds=NO;
    }
    
}

-(void)awakeFromNib{
    for (int i=0; i<self.skillLabels.count; i++) {
        UILabel *label=self.skillLabels[i];
        Skill *skill=self.allSkills[i];
        label.text=skill.name;
        label.layer.shadowColor=[UIColor blackColor].CGColor;
        label.layer.shadowRadius=6;
        label.layer.shadowOffset=CGSizeMake(8, 8);
        label.layer.shadowOpacity=1.0;
        label.layer.masksToBounds=NO;
    }
}

#pragma mark - Public
-(void)startAnim{
    for (int i=0; i<self.skillLabels.count; i++) {
        UILabel *label=self.skillLabels[i];
        [UIView animateWithDuration:3.0 animations:^{
            NSInteger offsetX= [self randomOffset];
            NSInteger offsetY= [self randomOffset];
            CGFloat scale=[self randomScale];
            CGAffineTransform scaleTransform= CGAffineTransformMakeScale(scale, scale);
            CGAffineTransform translateTransform=CGAffineTransformMakeTranslation(offsetX, offsetY);
            CGAffineTransform concat = CGAffineTransformConcat(scaleTransform, translateTransform);
            label.transform=concat;
        } completion:^(BOOL finished) {
            [self.animCompleteLabels addObject:label];
//            NSLog(@"%lu - %lu",(unsigned long)self.animCompleteLabels.count,(unsigned long)self.skillLabels.count);
            if(self.animCompleteLabels.count==self.skillLabels.count){
                self.animComplete();
            }
        }];
    }
}

#pragma mark - Getter Setter
-(NSMutableArray *)animCompleteLabels{
    if(!_animCompleteLabels){
        _animCompleteLabels=[NSMutableArray array];
    }
    return _animCompleteLabels;
}

-(NSArray *)allSkills{
    if(!_allSkills){
        _allSkills=[Skill allSkills];
    }
    return _allSkills;
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    [self initPrivate];
}

#pragma mark - Private
-(NSInteger)randomFontSize{
    NSInteger size=arc4random()%60;
    if(size<30){
        size+=20;
    }
    return size;
}

-(CGPoint)randomOrigin{
    NSInteger h = self.bounds.size.height - 20;
    NSInteger w = self.bounds.size.width - 50;
    int randomH=arc4random()%h;
    int randomW=arc4random()%w;
    return CGPointMake(randomW+20,randomH+20);
}

-(NSInteger)randomOffset{
    NSInteger r =  arc4random()%25;
    if(r%2==0){
        r*=-1;
    }
    return r+10;
}

/**
 *  randomScale
 *
 *  @return -0.30 ~ 0.80
 */
-(CGFloat)randomScale{
    NSInteger raw= arc4random()%20;
    if(raw%2==0){
        raw*=-1;
    }
    return  raw/100.0+1;
}

//-(CGFloat)randomRotation{
//    
//}
//
//-(UIColor*)randomColor{
//    
//}
@end
