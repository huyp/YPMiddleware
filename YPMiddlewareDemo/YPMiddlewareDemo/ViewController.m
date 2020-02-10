//
//  ViewController.m
//  YPMiddlewareDemo
//
//  Created by 胡彦鹏 on 2020/2/10.
//  Copyright © 2020 hyp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];

    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 300, 40)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"采用init方法创建一个控制器,并传入值" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn1 addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 300, 40)];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"采用自定义初始化方法创建一个控制器,并传入值" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 addTarget:self action:@selector(tap2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton * btn3 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 300, 40)];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"采用自定义类初始化方法创建一个控制器,并传入值" forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn3 addTarget:self action:@selector(tap3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}

- (void)tap1 {
    id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController"];
    [v2 addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
    if (v2) {
        [YPMiddleware setTarget:v2 value:@"lucy" forKey:@"msg"];
        [self.navigationController pushViewController:v2 animated:YES];
    }
}

- (void)tap2 {
    id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController" customInstanceFunction:@"initWithMsg:" params:@"jacky", nil];
    if (v2) {
        [self.navigationController pushViewController:v2 animated:YES];
    }
}

- (void)tap3 {
    id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController" customInstanceFunction:@"shareInstance"];
    if (v2) {
        [YPMiddleware setTarget:v2 value:@"jone" forKey:@"msg"];
        [self.navigationController pushViewController:v2 animated:YES];
    }
}


@end
