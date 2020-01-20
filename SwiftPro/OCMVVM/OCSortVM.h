//
//  OCSortVM.h
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCSortVM : NSObject

@property (nonatomic, strong) RACSignal *didSelectedSignal;

@end

NS_ASSUME_NONNULL_END
