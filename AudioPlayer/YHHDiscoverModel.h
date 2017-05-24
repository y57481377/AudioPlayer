//
//  YHHDiscoverModel.h
//  AudioPlayer
//
//  Created by Yang on 2017/5/23.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHDiscoverModel : NSObject

@end


@interface YHHDiscoverData : NSObject

+ (void)getDataCompletedHandler:(void(^)(NSArray *models ,NSError *error))completedHandler;
@end
