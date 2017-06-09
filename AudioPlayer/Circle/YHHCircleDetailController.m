//
//  YHHCircleDetailController.m
//  AudioPlayer
//
//  Created by Yang on 2017/6/8.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHCircleDetailController.h"
#import "YHHNetworkManager.h"

@interface YHHCircleDetailController ()

@end

@implementation YHHCircleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlstr = @"http://web.hn-ssc.com/ssc-circle/comment/findByPage.json";
    NSDictionary *body = @{
                           @"articleId":_articleId,
                           @"num": @"1",
                           @"size": @"10"
                           };
    
    [[YHHNetworkManager shareNetworkManager] POST:urlstr params:body success:^(id responseObject) {
        NSLog(@"%@" ,responseObject);
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.commentBlock)
        self.commentBlock();
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
