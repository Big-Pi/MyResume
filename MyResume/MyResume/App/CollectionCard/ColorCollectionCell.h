//
//  ColorCollectionCell.h
//  
//
//  Created by pi on 15/11/20.
//
//

#import <UIKit/UIKit.h>
@class ColorCollectionCell;

@protocol ColorCollectionCellDelegate<NSObject>
@optional
-(void)ColorCollectionCell:(ColorCollectionCell*)cell beginPan:(CGPoint)currentPoint;
-(void)ColorCollectionCell:(ColorCollectionCell*)cell panning:(CGPoint)currentPoint;
-(void)ColorCollectionCell:(ColorCollectionCell*)cell endPan:(CGPoint)currentPoint;
-(void)ColorCollectionCell:(ColorCollectionCell*)cell delete:(CGVector)vector;

@end

@interface ColorCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *archivementImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property(nonatomic,weak) id<ColorCollectionCellDelegate> delegate;
@end
