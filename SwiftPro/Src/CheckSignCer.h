//
//  CheckSignCer.h
//  SwiftPro
//
//  Created by eport2 on 2020/1/6.
//  Copyright © 2020 eport. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckSignCer : NSObject

+ (instancetype)shared;
+ (BOOL)isFromJailbrokenChannel;

@end

NS_ASSUME_NONNULL_END
