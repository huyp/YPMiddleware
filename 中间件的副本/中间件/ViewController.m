//
//  ViewController.m
//  中间件
//
//  Created by KCY_HYP on 2019/12/18.
//  Copyright © 2019 smz. All rights reserved.
//

#import "ViewController.h"
#import "YPMiddleware.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray * mArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];

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
    
    UIButton * btn4 = [[UIButton alloc] initWithFrame:CGRectMake(50, 250, 300, 40)];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 setTitle:@"通过url跳转到指定控制器,并传入值" forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn4 addTarget:self action:@selector(tap4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

    printf("%s", @encode(NSInteger));
    printf("%s", @encode(int));
    printf("%s", @encode(CGFloat));
    printf("%s", @encode(CGRect));
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change:%@",change[NSKeyValueChangeNewKey]);
}

- (void)tap1 {
    id v2 = [YPMiddleware getInstanceWithClassName:@"ViewController2"];
    [v2 addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
    if (v2) {
        [YPMiddleware setTarget:v2 value:@"lucy" forKey:@"msg"];
        [self.navigationController pushViewController:v2 animated:YES];
    }
}

- (void)tap2 {
    
    id v2 = [YPMiddleware getInstanceWithClassName:@"ViewController2" customInstanceFunction:@"initWithMsg:" params:@"jacky", nil];
    self.mArray = [NSMutableArray arrayWithObject:v2];
    SEL sel = NSSelectorFromString(@"A:add_B:");
//    SEL sel = NSSelectorFromString(@"doSomeThing:");
    NSNumber * num = [YPMiddleware target:v2 performSelector:sel withParams:@10, @2, nil];
    NSLog(@"num:%@",num);
//    if (v2) {
//        [self.navigationController pushViewController:v2 animated:YES];
//    }
}

- (void)tap3 {
    id v2 = [YPMiddleware getInstanceWithClassName:@"ViewController2" customInstanceFunction:@"shareInstance"];
    if (v2) {
        [YPMiddleware setTarget:v2 value:@"jone" forKey:@"msg"];
        [self.navigationController pushViewController:v2 animated:YES];
    }
}

- (void)registRoute_01 {
    NSMutableDictionary * routers = [NSMutableDictionary dictionary];
    id v2 = [YPMiddleware getInstanceWithClassName:@"ViewController2" customInstanceFunction:@"shareInstance"];
    [routers setObject:v2 forKey:@"ViewController2"];
}

- (void)tap4 { // 这个没写完,这先是个大概,路由模式
    NSString * scheme = @"YPMiddlewareDemo";
    NSURL * url = [NSURL URLWithString:@"YPMiddlewareDemo://ViewController2?count=888&msg=Lee"];
    if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
        if ([url.scheme isEqualToString:scheme]) {
            // 内部跳转k
            NSLog(@"host:%@",url.host);
            NSLog(@"query:%@",url.query);
            if (url.host) {
                __unsafe_unretained id target = [YPMiddleware getInstanceWithClassName:url.host];
                if (target && url.query) {
                    NSLog(@"query:%@",url.query);
                    NSArray * params = [url.query componentsSeparatedByString:@"&"];
                    NSLog(@"params:%@",params);
                    for (NSString * param in params) {
                        __unsafe_unretained NSString * key = [param componentsSeparatedByString:@"="].firstObject;
                        __unsafe_unretained NSString * value = [param componentsSeparatedByString:@"="].lastObject;
                        NSLog(@"param:%@",param);
                        [YPMiddleware setTarget:target value:value forKey:key];
                    }
                }
                if (target) {
                    NSLog(@"target:%@",target);
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:target animated:NO completion:nil];
                }
            }

        } else {
            // 外部跳转
            [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}completionHandler:^(BOOL success) {
                NSLog(@"success: %d", success);
            }];
        }
        
    }
}


@end
