//
//  QuidePageView.h
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//
//引导页
#import <UIKit/UIKit.h>

@interface QuidePageView : UIView

@property(nonatomic, strong)UIButton *GoInButton;

//传引导页的图片数组
- (id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray;



@end
