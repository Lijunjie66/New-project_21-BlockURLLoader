//
//  main.m
//  New-project_21-BlockURLLoader
//
//  Created by Geraint on 2018/5/2.
//  Copyright © 2018年 kilolumen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define IndexURL @"http://www.wikipedia.com/index.html"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        // 首先 为连接获取当前的运行循环
        NSRunLoop *loop = [NSRunLoop currentRunLoop]; // （异步加载 的 先决条件）
        BOOL __block downlodComplete = NO; // 在 块常量范围内可以改变
        
        // 创建请求
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:IndexURL]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (data == nil) {
                NSLog(@"Error loading request %@", [error localizedDescription]);
            } else {
                NSLog(@"\n\tDownloaded %lu bytes from request %@", [data length], [request URL]);
            }
            downlodComplete = YES;
        }];
        
        // 一直循环直到完成家在资源的操作为止
        while (!downlodComplete && [loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
