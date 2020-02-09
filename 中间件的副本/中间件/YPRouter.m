//
//  YPRouter.m
//
//  Created by HYP on 2019/12/30.
//  Copyright © 2019 hyp. All rights reserved.
//

#import "YPRouter.h"
#import "YPMiddleware.h"
#import "ViewController2.h"

@implementation YPRouter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.routers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registRouterWithHost:(NSString *)host path:(NSString *)path handler:(void (^)(NSError * error, NSDictionary<NSString *, id> * params))handler {
    
}

- (void)parseURL:(NSURL *)url
     webCallback:(void (^)(NSURL *, NSMutableDictionary *))webCallback
  nativeCallback:(void (^)(NSURL *, NSMutableDictionary *))nativeCallback
          failed:(void (^)(NSError *))failedCallback {
    if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
        NSLog(@"url:%@",url.scheme);
        NSLog(@"scheme:%@",self.scheme);
        NSLog(@"host:%@",url.host);
        if ([url.scheme isEqualToString:self.scheme] || [self.nativeScheme isEqualToString:self.scheme]) { //外部跳转到本app or 本地跳转
                // YPMiddlewareDemo://ViewController2
            if (url.host) {  // 如果有目标页面
                __strong id target = [YPMiddleware getInstanceWithClassName:url.host];
                NSLog(@"target:%@",target);
                if (target && url.query) {
                    NSArray * params = [url.query componentsSeparatedByString:@"&"];
                    for (NSString * param in params) {
                        __unsafe_unretained NSString * key = [param componentsSeparatedByString:@"="].firstObject;
                        __unsafe_unretained NSString * value = [param componentsSeparatedByString:@"="].lastObject;
                        [YPMiddleware setTarget:target value:value forKey:key];
                    }
                }
                if ([target isKindOfClass:[UIViewController class]]) {
                    __kindof UIViewController * rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
                        [((UINavigationController *)rootViewController) pushViewController:target animated:YES];
                    } else if ([rootViewController isKindOfClass:[UIViewController class]]) {
                        if ([rootViewController.navigationController respondsToSelector:@selector(pushViewController:animated:)]) {
                            [rootViewController.navigationController pushViewController:target animated:YES];
                        } else {
                            rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                            [rootViewController presentViewController:target animated:YES completion:nil];
                        }
                    } else {
                        NSLog(@"[%@] target is not a VC or NavigationController", NSStringFromSelector(_cmd));
                    }
                    
                }
            } else { //没有目标页面
                // do nothing
            }
        } else if ([self.scheme isEqualToString:@"http"] || [self.scheme isEqualToString:@"https"]) { // 本地跳转到webViewController
            
        }
    } else {
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:5440 userInfo:@{NSLocalizedDescriptionKey:@"app can't open the url"}];
        failedCallback(error);
    }
}


@end
