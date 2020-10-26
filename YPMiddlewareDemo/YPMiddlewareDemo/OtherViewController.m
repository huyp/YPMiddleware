//
//  OtherViewController.m
//  YPMiddlewareDemo
//
//  Created by 胡彦鹏 on 2020/2/10.
//  Copyright © 2020 hyp. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@property (nonatomic, copy) NSString * msg;

@property (nonatomic, weak) id <OtherViewControllerDelegate> delegate;

@end

@implementation OtherViewController

- (void)dealloc {
    NSLog(@"OtherViewController dealloc %@", self);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (instancetype)initWithMsg:(NSString *)msg delegate:(id)delegate {
    self = [super init];
    if (self) {
        NSLog(@"cmd:%s",__func__);
        _msg = msg;
        _delegate = delegate;
        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

+ (instancetype)classInstance {
    return [[super alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.delegate) {
        UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 300, 40)];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 setTitle:@"change delegate background redColor" forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn1 addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = self.msg;
}

- (void)tap1 {
    if ([self.delegate respondsToSelector:@selector(changeBgColor:)]) {
        [self.delegate changeBgColor:[UIColor redColor]];
    }
}

+ (void)printA:(NSString *)a andB:(NSString *)b {
    NSLog(@"A: %@, b: %@",a,b);
}

@end
