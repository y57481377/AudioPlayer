//
//  YHHMainViewController.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/23.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHMainViewController.h"
#import "YHHDicoverCell.h"
#import "YHHDiscoverModel.h"


@interface YHHMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation YHHMainViewController {
    UITableView *_tableView;
    NSMutableArray *_models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarTitle:@"发现"];
    
    _tableView = [[UITableView alloc] initWithFrame:ScreenBounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.contentOffset = CGPointMake(0, -64);
    [_tableView registerClass:[YHHDicoverCell class] forCellReuseIdentifier:@"~"];
    [self.view addSubview:_tableView];
    
//    [YHHDiscoverData getDataCompletedHandler:^(NSArray *models, NSError *error) {
//        if (error) return;
//        
//        _models = (NSMutableArray *)models;
//        [_tableView reloadData];
//    }];
    NSLog(@"%f", _tableView.contentOffset.y);
}

#pragma mark --- Table DataSource /Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Auto_Y(120);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _models.count;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHHDicoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"~"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld组%ld行",indexPath.section, indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", _tableView.contentOffset.y);
}
@end
