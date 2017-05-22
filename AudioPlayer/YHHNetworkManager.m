//
//  YHHNetworkManager.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHNetworkManager.h"

@implementation YHHNetworkManager

+ (instancetype)shareNetworkManager {
    static YHHNetworkManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[YHHNetworkManager alloc] init];
    });
    return _manager;
}

- (void)requestWithUrl:(NSString *)strUrl success:(success)successBlock failure:(failure)failureBlock {
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 3;
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (response) successBlock(data);
        
        if (connectionError) failureBlock(connectionError);
    }];
}
@end
