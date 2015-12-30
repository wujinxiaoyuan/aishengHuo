//
//  ReadViewController.m
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticalViewController.h"
#import "RecordViewController.h"
@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UISegmentedControl *_segmentControl;
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setingNav];
    [self createUI];

}

- (void)setingNav
{
    //创建segment
    _segmentControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    //插入标题
    [_segmentControl insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    //设置字体颜色
    _segmentControl.tintColor = [UIColor whiteColor];
    //背景颜色
    //_segmentControl.backgroundColor = [UIColor whiteColor];
    //设置默认选中读美文
    _segmentControl.selectedSegmentIndex = 0;
    [_segmentControl addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentControl;

}

#pragma mark - segment响应方法
- (void)changeOption:(UISegmentedControl *)segment
{
//    if (segment.selectedSegmentIndex == 1) {
//        _scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
//
//    }else{
//        _scrollView.contentOffset = CGPointMake(0, 0);
//    }
    _scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex *SCREEN_W, 0);
}

#pragma mark - 创建UI
- (void)createUI
{
    //创建scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49)];
    //设置代理
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    //_scrollView.scrollEnabled = NO;
    [self.view addSubview:_scrollView];

    //隐藏指示条
   // _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置contentsize
    _scrollView.contentSize = CGSizeMake(SCREEN_W * 2, 0);
    //实例化子控制器
    ArticalViewController *articalVC = [[ArticalViewController alloc] init];
    RecordViewController *recordVC = [[RecordViewController alloc] init];

    NSArray *VCArray = @[articalVC,recordVC];

    //滚动式的框架实现
    int i = 0;
    for (UIViewController *vc in VCArray) {
        vc.view.frame = CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i++;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    _segmentControl.selectedSegmentIndex = scrollView.contentOffset.x / SCREEN_W;


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
