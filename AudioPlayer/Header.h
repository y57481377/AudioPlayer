//
//  Header.h
//  AudioPlayer
//
//  Created by Yang on 2017/4/25.
//  Copyright © 2017年 YHH. All rights reserved.
//

#ifndef Header_h
#define Header_h

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


#import "UIView+Extension.h"
#import "UIButton+Extension.h"
#import "YHHNetworkManager.h"


/**** 屏幕宽高 ****/
#define ScreenBounds [UIScreen mainScreen].bounds
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define NaviBar_Height 64.f
//屏幕适配
#define Auto_X(x) (x)*Screen_Width/375
#define Auto_Y(y) (y)*Screen_Height/667
/**** 手机型号 ****/
//iPhone or iPad
#define is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//手机型号
#define iPhone4 (is_iPhone && MAX(Screen_Width, Screen_Height) < 568.0)
#define iPhone5 (is_iPhone && MAX(Screen_Width, Screen_Height) == 568.0)
#define iPhone6 (is_iPhone && MAX(Screen_Width, Screen_Height) == 667.0)
#define iPhonePlus (is_iPhone && MAX(Screen_Width, Screen_Height) == 736.0)

/**** 字体适配 ****/
#define AutoFont(size) ({UIFont *autoFont = [UIFont systemFontOfSize:size];\
if (iPhone5 || iPhone4) {\
autoFont = [UIFont systemFontOfSize:size - 1.5];\
} else if (iPhone6) {\
autoFont = [UIFont systemFontOfSize:size];\
}else if (iPhonePlus) {\
autoFont = [UIFont systemFontOfSize:size + 1.5];\
}autoFont;}) //字体的大小 6s 为标准。


/**** 全局颜色 ****/
#define yhh_Color(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define random_Color yhh_Color(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255),1)
#define white_Text_Color yhh_Color(233, 233, 233, 1)    //文字白色
#define red_Globe_Color yhh_Color(183,39,18,1)          //全局红色

#endif /* Header_h */
