//
//  TimeLineViewController.m
//  TimeLineTableView
//
//  Created by pi on 15/11/18.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TimeLineTableViewCell.h"
#import "TimeLineHeaderCell.h"
#import "AutoShowScrollToTopImg.h"
#import "Experience.h"
#import "FontAwsomeImageHelper.h"

@interface TimeLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet AutoShowScrollToTopImg *scrollToTopImg;
@property (strong,nonatomic) NSArray *experiences;
@property (weak, nonatomic) IBOutlet UIView *experienceHeader;
@property (strong, nonatomic) NSMutableArray *visibleHeaders;
@property (strong, nonatomic) NSMutableArray *visibleCells;

@end

@implementation TimeLineViewController

#pragma mark - ViewController Life Cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tabBarItem.title=@"经验";
        self.tabBarItem.image=[FontAwsomeImageHelper timeLineTabbarItemImage];
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

//Landscape for this VC //not work after ios8
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
//}

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
    
    __block NSTimeInterval delay;
    self.tableView.scrollEnabled=NO;
    //
    [self.visibleCells enumerateObjectsUsingBlock:^(__kindof TimeLineTableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger translateX=cell.frame.size.width*(idx%2==0 ? 1 :-1);
        CGAffineTransform transform=CGAffineTransformMakeTranslation(translateX, 0);
        cell.transform=transform;
        [cell setHideLine:YES];
        delay=idx * 0.2;
        [UIView animateWithDuration:1.0 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [cell setHideLine:NO];
            if(idx==self.visibleCells.count-1){
                self.tableView.scrollEnabled=YES;
            }
        }];
        
    }];
    
    [self.visibleHeaders enumerateObjectsUsingBlock:^(UIView*  _Nonnull header, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:0.8 delay:delay+1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            header.alpha=1.0;
            self.experienceHeader.alpha=1.0;
        } completion:^(BOOL finished) {
        }];
    }];
    
}

#pragma mark - Getter Setter

-(NSMutableArray *)visibleHeaders{
    if(!_visibleHeaders) {
        _visibleHeaders=[NSMutableArray array];
    }
    return _visibleHeaders;
}
-(NSMutableArray *)visibleCells{
    if(!_visibleCells){
        _visibleCells=[NSMutableArray array];
    }
    return _visibleCells;
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
    [cell setCategory:[exp categoryStr]];
    [cell setCategoryImage:[self fontAwsomeImgForCategory:[exp category]]];
    //
    [self.visibleCells addObject:cell];
    return cell;
}

-(UIImage*)fontAwsomeImgForCategory:(NSString*)category{
    static NSDictionary *dict=nil;
    if(!dict){
        dict= @{@"0":[FontAwsomeImageHelper graduationCapImage],@"1":[FontAwsomeImageHelper bookImage],@"2":[FontAwsomeImageHelper wrenchImage]};
    }
    return (UIImage*)dict[category];
    
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
    [self.visibleHeaders addObject:header];
    return header;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.scrollToTopImg scrollViewDidScroll:scrollView];
}

@end
