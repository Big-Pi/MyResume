//
//  SwipableCardCollectionLayout.m
//  
//
//  Created by pi on 15/11/20.
//
//

#import "SwipableCardCollectionLayout.h"
#import "ColorCollectionCell.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@interface SwipableCardCollectionLayout ()
@property (strong,nonatomic) NSMutableArray* itemToDelete;
@property (strong,nonatomic) NSMutableArray* itemToAdd;

@end

@implementation SwipableCardCollectionLayout


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    self.collectionView.contentOffset=CGPointZero;
}

-(CGSize)collectionViewContentSize{
    return [self.delegate collectionViewContentSize:self.collectionView];
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attr=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect baseRect=[self baseFrameForCard];
    CGSize randomOffset= [self randomOffset];
    CGRect newRect= CGRectOffset(baseRect, randomOffset.width,randomOffset.height);
//    NSLog(@"%@",NSStringFromCGRect(newRect));
    attr.frame=newRect;
    attr.zIndex=-indexPath.item;
    attr.transform=[self randomTransform];
    //
    BOOL is=indexPath.item==0;
    [self.collectionView cellForItemAtIndexPath:indexPath].userInteractionEnabled=is;
    return attr;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    if([self.collectionView numberOfSections]==0){
        return nil;
    }
    
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:count];
    for(int i=0;i<count;i++){
        UICollectionViewLayoutAttributes *attr= [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attr];
    }
    return array;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    CGSize oldSize=self.collectionView.bounds.size;
    if(!CGSizeEqualToSize(oldSize, newBounds.size)){
        return YES;
    }
    return  NO;
}

#pragma mark - private
-(CGRect )baseFrameForCard{
    CGPoint origin=CGPointMake(self.collectionView.bounds.size.width/10.0, self.collectionView.bounds.size.height/10.0);
    CGSize size=CGSizeMake(self.collectionView.bounds.size.width/10.0*8, self.collectionView.bounds.size.height/10.0*8);
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

-(CGSize)randomOffset{
    return CGSizeMake(arc4random()%10, arc4random()%10);
}

-(CGAffineTransform)randomTransform{
    return CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(arc4random()%3));
}

#pragma mark - animation

-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    if([self.itemToDelete containsObject:itemIndexPath]){
        UICollectionViewLayoutAttributes *attr= [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        UICollectionViewCell *cell=[self.collectionView cellForItemAtIndexPath:itemIndexPath];
        attr.alpha=0.4;
        attr.transform=cell.transform;
        CGVector vector= [self.delegate deleteCellVector];
//        NSLog(@"%@",NSStringFromCGVector(vector));
        attr.frame=CGRectApplyAffineTransform(cell.frame, CGAffineTransformMakeTranslation(vector.dx, vector.dy));
        return attr;
    }
    return [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
}

-(void)prepareForCollectionViewUpdates:(NSArray *)updateItems{
    [super prepareForCollectionViewUpdates:updateItems];
    self.itemToDelete=[NSMutableArray arrayWithCapacity:10];
    self.itemToAdd=[NSMutableArray arrayWithCapacity:10];
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *item, NSUInteger idx, BOOL *stop) {
        if(item.updateAction==UICollectionUpdateActionDelete){
            NSIndexPath *indexPath2Delete=item.indexPathBeforeUpdate;
            //item.indexPathBeforeUpdate.item==0 代表删除所有cell中的第一个cell
            //只剩一个cell时是deleteSection 此时item.indexPathBeforeUpdate.item==NSIntegerMax 而不是0
            if(indexPath2Delete.item==NSIntegerMax){
                indexPath2Delete=[NSIndexPath indexPathForItem:0 inSection:indexPath2Delete.section];
            }
//            NSLog(@"%ld",item.indexPathBeforeUpdate.item);
            [self.itemToDelete addObject:indexPath2Delete];
        }else if(item.updateAction==UICollectionUpdateActionInsert){
            [self.itemToAdd addObject:item.indexPathAfterUpdate];
        }
    }];
}

-(void)finalizeCollectionViewUpdates{
    [super finalizeCollectionViewUpdates];
    self.itemToAdd=nil;
    self.itemToDelete=nil;
}

@end
