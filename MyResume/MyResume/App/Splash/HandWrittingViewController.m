//
//  HandWrittingViewController.m
//  MyResume
//
//  Created by pi on 15/11/12.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "HandWrittingViewController.h"
#import "TextPathHelper.h"


@interface HandWrittingViewController ()
@property (weak, nonatomic) CAShapeLayer *pathLayer;
@property (weak, nonatomic) CALayer *penLayer;
@end

@implementation HandWrittingViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIBezierPath *path= [TextPathHelper pathForText:@"BigPi"];
    //text path layer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.view.bounds;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
//    pathLayer.backgroundColor = [[UIColor yellowColor] CGColor];
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 3.0f;
    pathLayer.lineJoin = kCALineJoinRound;
    
    self.pathLayer=pathLayer;
    [self.view.layer addSublayer:pathLayer];
    //pen layer
    UIImage *penImage = [UIImage imageNamed:@"pen"];
    CALayer *penLayer = [CALayer layer];
    penLayer.contents = (id)penImage.CGImage;
    penLayer.anchorPoint = CGPointZero;
    penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
    penLayer.hidden=YES;
    self.penLayer = penLayer;
    
    [pathLayer addSublayer:penLayer];
    
    [self startAnimation];
}


- (void) startAnimation
{
    [self.pathLayer removeAllAnimations];
    [self.penLayer removeAllAnimations];
    
    self.penLayer.hidden = NO;
    NSInteger duration=5.0;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    penAnimation.duration = duration;
    penAnimation.path = self.pathLayer.path;
    penAnimation.calculationMode = kCAAnimationPaced;// smooth anim
    penAnimation.delegate = self;
    [self.penLayer addAnimation:penAnimation forKey:@"position"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.penLayer.hidden=YES;
}

@end
