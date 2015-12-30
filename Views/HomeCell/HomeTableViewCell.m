//
//  HomeTableViewCell.m
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self ceateUI];
    }
    return self;
}

- (void)ceateUI
{
    _titleLable = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, SCREEN_W - 20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:_titleLable];
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, _titleLable.frame.size.height + _titleLable.frame.origin.y, SCREEN_W - 20, 150) imageName:nil];
    [self.contentView addSubview:_imageView];

}

- (void)refreshUI:(HomeModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    _titleLable.text = model.title;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
