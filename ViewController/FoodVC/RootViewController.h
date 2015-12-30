//
//  RootViewController.h
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

//左按钮
@property (nonatomic, strong)UIButton *leftButton;
//标题
@property (nonatomic, strong)UILabel *titleLabel;
//有按钮
@property (nonatomic, strong)UIButton *rightButton;

//相应
-(void)setLeftButtonClick:(SEL)selector;
-(void)setRightButtonClick:(SEL)selector;


@end
