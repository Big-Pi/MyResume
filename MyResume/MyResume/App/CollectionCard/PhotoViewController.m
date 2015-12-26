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

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img=[UIImage imageNamed:[self.archivement imgName_high_resolution]];
    self.imageView.image=img;
}

@end
