//
//  YHHNetworkManager.h
//  AudioPlayer
//
//  Created by Yang on 2017/5/22.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^success)(NSData *data);
typedef void(^failure)(NSError *error);

@interface YHHNetworkManager : NSObject

+ (instancetype)shareNetworkManager;

- (void)requestWithUrl:(NSString *)strUrl success:(success)successBlock failure:(failure)failureBlock;

@end
