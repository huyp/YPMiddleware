//
//  YPMiddleware.h
//
//  Created by HYP on 2019/12/18.
//  Copyright © 2019 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMiddleware : NSObject

/**
 Get instance with init function
 @param className class name string
 @return class instance, if className input error, return nil
 */
+ (nullable id)getInstanceWithClassName:(nonnull NSString *)className;

/**
 Get instance with custom function
 @param className class name string
 @param function customInstanceFunction string
 @return class instance, if className input error, return nil
 */
+ (nullable id)getInstanceWithClassName:(nonnull NSString *)className customInstanceFunction:(nonnull NSString *)function;

/**
 Get instance with customInit function
 @param className class name string
 @param function customInit function name
 @param params customInit function params
 @return class instance, if className or funName input error, return nil
 */
+ (nullable id)getInstanceWithClassName:(nonnull NSString *)className customInstanceFunction:(nonnull NSString *)function params:(nonnull id)params, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Especially in order to more than two params
 @param receiver target
 @param sel selector
 @param params function params
 @return get return value, maybe nil
 */
+ (nullable id)target:(id _Nonnull )receiver performSelector:(SEL _Nonnull )sel withParams:(nonnull id)params, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Through runtime get the instance, can't get or set property with get/set function, use kvc instead.
 */
+ (void)setTarget:(nonnull id)target value:(nonnull id)value forKey:(nonnull NSString *)key;


@end

