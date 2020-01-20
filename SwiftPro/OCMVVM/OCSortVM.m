//
//  OCSortVM.m
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

#import "OCSortVM.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "Define.h"

@interface OCSortVM()

@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation OCSortVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [@[@121,@1121,@21,@22,@445,@2,@0,@6,@343,@222,@655] mutableCopy];
        self.arrayData = [@[@"插入排序", @"快速排序", @"选择排序"] mutableCopy];
        @weakify(self);
        [RACObserve(self, didSelectedSignal) subscribeNext:^(id  _Nullable x) {
            [self.didSelectedSignal subscribeNext:^(id  _Nullable x) {
                
            }];
        }];
    }
    return self;
}

@end
