//
//  AboutMeTableController.m
//  MyResume
//
//  Created by pi on 15/12/12.
//  Copyright © 2015年 pi. All rights reserved.
//

#import "AboutMeTableController.h"
#import "FontAwsomeImageHelper.h"
#import "TTTAttributedLabel.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "SVProgressHUD.h"

NSString *const kLocationQuery=@"http://maps.apple.com/?q=%@";

@interface AboutMeTableController ()<TTTAttributedLabelDelegate,MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avantar;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *locationLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *tinyDoLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *constGeneratorLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *resumeMarkDownLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *schoolLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *myResumeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *zhiHuDailyLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *leanCloudLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *SYNULabel;

//blog
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *jianshuLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *bigpiLabel;

@end

@implementation AboutMeTableController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tabBarItem.title=@"我";
        self.tabBarItem.image=[FontAwsomeImageHelper aboutMeTabbarItemImage];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.avantar.layer.masksToBounds=YES;
    self.avantar.layer.cornerRadius=self.avantar.bounds.size.width/2;
    self.avantar.layer.borderWidth=4;
    self.avantar.layer.borderColor=[UIColor whiteColor].CGColor;
    //
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored"-Wdeprecated-declarations"
    
    NSString *location=[[NSString stringWithFormat:kLocationQuery,@"辽宁省沈阳市"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    #pragma clang diagnostic pop
    [self.locationLabel addLinkToURL:[NSURL URLWithString:location] withRange:[self.locationLabel.text rangeOfString:@"辽宁沈阳"]];
    [self.tinyDoLabel addLinkToURL:[NSURL URLWithString:@"https://github.com/Big-Pi/TinyDo"] withRange:[self.tinyDoLabel.text rangeOfString:@"TinyDo"]];
    [self.constGeneratorLabel addLinkToURL:[NSURL URLWithString:@"https://github.com/Big-Pi/ConstGenerator"] withRange:[self.constGeneratorLabel.text rangeOfString:@"ConstGenerator"]];
    [self.resumeMarkDownLabel addLinkToURL:[NSURL URLWithString:@"https://github.com/Big-Pi/Resume.md"] withRange:[self.resumeMarkDownLabel.text rangeOfString:@"Markdown版"]];
    [self.schoolLabel addLinkToURL:[NSURL URLWithString:@"http://www.sie.edu.cn"] withRange:[self.schoolLabel.text rangeOfString:@"沈阳工程学院"]];
    [self.zhiHuDailyLabel addLinkToURL:[NSURL URLWithString:@"https://github.com/Big-Pi/ZhiHuDaily"] withRange:[self.zhiHuDailyLabel.text rangeOfString:@"ZhiHuDaily"]];
    [self.myResumeLabel addLinkToURL:[NSURL URLWithString:@"https://Big-Pi@github.com/Big-Pi/MyResume.git"] withRange:[self.myResumeLabel.text rangeOfString:@"MyResume"]];
    [self.leanCloudLabel addLinkToURL:[NSURL URLWithString:@"https://github.com/Big-Pi/PiChat"] withRange:[self.leanCloudLabel.text rangeOfString:@"PiChat"]];
    [self.SYNULabel addLinkToURL:[NSURL URLWithString:@"https://github.com/Big-Pi/GPAQuery"] withRange:[self.SYNULabel.text rangeOfString:@"SYNU 绩点助手"]];
    //Blog
    [self.bigpiLabel addLinkToURL:[NSURL URLWithString:@"http://bigpi.me"] withRange:[self.SYNULabel.text rangeOfString:@"BigPi.me"]];
    [self.jianshuLabel addLinkToURL:[NSURL URLWithString:@"http://www.jianshu.com/users/192cd7521ac8/latest_articles"] withRange:[self.SYNULabel.text rangeOfString:@"简书"]];
    
    
}

#pragma mark - TTTAttributedLabelDelegate
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    UIApplication *app= [UIApplication sharedApplication];
    if([app canOpenURL:url]){
        [app openURL:url];
    }
}

#pragma mark - Private
- (IBAction)sendEmail:(UIBarButtonItem *)sender {
    NSString *emailTitle = @"面试邀约~!";
    NSString *messageBody = @":)\n您的面试邀约信息～";
    NSArray *toRecipents = [NSArray arrayWithObject:@"wangdapishuai@163.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    [self presentViewController:mc animated:YES completion:NULL];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"   发送完成   "];
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
