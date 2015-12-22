//
//  TimeLineViewController.m
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TimeLineDotLineView.h"
#import "TimeLineTableViewCell.h"
#import "TimeLineHeaderCell.h"
#import "AutoShowScrollToTopImg.h"
#import "Experience.h"
#import "DateFormatter.h"
#import "TabBarItemImageHelper.h"


@interface TimeLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet AutoShowScrollToTopImg *scrollToTopImg;
@property (strong,nonatomic) NSArray *experiences;
@property (weak, nonatomic) IBOutlet UIView *experienceHeader;
@property (strong, nonatomic) NSMutableArray *visibleHeaders;
@end
 
@implementation TimeLineViewController

#pragma mark - ViewController Life Cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tabBarItem.title=@"经验";
        self.tabBarItem.image=[TabBarItemImageHelper timeLineTabbarItemImage];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.rowHeight=166;
    self.tableView.sectionHeaderHeight=66;
    self.tableView.layer.shadowOpacity=0.5;
    self.tableView.layer.shadowColor=[UIColor blackColor].CGColor;
    self.tableView.layer.shadowRadius=2;
    self.tableView.layer.masksToBounds=NO;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //prepare From Anim
    self.experienceHeader.alpha=0.0;
    [self.visibleHeaders enumerateObjectsUsingBlock:^(UIView*  _Nonnull header, NSUInteger idx, BOOL * _Nonnull stop) {
        header.alpha=0.0;
    }];
    UITableViewCell *firstCell= self.tableView.visibleCells[0];
    CGRect fromFrame= CGRectMake(0, -firstCell.frame.size.height, firstCell.frame.size.width, firstCell.frame.size.height);
    //
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof TimeLineTableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell.superview bringSubviewToFront:cell];
        cell.hideLine=YES;
        CGRect toFrame=cell.frame;
        cell.frame=fromFrame;
        [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.frame=toFrame;
        } completion:^(BOOL finished) {
            [self.visibleHeaders enumerateObjectsUsingBlock:^(UIView*  _Nonnull header, NSUInteger idx, BOOL * _Nonnull stop) {
                [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    header.alpha=1.0;
                    self.experienceHeader.alpha=1.0;
                } completion:^(BOOL finished) {
                    [cell setHideLine:NO anim:YES];
                }];
            }];
        }];
    }];
    

    
}

#pragma mark - Getter Setter

-(NSMutableArray *)headers{
    if(!_visibleHeaders) {
        _visibleHeaders=[NSMutableArray array];
    }
    return _visibleHeaders;
}

-(NSArray *)experiences{
    if(!_experiences){
        _experiences=[Experience allExperience];
    }
    return _experiences;
}

#pragma mark - IBAction

- (IBAction)scrollToTop:(UITapGestureRecognizer *)sender {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeLineTableViewCell *cell=  [tableView dequeueReusableCellWithIdentifier:@"TimeLineCell"];
    //如果是该section最后一个cell,隐藏灰色线
    if(indexPath.row==([tableView numberOfRowsInSection:indexPath.section]-1)){
        cell.hideLine=YES;
    }else{
        cell.hideLine=NO;
    }
    //
    Experience *exp=self.experiences[indexPath.section][indexPath.row];
    [cell setTitle:exp.title];
    [cell setDate:exp.time];
    [cell setCategory:exp.category];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.experiences.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *yearExperience=self.experiences[section];
    return yearExperience.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *rowsInSection=self.experiences[section];
    Experience *firstExp=rowsInSection[0];
    TimeLineHeaderCell *header= [tableView dequeueReusableCellWithIdentifier:@"TimeLineHeaderCell"];
    header.titleLabel.text=firstExp.yearStr;
    [self.headers addObject:header];
    return header;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.scrollToTopImg scrollViewDidScroll:scrollView];
}

@end
