//
//  ViewController1.m
//  AudioPlayer
//
//  Created by YANG on 17/4/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "ViewController1.h"
#import "MusicPlayerController.h"
#import "MoviePlayerController.h"
@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 设置导航栏按钮
    [self setNavBarTitle:@"第一页"];
    UIButton *left = [UIButton buttonWithTitle:nil image:@"search" target:self action:@selector(search)];
    left.frame = CGRectMake(0, 0, 50, 50);
    [self setNavBarLeftItem:left];
    
    UIButton *left1 = [UIButton buttonWithTitle:nil image:@"search" target:self action:@selector(search)];
    left1.frame = CGRectMake(0, 0, 50, 50);
    UIButton *left2 = [UIButton buttonWithTitle:nil image:@"search" target:self action:@selector(search1)];
    left2.frame = CGRectMake(0, 0, 50, 50);
    [self setNavBarLeftItems:@[left1,left2,left]];
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
    text.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:text];
}

- (void)search {
    NSString *str = @"001";
    
    NSLog(@"%ld,%d",str.integerValue, str.intValue);
    
}

- (void)search1 {
    MoviePlayerController *vc = [[MoviePlayerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewWillAppear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = YES;
}

//- (void)viewDidDisappear:(BOOL)animated {
//    self.hidesBottomBarWhenPushed = NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
