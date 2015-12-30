//
//  HomeDetalViewController.m
//  aishengHuo
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HomeDetalViewController.h"

@interface HomeDetalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //头部图片
    UIImageView *_imageView;

    //头部文字
    UILabel *_headerTitleLable;
}
//头部视图的数据
@property (nonatomic, strong)NSMutableDictionary *dataDic;

//tableView的数据
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation HomeDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self settingNav];
    //先创建UI
    [self createUI];
    [self loadData];

}

#pragma mark - 请求数据
- (void)loadData
{
    //初始化
    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEDETAIL,[self.dataID intValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//       NSString *skk = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:HOMEDETAIL,[self.dataID intValue]]]encoding:NSUTF8StringEncoding error:nil];

            //头部视图数据
        self.dataDic = responseObject[@"data"];
        //tableView的数据
        self.dataArray = self.dataDic[@"product"];

        //数据请求完成之后刷新页面
        [self reloadHeaderView];
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

- (void)reloadHeaderView
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"pic"] ] placeholderImage:[UIImage imageNamed:@""]];
    _headerTitleLable.text = self.dataDic[@"desc"];
}

#pragma mark - 创建UI
- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //头部控件
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 3) imageName:nil];
    _headerTitleLable = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height - 40, SCREEN_W - 20, 30) text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20]];
    [_imageView addSubview:_headerTitleLable];
    _tableView.tableHeaderView = _imageView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.dataArray[section][@"pic"];
    return sectionArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailId"];
        UIImageView *iamgeView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SCREEN_W - 20, 200) imageName:nil];
        iamgeView.tag = 10;
        [cell.contentView addSubview:iamgeView];
    }
    //赋值
    UIImageView *imageView = [cell.contentView viewWithTag:10];
    if (self.dataArray) {
        NSArray *sectionArray = self.dataArray[indexPath.section][@"pic"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArray[indexPath.row][@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    }

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

//每个section的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    bgView.backgroundColor = [UIColor whiteColor];

    //索引
    UILabel *indexLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%ld",section + 1] textColor: RGB(250, 100, 180, 1)font:[UIFont systemFontOfSize:16]];

    indexLabel.layer.borderColor = RGB(250, 100, 180, 1).CGColor;
    indexLabel.layer.borderWidth = 2;
    indexLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:indexLabel];

    UILabel *titleLable = [FactoryUI createLabelWithFrame:CGRectMake(indexLabel.frame.size.width + indexLabel.frame.origin.x + 10, 10, 200, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    titleLable.textAlignment = NSTextAlignmentLeft;
    
    [bgView addSubview:titleLable];

    //价钱
    UIButton *priceButton = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_W - 60, 10, 50, 40) title:nil titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(priceButtonClick)];
    priceButton.titleLabel.font = [UIFont systemFontOfSize:14];

    [bgView addSubview:priceButton];

    titleLable.text = self.dataArray[section][@"title"];

    [priceButton setTitle:[NSString stringWithFormat:@"%@",self.dataArray[section][@"price"]] forState:UIControlStateNormal];

    return bgView;
}

- (void)priceButtonClick
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}


#pragma mark - 设置导航
- (void)settingNav
{
    self.titleLabel.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed@2x.png"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
}

- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
