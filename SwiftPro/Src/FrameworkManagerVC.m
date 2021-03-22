//
//  FrameworkManagerVC.m
//  SwiftPro
//
//  Created by eport2 on 2021/3/22.
//  Copyright © 2021 eport. All rights reserved.
//

#import "FrameworkManagerVC.h"
#include <dlfcn.h>

@interface FrameworkManagerVC ()

@property (nonatomic,strong) id runtime_Player;

@end

@implementation FrameworkManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 获取音乐资源路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rain" ofType:@"mp3"];
    // 加载库到当前运行程序
    void *lib = dlopen("/System/Library/Frameworks/AVFoundation.framework/AVFoundation", RTLD_LAZY);
    if (lib) {
        // 获取类名称
        Class playerClass = NSClassFromString(@"AVAudioPlayer");
        // 获取函数方法
        SEL selector = NSSelectorFromString(@"initWithData:error:");
        // 调用实例化对象方法
        _runtime_Player = [[playerClass alloc] performSelector:selector withObject:[NSData dataWithContentsOfFile:path] withObject:nil];
        // 获取函数方法
        selector = NSSelectorFromString(@"play");
        // 调用播放方法
        [_runtime_Player performSelector:selector];
        NSLog(@"动态加载播放");
    }
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
