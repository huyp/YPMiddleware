//
//  YPMiddleware.m
//
//  Created by HYP on 2019/12/18.
//  Copyright © 2019 hyp. All rights reserved.
//

#import "YPMiddleware.h"
#import <objc/runtime.h>

@implementation YPMiddleware

#pragma mark - middleware instance
+ (nullable id)getInstanceWithClassName:(nonnull NSString *)className {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wnonnull"
    return [self getInstanceWithClassName:className customInstanceFunction:@"new" params:nil];
    #pragma clang diagnostic pop
}

#pragma mark - middleware custom instance without param
+ (nullable id)getInstanceWithClassName:(NSString *)className customInstanceFunction:(NSString *)function {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wnonnull"
    return [self getInstanceWithClassName:className customInstanceFunction:function params:nil];
    #pragma clang diagnostic pop
}

#pragma mark -  middleware custom instance with param
+ (nullable id)getInstanceWithClassName:(nonnull NSString *)className customInstanceFunction:(nonnull NSString *)function params:(nonnull id)params, ... NS_REQUIRES_NIL_TERMINATION {

    if (!className || ![className isKindOfClass:[NSString class]]) {
        NSLog(@"[%@] className is nil", NSStringFromSelector(_cmd));
        return nil;
    }
    Class TargetClass = NSClassFromString(className); // get Class
    if (!TargetClass) {
        NSLog(@"[%@] can't find Class with input className", NSStringFromSelector(_cmd));
        return nil;
    }

    NSArray * filterFunc = @[@"init", @"new", @"alloc", @"allocWithZone:"];
    if (!function || [filterFunc filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%@ IN SELF", function]].count) {
        NSLog(@"[%@] no customInstanceFunction, return init instance", NSStringFromSelector(_cmd));
        return [[TargetClass alloc] init];
    } else {
        SEL sel = NSSelectorFromString(function); // get SEL

        id receiver = nil;
        if ([TargetClass respondsToSelector:sel]) {
            receiver = TargetClass;
        } else {
            id target = [TargetClass alloc];
            if ([target respondsToSelector:sel]) {
                receiver = target;
            }
        }
        if (receiver) {
            NSMethodSignature *methodSignature = [receiver methodSignatureForSelector:sel];
            if (!methodSignature) {
                NSLog(@"%@ not implementation %@",receiver, NSStringFromSelector(sel));
                return nil;
            }
            NSInvocation * instanceInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            [instanceInvocation setSelector:sel];
            [instanceInvocation setTarget:receiver];
            if (params) { // get param
                int index = 2; // param index
                [instanceInvocation setArgument:&params atIndex:index];
                id param;
                va_list arg_list;
                va_start(arg_list, params);
                while ((param = va_arg(arg_list, id))) {
                    @try {
                        index++;
                        [instanceInvocation setArgument:&param atIndex:index];
                        // NSLog(@"[%@] param:%@", NSStringFromSelector(_cmd), param);
                    } @catch (NSException *exception) {
                        NSLog(@"%@:%@",NSStringFromSelector(_cmd), exception);
                    }
                }
                va_end(arg_list);
            } else {
                NSLog(@"[%@] param is nil", NSStringFromSelector(_cmd));
            }
            [instanceInvocation invoke];

            return [self getReturnValueWithMethodSignature:methodSignature invocation:instanceInvocation];
        } else {
            NSLog(@"[%@] %@ Class can't response to %@", NSStringFromSelector(_cmd), className, function);
            return nil;
        }
    }
}

#pragma mark - middleware custom without param
+ (id)className:(NSString *)className performFunction:(NSString *)function {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wnonnull"
    return [self className:className performFunction:function params:nil];
    #pragma clang diagnostic pop
}

#pragma mark -  middleware custom with param
+ (id)className:(NSString *)className performFunction:(NSString *)function params:(id)params, ... NS_REQUIRES_NIL_TERMINATION {
    if (!className || ![className isKindOfClass:[NSString class]]) {
        NSLog(@"[%@] className is nil", NSStringFromSelector(_cmd));
        return nil;
    }
    Class TargetClass = NSClassFromString(className); // get Class
    if (!TargetClass) {
        NSLog(@"[%@] can't find Class with input className", NSStringFromSelector(_cmd));
        return nil;
    }
    SEL sel = NSSelectorFromString(function); // get SEL
    
    if ([TargetClass respondsToSelector:sel]) {
        NSMethodSignature *methodSignature = [TargetClass methodSignatureForSelector:sel];
        if (!methodSignature) {
            NSLog(@"%@ not implementation %@",TargetClass, NSStringFromSelector(sel));
            return nil;
        }
        NSInvocation * instanceInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [instanceInvocation setSelector:sel];
        [instanceInvocation setTarget:TargetClass];
        if (params) { // get param
            int index = 2; // param index
            [instanceInvocation setArgument:&params atIndex:index];
            id param;
            va_list arg_list;
            va_start(arg_list, params);
            while ((param = va_arg(arg_list, id))) {
                @try {
                    index++;
                    [instanceInvocation setArgument:&param atIndex:index];
                    // NSLog(@"[%@] param:%@", NSStringFromSelector(_cmd), param);
                } @catch (NSException *exception) {
                    NSLog(@"%@:%@",NSStringFromSelector(_cmd), exception);
                }
            }
            va_end(arg_list);
        } else {
            NSLog(@"[%@] param is nil", NSStringFromSelector(_cmd));
        }
        [instanceInvocation invoke];

        return [self getReturnValueWithMethodSignature:methodSignature invocation:instanceInvocation];
    } else {
        NSLog(@"[%@] %@ can't response to selector %@", NSStringFromSelector(_cmd), className, function);
        return nil;
    }
}

+ (nullable id)getReturnValueWithMethodSignature:(NSMethodSignature *)methodSignature invocation:(NSInvocation *)instanceInvocation {
    if (methodSignature.methodReturnLength > 0) { // have return value
        /*
        add base type at here ...
        */
        if (strcmp(methodSignature.methodReturnType, @encode(int)) == 0) {
            int target = 0;
            [instanceInvocation getReturnValue:&target];
            return @(target);
        }
        
        if (strcmp(methodSignature.methodReturnType, @encode(NSInteger)) == 0) {
            NSInteger target = 0;
            [instanceInvocation getReturnValue:&target];
            return @(target);
        }
        
        if (strcmp(methodSignature.methodReturnType, @encode(NSUInteger)) == 0) {
            NSUInteger target = 0;
            [instanceInvocation getReturnValue:&target];
            return @(target);
        }
        
        if (strcmp(methodSignature.methodReturnType, @encode(CGFloat)) == 0) {
            CGFloat target = 0.f;
            [instanceInvocation getReturnValue:&target];
            return @(target);
        }
        
        if (strcmp(methodSignature.methodReturnType, @encode(float)) == 0) {
            float target = 0.0;
            [instanceInvocation getReturnValue:&target];
            return @(target);
        }
        
        if (strcmp(methodSignature.methodReturnType, @encode(double)) == 0) {
            double target = 0.0;
            [instanceInvocation getReturnValue:&target];
            return @(target);
        }
        
        if (strcmp(methodSignature.methodReturnType, @encode(BOOL)) == 0) {
            BOOL target = NO;
            [instanceInvocation getReturnValue:&target];
            return @(target);
        }
        
        if (strcmp(methodSignature.methodReturnType, @encode(CGRect)) == 0) {
            CGRect target = CGRectZero;
            [instanceInvocation getReturnValue:&target];
            return NSStringFromCGRect(target);
        }
                
        // if not up type, return nsobj.
        __autoreleasing id target = nil;
        [instanceInvocation getReturnValue:&target];
        return target;
    } else {
        NSLog(@"%@ no return value", NSStringFromSelector(instanceInvocation.selector));
        return nil;
    }
}

#pragma mark - safe KVC
+ (BOOL)setTarget:(nonnull id)target value:(nonnull id)value forKey:(nonnull NSString *)key {
    if (target) {
        @try {
            [target setValue:value forKey:key];
        } @catch (NSException *exception) {
            NSLog(@"[%@] exception: %@", NSStringFromSelector(_cmd), exception);
            return NO;
        }
        return YES;
    } else {
        NSLog(@"[%@] exception: %@", NSStringFromSelector(_cmd), @"target == nil");
        return NO;
    }
}

@end
