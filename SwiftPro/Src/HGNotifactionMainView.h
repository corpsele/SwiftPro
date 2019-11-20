//
//  HGNotifactionMainView.h
//  SwiftPro
//
//  Created by eport2 on 2019/11/19.
//  Copyright © 2019 eport. All rights reserved.
//

#import <UIKit/UIKit.h>

///点击Block
typedef void(^HGNotifactionViewBlock)(NSInteger);

NS_ASSUME_NONNULL_BEGIN
// MARK: 通知视图
/// @brief: 通知视图
@interface HGNotifactionMainView : UIView


/// 初始化通知视图
/// @param frame frame
/// @param duration 滚动间隔
/// @param array 数据数组
- (id)initWithFrame:(CGRect)frame withDuration:(CGFloat)duration withArray:(NSArray *)array;


/// 点击Block
@property (nonatomic, copy) HGNotifactionViewBlock notifactionBlock;

@end

NS_ASSUME_NONNULL_END


// MARK: 滚动数据源
/// @brief 滚动数据源
@interface HGNotifactionMainDataSource : NSObject


/// 图标地址
@property (nonatomic, copy) NSString * _Nullable imgUrl;

/// 标题
@property (nonatomic, copy) NSString * _Nullable strTitle;

/// 副标题
@property (nonatomic, copy) NSString * _Nullable strSubText;

/// 日期文本
@property (nonatomic, copy) NSString * _Nullable strDate;

@end
