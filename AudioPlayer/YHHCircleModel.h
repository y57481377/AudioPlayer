//
//  YHHCircleModel.h
//  AudioPlayer
//
//  Created by Yang on 2017/5/26.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHHCircleModel : NSObject

@property (nonatomic, copy) NSString *headImagePath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickName; //昵称
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *infoImagePath;
@property (nonatomic, retain) NSMutableArray *userArr;
@property (nonatomic, copy) NSString *likeNum;
@property (nonatomic, copy) NSString *commentsNum;
@property (nonatomic, copy) NSString *shareNum;
@property (nonatomic, copy) NSString *shareURL; //分享的链接
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *infoId;
//@property (nonatomic, copy) NSString *hadSelf;
@property (nonatomic, copy) NSString *isLikeCurrArticle;
@property (nonatomic, retain) NSMutableArray *uploadFiles;

@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *articleID;


@property (assign, nonatomic) CGFloat cellHeight;

+ (void)getDataCompletedHandler:(void(^)(NSArray *models ,NSError *error))completedHandler;
@end
