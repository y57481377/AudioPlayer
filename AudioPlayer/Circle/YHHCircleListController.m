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

#import "YHHCircleDetailController.h"

@interface YHHCircleListController ()<UITableViewDelegate, UITableViewDataSource, CircleCellProtocol>

//@property (strong, nonatomic) UITableView *tableView;
//@property (strong, nonatomic) NSArray *models;
@end

@implementation YHHCircleListController {
    UITableView *_tableView;
    NSArray *_models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"try it"];
    
    __block NSUInteger bit = [[SDImageCache sharedImageCache] getSize];
    __block NSUInteger count = [[SDImageCache sharedImageCache] getDiskCount];
    NSLog(@"bit = %ld----count = %ld", bit, count);
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        bit = [[SDImageCache sharedImageCache] getSize];
        count = [[SDImageCache sharedImageCache] getDiskCount];
        NSLog(@"clear! bit = %ld----count = %ld", bit, count);
    }];
    
    
    _tableView = [[UITableView alloc] initWithFrame:ScreenBounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.contentOffset = CGPointMake(0, -64);
    [_tableView registerClass:[YHHCircleListCell class] forCellReuseIdentifier:@"circleCell"];
    [self.view addSubview:_tableView];
    
//    __weak typeof(self) weakSelf = self;
    [YHHCircleModel getDataCompletedHandler:^(NSArray *models, NSError *error) {
        if (error) return;
        
        _models = (NSMutableArray *)models;
        [_tableView reloadData];
    }];
    
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
    
    cell.protocol = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ((YHHCircleListCell *)cell).model = _models[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark --- CircleProtocolCell
- (void)commentProtocol:(YHHCircleListCell *)cell {
    __block NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    YHHCircleDetailController *vc = [[YHHCircleDetailController alloc] init];
    vc.articleId = cell.model.articleID;
    
    // 发布评论后的block回调
    vc.commentBlock = ^() {
        cell.model.commentsNum += 1;
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)likeProtocolWithCell:(YHHCircleListCell *)cell {
    __block NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    [cell.model likeCompletedHandler:^(BOOL isLike, NSError *error) {
        if (error) return;
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
@end
