//
//  ViewController2.m
//  中间件
//
//  Created by KCY_HYP on 2019/12/18.
//  Copyright © 2019 smz. All rights reserved.
//

#import "ViewController2.h"
#import "YPMiddleware.h"

@interface ViewController2 ()

@property (nonatomic, copy) NSString * msg;

@end

@implementation ViewController2

- (void)dealloc {
    NSLog(@"ViewController2 dealloc %@", self);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

+ (instancetype)shareInstance {
    static ViewController2 * v2;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v2 = [ViewController2 new];
        v2.view.backgroundColor = [UIColor greenColor];
    });
    NSLog(@"shareInstance %@", self);
    return v2;
}

- (instancetype)initWithMsg:(NSString *)msg {
    self = [super init];
    if (self) {
        _msg = msg;
        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
//        self.count += 5;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = self.msg;
}

- (void)setMsg:(NSString *)msg {
    _msg = msg;
}

- (void)setCount:(int)count {
    _count = count;
}

- (void)doSomeThing:(id)sender {
    NSLog(@"%@",sender);
}

- (CGRect)A:(int)a add_B:(int)b {
    a = 10;
    b = 2;
    return CGRectMake(0, 0, 30, 50);
}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


@end
