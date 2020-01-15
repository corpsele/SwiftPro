//
//  RACCollectionTestVC.h
//  SwiftPro
//
//  Created by eport2 on 2020/1/14.
//  Copyright © 2020 eport. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACCollectionTestVC : UIViewController

@end

NS_ASSUME_NONNULL_END

typedef enum : NSUInteger {
    LongPressStatus_Begin,
    LongPressStatus_Change,
    LongPressStatus_End,
    LongPressStatus_Cancel,
} LongPressStatus;

typedef void (^LongPressBlock)(LongPressStatus status, UIGestureRecognizer *ges);

@interface CollectionTestCell : UICollectionViewCell

@property (nonatomic, copy) LongPressBlock block;

@end
