//
//  MyTabBarViewController.m
//  aishengHuo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "FoodViewController.h"
#import "HomeViewController.h"
#import "MusicViewController.h"
#import "ReadViewController.h"
#import "MainViewController.h"
@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createViewControllers];

    [self createTabBarItem];
}

- (void)createViewControllers
{
    //实例化子页面
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    //阅读
    ReadViewController *readVC = [[ReadViewController alloc] init];
    UINavigationController *readNav = [[UINavigationController alloc] initWithRootViewController:readVC];
    //美食
    FoodViewController *foodVC = [[FoodViewController alloc] init];
    UINavigationController *foodNav = [[UINavigationController alloc] initWithRootViewController:foodVC];

    //音乐
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    UINavigationController *musicNav = [[UINavigationController alloc] initWithRootViewController:musicVC];
    //我的
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    //添加viewControllers
    self.viewControllers = @[homeNav,readNav,foodNav,musicNav,mainNav];

}

- (void)createTabBarItem
{
    //未选中的图片
    NSArray *unselectedImageArray = @[@"ic_tab_home_normal@2x.png",@"ic_tab_select_normal@2x.png",@"iconfont-iconfontmeishi.png",@"iconfont-yule.png",@"ic_tab_profile_normal_female@2x.png"];
    //选中的图片
    NSArray *selectedImageArray = @[@"ic_tab_home_selected@2x.png",@"ic_tab_select_selected@2x.png",@"iconfont-iconfontmeishi-2.png",@"iconfont-yule-2.png",@"ic_tab_profile_selected_female@2x.png"];
    //标题
    NSArray *titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];

    for (int i = 0 ; i < self.tabBar.items.count ; i ++) {
        UIImage *unselectedImage = [UIImage imageNamed:unselectedImageArray[i]];
        //使用图片的原大小
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //获取item并且赋值
        UITabBarItem *item = self.tabBar.items[i];

        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
    }
    //设置选中时的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
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
