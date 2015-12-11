//
//  AutoShowScrollToTopImg.m
//  
//
//  Created by pi on 15/11/19.
//
//

#import "AutoShowScrollToTopImg.h"


@interface AutoShowScrollToTopImg ()

@end

@implementation AutoShowScrollToTopImg
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    self.layer.cornerRadius=5;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.hidden =! (scrollView.contentOffset.y > [UIScreen mainScreen].bounds.size.height);
}
@end
