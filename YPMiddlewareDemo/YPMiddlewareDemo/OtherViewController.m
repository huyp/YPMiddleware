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

+ (instancetype)shareInstance {
    static OtherViewController * v2;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v2 = [OtherViewController new];
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
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = self.msg;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
