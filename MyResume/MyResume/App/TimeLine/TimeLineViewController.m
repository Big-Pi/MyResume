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

@interface TimeLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet AutoShowScrollToTopImg *scrollToTopImg;
@property (strong,nonatomic) NSArray *experiences;
@end
 
@implementation TimeLineViewController

#pragma mark - ViewController Life Cycle

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight=66;
    self.tableView.layer.shadowOpacity=0.5;
    self.tableView.layer.shadowColor=[UIColor blackColor].CGColor;
    self.tableView.layer.shadowRadius=2;
//    self.tableView.layer.shadowOffset=CGSizeMake(10, 10);
    self.tableView.layer.masksToBounds=NO;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Getter Setter
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
    [cell layoutIfNeeded];
    return cell;
}

//-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    TimeLineTableViewCell *timeLineCell=(TimeLineTableViewCell*) cell;
//}

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
    return header;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header=(UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor=[UIColor whiteColor];
    header.textLabel.font=[UIFont systemFontOfSize:35];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.scrollToTopImg scrollViewDidScroll:scrollView];
}

@end
