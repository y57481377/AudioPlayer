//
//  YHHTabBarController.m
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHTabBarController.h"
#import "YHHNavigationController.h"
#import "YHHMainViewController.h"
#import "ViewController1.h"
@interface YHHTabBarController ()

@end

@implementation YHHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addChildViewController:[[ViewController1 alloc] init] title:@"vc1" image:nil selectedImage:nil];
    
//    [self addChildViewController:[[YHHMainViewController alloc] init] title:@"发现" image:nil selectedImage:nil];
}

- (void)addChildViewController:(UIViewController *)childvc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    
    YHHNavigationController *nav = [[YHHNavigationController alloc] initWithRootViewController:childvc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
