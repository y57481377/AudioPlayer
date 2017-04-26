//
//  YHHTabBarController.m
//  AudioPlayer
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHTabBarController.h"
#import "YHHNavigationController.h"
#import "ViewController1.h"
@interface YHHTabBarController ()

@end

@implementation YHHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    YHHNavigationController *nav = [[YHHNavigationController alloc] initWithRootViewController:[[ViewController1 alloc] init]];
    [self addChildViewController:nav];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
