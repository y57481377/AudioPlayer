//
//  ViewController1.m
//  AudioPlayer
//
//  Created by YANG on 17/4/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "ViewController1.h"
#import "Header.h"
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
//
    [[YHHNetworkManager shareNetworkManager] requestWithUrl:@"http://shopcgi.qqmusic.qq.com/fcgi-bin/shopsearch.fcg?value=歌曲名&artist=周杰伦&type=qry_song&out=json&page_no=页码&page_record_num=单页" success:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dictionary);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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
