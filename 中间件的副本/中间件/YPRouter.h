//
//  YPRouter.h
//
//  Created by HYP on 2019/12/30.
//  Copyright © 2019 hyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface YPRouter : NSObject

@property (nonatomic, copy) NSString * scheme; // app scheme

@property (nonatomic, copy) NSString * nativeScheme; // location jump scheme

@property (nonatomic, strong) NSMutableDictionary * routers;

@property (nonatomic, strong) WKWebView * webView;

/**
 if use url router to push or present a controller , the controller can't init use custom function.
 @param url url for target.
 @param webCallback if url.scheme if http or https.
 @param nativeCallback if url.scheme if 'native' or custom string, and router include url.host
 @param failedCallback errer happened
 */
- (void)parseURL:(NSURL *)url
     webCallback:(void (^)(NSURL *url,  NSMutableDictionary * param_dic))webCallback
  nativeCallback:(void (^)(NSURL *url,  NSMutableDictionary * param_dic))nativeCallback
          failed:(void (^)(NSError * error))failedCallback;

@end

