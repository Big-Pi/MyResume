//
//  HandWrittingViewController.m
//  MyResume
//
//  Created by pi on 15/11/12.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "HandWrittingViewController.h"
#import "TextPathHelper.h"
#import "UIImage+ImageEffects.h"


@interface HandWrittingViewController ()
@property (weak, nonatomic,readwrite) CAShapeLayer *pathLayer;
@property (weak, nonatomic) CALayer *penLayer;
@end

@implementation HandWrittingViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupPathAnimLayer];
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)setupPathAnimLayer{
    
    self.pathLayer=[TextPathHelper textLayerWithText:@"BigPi" frame:self.view.bounds];
    [self.view.layer addSublayer:self.pathLayer];
    //pen layer
    UIImage *penImage = [UIImage imageNamed:@"pen"];
    CALayer *penLayer = [CALayer layer];
    penLayer.contents = (id)penImage.CGImage;
    penLayer.anchorPoint = CGPointZero;
    penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
    penLayer.hidden=YES;
    self.penLayer = penLayer;
    
    [self.pathLayer addSublayer:penLayer];
    
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
    [self performSegueWithIdentifier:@"showMain" sender:self];
}

@end
