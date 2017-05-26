//
//  YHHDiscoverModel.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/23.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHDiscoverModel.h"
#import "YHHNetworkManager.h"

static NSInteger currentPage = 0;

@implementation YHHDiscoverModel

@end

@implementation YHHDiscoverData

+ (void)getDataCompletedHandler:(void(^)(NSArray *models ,NSError *error))completedHandler {
    
    NSMutableArray *models = [NSMutableArray array];
    NSDictionary *param = @{ @"q" : @"vitas",
                            @"tag" : @"",
                            @"start" : @(currentPage),
                            @"count" : @(20)
                            };
    NSString *search = @"https://api.douban.com/v2/music/search";
    
    [[YHHNetworkManager shareNetworkManager] GET:search params:param success:^(id responseObject) {
        
        NSArray *dataArr = [responseObject objectForKey:@"musics"];
        for (NSDictionary *dic in dataArr) {
            YHHDiscoverModel *model = [[YHHDiscoverModel alloc] init];
            
            [models addObject:model];
        }
        
        completedHandler(models, nil);
        
    } failure:^(NSError *error) {
        completedHandler(nil ,error);
    }];
}

@end
