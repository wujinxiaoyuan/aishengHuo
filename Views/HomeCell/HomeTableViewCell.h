//
//  HomeTableViewCell.h
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeTableViewCell : UITableViewCell
{
    //图片
    UIImageView *_imageView;
    //标题
    UILabel *_titleLable;
}

- (void)refreshUI:(HomeModel *)model;



@end
