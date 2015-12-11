//
//  SwipableCardCollectionLayout.h
//  
//
//  Created by pi on 15/11/20.
//
//

#import <UIKit/UIKit.h>
#import "ColorCollectionCell.h"


@protocol SwipableCardCollectionLayoutDelegate <UICollectionViewDelegate>
-(CGSize)collectionViewContentSize:(UICollectionView*)collectionView;
-(CGVector)deleteCellVector;
@end

@interface SwipableCardCollectionLayout : UICollectionViewLayout
@property(nonatomic,weak) id<SwipableCardCollectionLayoutDelegate> delegate;
@end
