//
//  ViewController2.h
//  中间件
//
//  Created by KCY_HYP on 2019/12/18.
//  Copyright © 2019 smz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TestBlock)(int a);

@interface ViewController2 : UIViewController

@property (nonatomic, assign) int count;

@property (nonatomic, copy) TestBlock block;

- (instancetype)initWithMsg:(NSString *)msg;

+ (instancetype)shareInstance;

- (void)doSomeThing:(id)sender;

- (CGRect)A:(int)a add_B:(int)b;

@end

NS_ASSUME_NONNULL_END
