//
//  YPMiddleware.m
//
//  Created by HYP on 2019/12/18.
//  Copyright © 2019 hyp. All rights reserved.
//

#import "YPMiddleware.h"
#import <objc/runtime.h>

@interface YPMiddleware()

@end

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
    
    if (!function || ![function isKindOfClass:[NSString class]]) {
        NSLog(@"[%@] no customInstanceFunction, return init instance", NSStringFromSelector(_cmd));
        return [[TargetClass alloc] init];
    } else {
        SEL sel = NSSelectorFromString(function); // get SEL
        
        id receiver = TargetClass;
        if ([TargetClass respondsToSelector:sel]) {
            receiver = TargetClass;
            return [self target:receiver performSelector:sel withParams:params, nil];
        } else {
            receiver = [TargetClass alloc];
            if ([receiver respondsToSelector:sel]) {
                return [self target:receiver performSelector:sel withParams:params, nil];
            } else {
                NSLog(@"[%@] %@ Class can't response to %@", NSStringFromSelector(_cmd), className, function);
                return nil;
            }
        }
    }
}

#pragma mark - target perform SEL
+ (nullable id)target:(id)receiver performSelector:(SEL)sel withParams:(nonnull id)params, ... NS_REQUIRES_NIL_TERMINATION {
    
    NSMethodSignature *methodSignature = [receiver methodSignatureForSelector:sel];
    NSInvocation * instanceInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [instanceInvocation setSelector:sel];
    [instanceInvocation setTarget:receiver];
    id firstParam = params;
    if (firstParam) { // get param
        // NSLog(@"[%@] param:%@", NSStringFromSelector(_cmd), firstParam);
        int index = 2; // param index
        [instanceInvocation setArgument:&firstParam atIndex:index];
        id param;
        va_list arg_list;
        va_start(arg_list, params);
        while ((param = va_arg(arg_list, id))) {
            index++;
            @try {
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
        id target = nil;
        [instanceInvocation getReturnValue:&target];
        return target;
    } else {
        NSLog(@"[%@] function not return value", NSStringFromSelector(_cmd));
        return nil;
    }

}

#pragma mark - safe KVC
+ (void)setTarget:(nonnull id)target value:(nonnull id)value forKey:(nonnull NSString *)key {
    if (target) {
        @try {
            [target setValue:value forKey:key];
        } @catch (NSException *exception) {
           NSLog(@"[%@] exception: %@", NSStringFromSelector(_cmd), exception);
        } @finally {
            // do nothing
        }
    } else {
        NSLog(@"[%@] exception: %@", NSStringFromSelector(_cmd), @"target == nil");
    }
}



@end
