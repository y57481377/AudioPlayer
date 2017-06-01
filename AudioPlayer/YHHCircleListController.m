//
//  YHHCircleListController.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/25.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHCircleListController.h"
#import "YHHCircleListCell.h"
#import "YHHCircleModel.h"
#import "SDImageCache.h"

@interface YHHCircleListController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *models;
@end

@implementation YHHCircleListController {
//    UITableView *_tableView;
//    NSArray *_models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"try it"];
    
    _tableView = [[UITableView alloc] initWithFrame:ScreenBounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.contentOffset = CGPointMake(0, -64);
    [_tableView registerClass:[YHHCircleListCell class] forCellReuseIdentifier:@"circleCell"];
    [self.view addSubview:_tableView];
    
    __weak typeof(self) weakSelf = self;
    [YHHCircleModel getDataCompletedHandler:^(NSArray *models, NSError *error) {
        if (error) return;
        
        weakSelf.models = (NSMutableArray *)models;
        [weakSelf.tableView reloadData];
    }];
    
//    NSUInteger bit = [[SDImageCache sharedImageCache] getSize];
//    NSUInteger count = [[SDImageCache sharedImageCache] getDiskCount];
//    NSLog(@"bit = %ld----count = %ld", bit, count);
//    [[SDImageCache sharedImageCache] clearMemory];
//    
//    bit = [[SDImageCache sharedImageCache] getSize];
//    count = [[SDImageCache sharedImageCache] getDiskCount];
//    NSLog(@"clear! bit = %ld----count = %ld", bit, count);
}

#pragma mark --- Table DataSource /Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_models[indexPath.row] cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
//    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHHCircleListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"circleCell"];
    
//    cell.count = arc4random_uniform(4);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ((YHHCircleListCell *)cell).model = _models[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
