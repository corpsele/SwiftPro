//
//  RACCollectionTestVC.m
//  SwiftPro
//
//  Created by eport2 on 2020/1/14.
//  Copyright © 2020 eport. All rights reserved.
//

#import "RACCollectionTestVC.h"
#import "UICollectionView+DYCollectionViewBinder.h"
#import <Masonry/Masonry.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Toast/Toast.h>
#import <SDWebImage/SDWebImage.h>

#ifdef DEBUG

    static const int ddLogLevel = DDLogLevelInfo;

#else

    static const int ddLogLevel = DDLogLevelWarning;

#endif

@interface RACCollectionTestVC ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation RACCollectionTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = false;
    self.view.backgroundColor = UIColor.whiteColor;
    self.arrayData = [@[@{@"id": @"1", @"name": @"fff"},@{@"id": @"2", @"name": @"fff"},@{@"id": @"3", @"name": @"fff"},@{@"id": @"4", @"name": @"fff"},@{@"id": @"5", @"name": @"fff"}] mutableCopy];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(150, 100);
    layout.minimumLineSpacing = 1.0;
    layout.minimumInteritemSpacing = 2.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(300.0);
    }];
    
    @weakify(self);
    
    [self.collectionView assembly:^(CollectionTestCell *cell, id model, NSIndexPath *indexPath) {
        @strongify(self);
        UILabel *label = [cell valueForKey:@"lblTitle"];
        label.text = [NSString stringWithFormat:@"%@ %@", model[@"id"], model[@"name"]];
        cell.block = ^(LongPressStatus status, UIGestureRecognizer *ges){
            switch (status) {
                case LongPressStatus_Begin:
                {
//                   NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[ges locationInView:self.collectionView]];
//                    self.selectedIndexPath = selectIndexPath;
                   [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                }
                    break;
                case LongPressStatus_Change:
                {
                    [self.collectionView updateInteractiveMovementTargetPosition:[ges locationInView:self.collectionView]];
                    
                }
                    
                    break;
                case LongPressStatus_End:
                    [self.collectionView endInteractiveMovement];
                    break;
                case LongPressStatus_Cancel:
                    [self.collectionView cancelInteractiveMovement];
                    break;
                default:
                    break;
            }

        };
    } withPlug:CollectionTestCell.class];
    


    
//    [self.collectionView setTargetCollectionIndexPathForMoveFromRowAtIndexPath:^NSIndexPath *(UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath) {
//        [collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:proposedDestinationIndexPath];
//        return sourceIndexPath;
//    }];
    
    self.collectionView.data = self.arrayData;
    
    [[[self.collectionView.didSelectItemAtIndexPathSignal reduceEach:^id(UICollectionView *collectionView, NSIndexPath *indexPath){
        @strongify(self);
        DDLogInfo(@"%@", (self.arrayData[indexPath.row])[@"id"]);
        [self.view makeToast:[NSString stringWithFormat:@"id = %@", (self.arrayData[indexPath.row])[@"id"]]];
        return indexPath;
    }] filter:^BOOL(id  _Nullable value) {
        return value != nil;
    }] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    [[[self.collectionView.collectionViewWillDisplayCellSignal reduceEach:^id (UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath){
        [UIView transitionWithView:cell duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
        return cell;
    }] filter:^BOOL(id  _Nullable value) {
        return value != nil;
    }] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    [self.collectionView setItemsForBeginningDragSession:^NSArray<UIDragItem *> *(UICollectionView *collectionView, id<UIDragSession> session, NSIndexPath *indexPath) {
        NSItemProvider *itemProvider = [[NSItemProvider alloc] init];
        
        UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
        
        return @[item];
    }];
    
    [self.collectionView setCanHandleDropSession:^BOOL(UICollectionView *collectionView, id<UIDropSession> session) {
        return session.localDragSession != nil ? true : false;
    }];
    
        [self.collectionView setCanMoveItemAtIndexPath:^BOOL(UICollectionView *collectionView, NSIndexPath *indexPath) {
            return true;
        }];

    [self.collectionView setMoveItemAtNSIndexPath:^(UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
        @strongify(self);
        [self.view makeToast:@"move indexPath"];
    }];
            
    [[[self.collectionView.moveItemAtIndexPathSignal reduceEach:^id (UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath){
            @strongify(self);
    //        self.arrayData[toIndexPath.row] = self.arrayData[fromIndexPath.row];
//        NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.colView]];
        DDLogInfo(@"sourceIndexPath = %@", sourceIndexPath);
        DDLogInfo(@"destinationIndexPath = %@", destinationIndexPath);
        DDLogInfo(@"self.arrayData = %@", self.arrayData);
        DDLogInfo(@"self.arrayData[1] = %@", self.arrayData[sourceIndexPath.row]);
        DDLogInfo(@"self.arrayData[2] = %@", self.arrayData[destinationIndexPath.row]);
        if (sourceIndexPath && destinationIndexPath && self.arrayData && self.arrayData.count > 0) {
                [self.arrayData exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
                        collectionView.data = self.arrayData;
                        [UIView transitionWithView:collectionView duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                            [collectionView reloadData];
                        } completion:^(BOOL finished) {

                        }];
        }
            
            return destinationIndexPath;
        }] filter:^BOOL(id  _Nullable value) {
            return value != nil;
        }] subscribeNext:^(id  _Nullable x) {
            
        }];
            
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPressGes];
    
    
    
}

- (void)longPressAction:(UILongPressGestureRecognizer *)ges
{
    //获取手势的变化
        switch (ges.state) {
            case UIGestureRecognizerStateBegan: {

    //            NSLog(@"手势开始");
                //获取手势在集合视图上的位置(indexPath)
                NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[ges locationInView:self.collectionView]];
//                //开始移动，根据indexPath路径
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];


            }
                break;
            case UIGestureRecognizerStateChanged: {

    //            NSLog(@"手势正在执行");
                //刷新位置
                [self.collectionView updateInteractiveMovementTargetPosition:[ges locationInView:self.collectionView]];

            }
                break;
            case UIGestureRecognizerStateEnded: {

    //            NSLog(@"手势结束");
                [self.collectionView endInteractiveMovement];
                
            }
                break;
            default: {

    //            NSLog(@"取消");
                [self.collectionView cancelInteractiveMovement];

            }
                break;
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



@interface CollectionTestCell()

@property (nonatomic, strong) UILabel *lblTitle;


@end

@implementation CollectionTestCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.grayColor;
        self.lblTitle = [UILabel new];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lblTitle];
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(100);
        }];
        
        UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//        [self.contentView addGestureRecognizer:longPressGes];
    }
    return self;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)ges
{
    //获取手势的变化
        switch (ges.state) {
            case UIGestureRecognizerStateBegan: {

    //            NSLog(@"手势开始");
                //获取手势在集合视图上的位置(indexPath)
//                NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
//                //开始移动，根据indexPath路径
//                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];

                if (self.block) {
                    self.block(LongPressStatus_Begin, ges);
                }
            }
                break;
            case UIGestureRecognizerStateChanged: {

    //            NSLog(@"手势正在执行");
                //刷新位置
//                [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
                if (self.block) {
                  self.block(LongPressStatus_Change, ges);
                }
            }
                break;
            case UIGestureRecognizerStateEnded: {

    //            NSLog(@"手势结束");
//                [self.collectionView endInteractiveMovement];
                if (self.block) {
                self.block(LongPressStatus_End, ges);
                }
            }
                break;
            default: {

    //            NSLog(@"取消");
//                [self.collectionView cancelInteractiveMovement];
                if (self.block) {
                self.block(LongPressStatus_Cancel, ges);
                }
            }
                break;
        }


}

@end
