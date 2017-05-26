//
//  YHHNetworkManager.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHNetworkManager.h"
#import "AFNetworking.h"

@implementation YHHNetworkManager

+ (instancetype)shareNetworkManager {
    static YHHNetworkManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[YHHNetworkManager alloc] init];
    });
    return _manager;
}

- (void)GET:(NSString *)urlstr params:(NSDictionary *)params success:(success)successBlock failure:(failure)failureBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:urlstr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
    }];
}

- (void)POST:(NSString *)urlstr params:(NSDictionary *)params success:(success)successBlock failure:(failure)failureBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager POST:urlstr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
    }];
}


@end
