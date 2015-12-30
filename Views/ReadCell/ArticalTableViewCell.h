//
//  ArticalTableViewCell.h
//  aishengHuo
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
@interface ArticalTableViewCell : UITableViewCell
{
    //图片
    UIImageView *_imageView;
    //时间
    UILabel *_timeLabel;
    //作者
    UILabel *_authorLabel;
    //标题
    UILabel *_titleLable;
}

- (void)refreshUI:(ReadModel *)model;












@end
