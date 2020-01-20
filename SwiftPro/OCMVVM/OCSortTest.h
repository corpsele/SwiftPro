//
//  OCSortTest.h
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCSortTest : NSObject

+ (instancetype)shared;

-(void)bubbleSequence:(NSMutableArray *)arr;

-(void)chooseSequence:(NSMutableArray *)arr;

-(NSMutableArray *)insertSequence:(NSMutableArray *)arr;

-(void)quickSequence:(NSMutableArray *)arr andleft:(int)left andright:(int)right;

@end

NS_ASSUME_NONNULL_END
