//
//  TodayViewController.m
//  Widget
//
//  Created by Yang on 2017/6/1.
//  Copyright © 2017年 YHH. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
//    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeCompact;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 30, 100)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 400);
    }else {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
