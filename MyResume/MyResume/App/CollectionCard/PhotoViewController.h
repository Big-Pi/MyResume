//
//  PhotoViewController.h
//  MyResume
//
//  Created by pi on 15/12/27.
//  Copyright © 2015年 pi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Archivement;

@interface PhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) Archivement *archivement;
@end
