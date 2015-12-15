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
#import "TabBarItemImageHelper.h"

@interface CollectionCardViewController ()<UICollectionViewDataSource,ColorCollectionCellDelegate, SwipableCardCollectionLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *array;
@property (strong,nonatomic) SwipableCardCollectionLayout *cardLayout;
@property (assign,nonatomic) CGVector vector;
@end

@implementation CollectionCardViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tabBarItem.title=@"奖项";
        self.tabBarItem.image=[TabBarItemImageHelper collectionCardsTabbarItemImage];
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

-(NSMutableArray *)array{
    if(!_array){
        _array=[[NSMutableArray alloc]initWithCapacity:10];
    }
    return _array;
}

- (IBAction)addNewItem:(UIBarButtonItem *)sender {
    NSInteger insertCount=10;
    NSInteger insertStartIndex=self.array.count-1;
    
    if(self.collectionView.numberOfSections==0){
        for(NSInteger i=0;i<insertCount;i++){
            [self.array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:0]];
    }else{
        
        [self.collectionView performBatchUpdates:^{
            for(NSInteger i=insertStartIndex ;i<insertStartIndex+insertStartIndex;i++){
                [self.array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
                [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
            }
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (IBAction)reloadCards:(UIBarButtonItem *)sender {
    
}


#pragma mark - UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ColorCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ColorCell" forIndexPath:indexPath];
    cell.colorView.backgroundColor=[UIColor randomColor];
    cell.delegate=self;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.array.count==0 ? 0 :1;
}

#pragma mark - SwipableCardCollectionLayoutDelegate

-(CGSize)collectionViewContentSize:(UICollectionView *)collectionView{
    return CGSizeMake(collectionView.bounds.size.width , collectionView.bounds.size.height-64);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected : %d",indexPath.item);
}

-(CGVector)deleteCellVector{
    return self.vector;
}

#pragma mark - ColorCollectionCellDelegate
-(void)ColorCollectionCell:(ColorCollectionCell *)cell delete:(CGVector)vector{
    
    self.vector=vector;
    NSIndexPath *indexPath2Remove=[self.collectionView indexPathForCell:cell];
    [self.array removeObjectAtIndex:indexPath2Remove.item];
    
    if(self.array.count==0){
        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:0]];
    }else{
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath2Remove]];
    }
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)ColorCollectionCell:(ColorCollectionCell *)cell panning:(CGPoint)currentPoint{
    
}

-(void)ColorCollectionCell:(ColorCollectionCell *)cell endPan:(CGPoint)currentPoint{
    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        cell.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)ColorCollectionCell:(ColorCollectionCell *)cell beginPan:(CGPoint)currentPoint{
    
}
@end
