//
//  ViewController.h
//  YPMiddlewareDemo
//
//  Created by 胡彦鹏 on 2020/2/10.
//  Copyright © 2020 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPMiddleware.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

