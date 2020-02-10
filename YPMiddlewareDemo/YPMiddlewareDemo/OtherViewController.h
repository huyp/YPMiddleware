//
//  OtherViewController.h
//  YPMiddlewareDemo
//
//  Created by 胡彦鹏 on 2020/2/10.
//  Copyright © 2020 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OtherViewController : UIViewController

- (instancetype)initWithMsg:(NSString *)msg;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
