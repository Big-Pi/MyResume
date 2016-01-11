//
//  CollectionCardViewController.m
//  CollectionViewTemplate
//
//  Created by pi on 15/11/16.
//  Copyright (c) 2015年 pi. All rights reserved.
//

#import "CollectionCardViewController.h"
#import "ColorCollectionCell.h"
#import "SwipableCardCollectionLayout.h"
#import "UIColor+PiRandomColor.h"
#import "FontAwsomeImageHelper.h"
#import "Archivement.h"
#import "PhotoViewController.h"
#import "PhotoAnimator.h"

@interface CollectionCardViewController ()<UICollectionViewDataSource,ColorCollectionCellDelegate, SwipableCardCollectionLayoutDelegate,UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *archivements;
@property (strong,nonatomic) SwipableCardCollectionLayout *cardLayout;
@property (assign,nonatomic) CGVector vector;
@property (strong,nonatomic) PhotoAnimator *animator;

@end

@implementation CollectionCardViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tabBarItem.title=@"奖项";
        self.tabBarItem.image=[FontAwsomeImageHelper collectionCardsTabbarItemImage];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView  registerNib:[UINib nibWithNibName:@"ColorCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ColorCell"];
    self.cardLayout=[[SwipableCardCollectionLayout alloc]init];
    self.cardLayout.delegate=self;
    self.collectionView.collectionViewLayout=self.cardLayout;
}

-(NSMutableArray *)archivements{
    if(!_archivements){
        _archivements=[[Archivement allArchivement]mutableCopy];
    }
    return _archivements;
}

-(PhotoAnimator *)animator{
    if(!_animator){
        _animator=[[PhotoAnimator alloc]init];
    }
    return _animator;
}

- (IBAction)reloadCards:(UIBarButtonItem *)sender {
    _archivements=nil;
    [self.collectionView reloadData];
}



#pragma mark - UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Archivement *archivement=self.archivements[indexPath.row];
    ColorCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ColorCell" forIndexPath:indexPath];
    cell.colorView.backgroundColor=[UIColor randomColor];
    cell.delegate=self;
    cell.titleLabel.text=archivement.title;
    cell.archivementImageView.image=[UIImage imageNamed:archivement.imgName];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.archivements.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.archivements.count==0 ? 0 :1;
}

#pragma mark - SwipableCardCollectionLayoutDelegate

-(CGSize)collectionViewContentSize:(UICollectionView *)collectionView{
    return CGSizeMake(collectionView.bounds.size.width , collectionView.bounds.size.height-64);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCell=(ColorCollectionCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PhotoViewController *photpVC= (PhotoViewController*)[sb instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    photpVC.archivement=self.archivements[indexPath.row];
    photpVC.transitioningDelegate=self;
    UIImageView *selectedImageView= self.selectedCell.archivementImageView;
    self.animator.originalFrame=[selectedImageView.superview convertRect:selectedImageView.frame toView:nil];
    [self presentViewController:photpVC animated:YES completion:nil];
}

-(CGVector)deleteCellVector{
    return self.vector;
}

#pragma mark - ColorCollectionCellDelegate
-(void)ColorCollectionCell:(ColorCollectionCell *)cell delete:(CGVector)vector{
    
    self.vector=vector;
    NSIndexPath *indexPath2Remove=[self.collectionView indexPathForCell:cell];
    [self.archivements removeObjectAtIndex:indexPath2Remove.item];
    
    if(self.archivements.count==0){
        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:0]];
    }else{
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath2Remove]];
    }
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)ColorCollectionCell:(ColorCollectionCell *)cell endPan:(CGPoint)currentPoint{
    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        cell.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.animator.presenting=YES;
    return self.animator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.animator.presenting=NO;
    return self.animator;
}

@end
