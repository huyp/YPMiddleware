//
//  ViewController.m
//  YPMiddlewareDemo
//
//  Created by 胡彦鹏 on 2020/2/10.
//  Copyright © 2020 hyp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSArray *data;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.data = @[@"get instance with className", @"get instance with params", @"get instance with class function", @"perform class function with params"];
    
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController"];
            if (v2) {
                [YPMiddleware setTarget:v2 value:@"lucy" forKey:@"msg"];
                [self.navigationController pushViewController:v2 animated:YES];
            }
        }
            break;
        case 1: {
            id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController" customInstanceFunction:@"initWithMsg:delegate:" params:@"jacky", self, nil];
            if (v2) {
                [self.navigationController pushViewController:v2 animated:YES];
            }
        }
            break;
        case 2: {
            id v2 = [YPMiddleware getInstanceWithClassName:@"OtherViewController" customInstanceFunction:@"classInstance"];
            if (v2) {
                [YPMiddleware setTarget:v2 value:@"jone" forKey:@"msg"];
                [self.navigationController pushViewController:v2 animated:YES];
            }
        }
            break;
        case 3 : {
            [YPMiddleware className:@"OtherViewController" performFunction:@"printA:andB:" params:@"aa",@"bb", nil];
//            [YPMiddleware getInstanceWithClassName:@"OtherViewController" customInstanceFunction:@"classInstance"];
        }
        default:
            break;
    }
}

#pragma mark - 执行一个隐式代理方法
- (void)changeBgColor:(UIColor *)color {
    self.tableview.backgroundColor = color;
}


@end
