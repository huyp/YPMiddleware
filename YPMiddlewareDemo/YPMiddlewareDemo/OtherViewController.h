//
//  OtherViewController.h
//  YPMiddlewareDemo
//
//  Created by 胡彦鹏 on 2020/2/10.
//  Copyright © 2020 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OtherViewControllerDelegate <NSObject>

- (void)changeBgColor:(UIColor *)color;

@end

@interface OtherViewController : UIViewController

- (instancetype)initWithMsg:(NSString *)msg delegate:(id)delegate;

+ (instancetype)classInstance;

@end
