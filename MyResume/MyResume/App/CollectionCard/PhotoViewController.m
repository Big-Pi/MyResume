//
//  PhotoViewController.m
//  MyResume
//
//  Created by pi on 15/12/27.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "PhotoViewController.h"
#import "Archivement.h"

@interface PhotoViewController ()


@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img=[UIImage imageNamed:[self.archivement imgName_high_resolution]];
    self.imageView.image=img;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
