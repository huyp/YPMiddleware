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
 Get instance with customInit function contains params
 @param className class name string
 @param function customInit function name
 @param params customInit function params
 @return class instance, if className or funName input error, return nil
 */
+ (nullable id)getInstanceWithClassName:(nonnull NSString *)className customInstanceFunction:(nonnull NSString *)function params:(nonnull id)params, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Perform class function
 @param className class name string
 @param function  function name
 @return object, if className or funName input error, return nil
 */
+ (nullable id)className:(nonnull NSString *)className performFunction:(nonnull NSString *)function;

/**
 Perform class function contains params
 @param className class name string
 @param function  function name
 @param params  function params
 @return object, if className or funName input error, return nil
 */
+ (nullable id)className:(nonnull NSString *)className performFunction:(nonnull NSString *)function params:(nonnull id)params, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Through runtime get the instance, can't get or set property with set function, use kvc instead.
 contant try catch
 @return if success YES, fail NO.
 */
+ (BOOL)setTarget:(nonnull id)target value:(nonnull id)value forKey:(nonnull NSString *)key;


@end

