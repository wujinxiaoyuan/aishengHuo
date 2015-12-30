//
//  QuidePageView.m
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "QuidePageView.h"

@interface QuidePageView ()
{
    UIScrollView *_scrollView;
}

@end

@implementation QuidePageView

- (id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H +64)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(imageArray.count *SCREEN_W, SCREEN_H +64);
        [self addSubview:_scrollView];

        //创建imageView
        for (int i = 0; i < imageArray.count; i++) {
            UIImageView *imageView = [FactoryUI  createImageViewWithFrame:CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H + 64) imageName:imageArray[i]];
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
            if (i == imageArray.count - 1) {
                self.GoInButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.GoInButton.frame = CGRectMake(100, 100, 50, 50);
                [self.GoInButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                [imageView addSubview:self.GoInButton];
                }
        }



    }
    return self;
}
















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
