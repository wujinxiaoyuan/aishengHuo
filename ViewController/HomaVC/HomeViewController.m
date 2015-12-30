//
//  HomeViewController.m
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HomeViewController.h"
//打开抽屉
#import "UIViewController+MMDrawerController.h"
//二维码扫描
#import "CustomViewController.h"
//广告轮播
#import "Carousel.h"

#import "HomeModel.h"
#import "HomeTableViewCell.h"
#import "HomeDetalViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    Carousel *_cyclePlaying;
    UITableView *_tableView;
    //分页
    int _page;
}

//数据源
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self settingNav];
    [self createTableHeaderView];
    [self createTableView];
    [self createRefresh];

}
#pragma mark - 刷新数据
- (void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //当程序第一次启动的时候让自动刷新一次
    [_tableView.header beginRefreshing];
}

//下拉刷新
- (void)loadNewData
{
    _page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

//上拉加载
- (void)loadMoreData
{
    _page ++;
    
    [self getData];
}

//请求数据
- (void)getData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dic in responseObject[@"data"][@"topic"]) {

            HomeModel *model = [[HomeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
       }
        //数据请求成功之后停止刷新
        if (_page == 1) {
            [_tableView.header endRefreshing];
        }else {
            [_tableView.footer endRefreshing];
        }

        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -  创建tableView
- (void)createTableView
{
    //在这里如果SCREEN_H - 49 感觉垂直的ScrollView到不了底
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    //修改分割线
    //方法一
    //_tableView.separatorColor = [UIColor clearColor];
    //方法二
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //去掉多余的线条
    //_tableView.tableFooterView = [[UIView alloc] init];

    //设置头视图
    _tableView.tableHeaderView = _cyclePlaying;
}

#pragma mark - 实现tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    //赋值
    if (self.dataArray) {
        HomeModel *model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetalViewController *vc = [[HomeDetalViewController alloc] init];
    HomeModel *model = self.dataArray[indexPath.row];
    vc.dataID = model.dataID;


    //隐藏TabBar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 设置导航
- (void)settingNav
{
    self.titleLabel.text = @"爱生活";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function.png"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"2vm.png"] forState:UIControlStateNormal];
    //设置响应事件
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
    
}

#pragma mark - 按钮响应事件
- (void)leftButtonClick
{

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)rightButtonClick
{
    //NO可以扫描条形码和二维码 YES只扫描条形码
    CustomViewController *vc = [[CustomViewController alloc] initWithIsQRCode:NO Block:^(NSString *result, BOOL isSucceed) {
        if (isSucceed) {
            NSLog(@"%@", result);
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 创建tableView的头视图
- (void)createTableHeaderView
{
    _cyclePlaying = [[Carousel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 3)];
    //设置是否需要pageControl
    _cyclePlaying.needPageControl = YES;
    //是否需要无限轮播
    _cyclePlaying.infiniteLoop = YES;
    //设置pageControl的位置 这个是在中间
    _cyclePlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    //本地图片数组
    _cyclePlaying.imageArray = @[@"shili0.png",@"shili1.png",@"shili15.png",@"shili2.png"];
    //网络图片数组
    //_cyclePlaying.imageUrlArray


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
