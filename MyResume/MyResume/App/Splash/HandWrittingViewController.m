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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UIImageView *v=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    UIImage *screenShot=[self screenShot];
//    screenShot=[screenShot applyBlurWithRadius:14 tintColor:[UIColor clearColor] saturationDeltaFactor:1.8 maskImage:nil];
//    v.image=screenShot;
//    [self.view addSubview:v];
//    [self performSegueWithIdentifier:@"show" sender:self];
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

-(UIImage*)screenShot{
    UIWindow *window= [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    [window.layer renderInContext:ctx];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)setupPathAnimLayer{
//    UIBezierPath *path= [TextPathHelper pathForText:@"Pi"];
//    //text path layer
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.frame = self.view.bounds;
//    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
//    //    pathLayer.backgroundColor = [[UIColor yellowColor] CGColor];
//    pathLayer.geometryFlipped = YES;
//    pathLayer.path = path.CGPath;
//    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
//    pathLayer.fillColor = [UIColor clearColor].CGColor;
//    pathLayer.lineWidth = 7.0f;
//    pathLayer.lineJoin = kCALineJoinRound;

    
    self.pathLayer=[TextPathHelper textLayerWithText:@"Pi" frame:self.view.bounds];
//    self.view.layer.mask=pathLayer;
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
    NSInteger duration=3.0;
    
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
    [self performSegueWithIdentifier:@"showCollectionCards" sender:self];
}

@end
