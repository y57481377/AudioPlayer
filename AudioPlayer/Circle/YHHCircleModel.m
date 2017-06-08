//
//  YHHCircleModel.m
//  AudioPlayer
//
//  Created by Yang on 2017/5/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "YHHCircleModel.h"

#define VerifyValue(value) ({id tmp;if ([value isKindOfClass:[NSNull class]]){tmp = nil;}else{tmp = value;}tmp;})
@implementation YHHCircleModel 

- (instancetype)initWithDic:(NSDictionary *)dict {
    self.headImagePath = [[dict objectForKey:@"user"] objectForKey:@"headImgId"];
    self.name = VerifyValue([[dict objectForKey:@"user"] objectForKey:@"userName"]);
    self.nickName = VerifyValue([[dict objectForKey:@"user"] objectForKey:@"nickName"]);
    self.info = [dict objectForKey:@"content"];
    self.infoImagePath = VerifyValue([dict objectForKey:@"thumb"]);
    self.uploadFiles = [dict objectForKey:@"uploadFiles"];
    self.shareURL = VerifyValue([dict objectForKey:@"shareURL"]);
    
    //if (infoArr.count != 0) {
    //    self.infoImagePath = [infoArr[0] objectForKey:@"fileName"];
    //} else {
    //    self.infoImagePath = nil;
    //}
    self.userArr = [dict objectForKey:@"userList"];
    self.likeNum = [[dict objectForKey:@"likeNum"] integerValue];
    self.commentsNum = [dict objectForKey:@"commentNum"];
    self.shareNum = [dict objectForKey:@""];
    self.startTime = [dict objectForKey:@"createTime"];
    self.infoId = [dict objectForKey:@"id"];
    self.isLikeCurrArticle = [[dict objectForKey:@"isLikeCurrArticle"] boolValue];
    
    self.userID = [dict objectForKey:@"createUserId"]; //发布文章人的id
    self.articleID = [dict objectForKey:@"id"]; //文章的id
    
    return self;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        // 计算文字高度
        CGSize s = CGSizeMake(Screen_Width - Auto_X(24), MAXFLOAT);
        CGSize strSize = stringEstimateSize(self.info, s, 14);
        
        // 如果有图片，赋上图片高度
        CGFloat imageH = 0;
        if (_uploadFiles.count > 0 && _uploadFiles.count < 3) imageH = Auto_Y(200) + Auto_Y(10);
        else if (_uploadFiles.count >= 3) imageH = Auto_Y(150) + Auto_Y(10);
    
        // 加上cell的抬头高度、间隔高度
        _cellHeight = strSize.height + imageH + Auto_Y(70) + 30;
    }
    
    // 喜欢的人图标
    CGFloat likeH;
    if (_userArr.count > 0) likeH = Auto_Y(30) + Auto_Y(10);
    else                    likeH = 0;
    
    return _cellHeight + likeH;
}


+ (void)getDataCompletedHandler:(void(^)(NSArray *models, NSError *error))completedHandler {
    
    NSMutableArray *models = [NSMutableArray array];
    NSDictionary *param = @{
        @"circleTypeId" : @"2937d84cc6004e22a9d8a77c77049a48",
        @"handPick" : @"1",    /* 1为精选数据，-1为最新数据*/
        @"pageIndex" : @"1",
        @"userId" : @"582"
    };
    NSString *url = @"http://web.hn-ssc.com/ssc-circle/article/findAll.json";
    
    [[YHHNetworkManager shareNetworkManager] POST:url params:param success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *dataArr = [responseObject[@"data"] objectForKey:@"result"];
        for (NSDictionary *dic in dataArr) {
            YHHCircleModel *model = [[YHHCircleModel alloc] initWithDic:dic];
            
            [models addObject:model];
        }
        
        completedHandler(models, nil);
    } failure:^(NSError *error) {
        completedHandler(nil, error);
    }];
}


- (void)likeCompletedHandler:(void (^)(BOOL isLike, NSError *))completedHandler {
    NSDictionary *param = @{
                            @"articleId" : self.articleID,
                            @"likeUserId" : @"582"
                            };
    
    NSString *url = @"http://web.hn-ssc.com/ssc-circle/circlelike/updateLike.json";
    
    [[YHHNetworkManager shareNetworkManager] POST:url params:param success:^(id responseObject) {
        __block BOOL isLike = NO;
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"喜欢成功"])
            isLike = YES;
        
        self.isLikeCurrArticle = isLike;
        NSString *url = @"http://web.hn-ssc.com/ssc-circle/circlelike/findbyarticleid.json";
        
        // 查询该文章的 喜欢的人 的数据
        [[YHHNetworkManager shareNetworkManager] POST:url params:@{@"articleId" : self.articleID} success:^(id responseObject) {
//            NSLog(@"%@",responseObject);
            self.userArr = [responseObject objectForKey:@"data"];
            self.likeNum = self.userArr.count;
            completedHandler(isLike, nil);
        } failure:^(NSError *error) {
            self.userArr = [responseObject objectForKey:@"data"];
            completedHandler(nil, error);
        }];
        
    } failure:^(NSError *error) {
        completedHandler(nil, error);
    }];
    
}
@end
