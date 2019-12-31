//
//  OCMVVMVC.m
//  SwiftPro
//
//  Created by eport2 on 2019/12/26.
//  Copyright © 2019 eport. All rights reserved.
//

#import "OCMVVMVC.h"

#import "RVMViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "OCMVVMVM.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>
#import "OCMVVMCell.h"
#import <Toast/Toast.h>
#import <NSLogger/NSLogger.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Messages/Messages.h>
#import <SDWebImage/SDWebImage.h>

#define kCellIdentifier @"kCellIdentifier"

#ifdef DEBUG

    static const int ddLogLevel = DDLogLevelInfo;

#else

    static const int ddLogLevel = DDLogLevelWarning;

#endif

static char tableViewDataSource;

@interface OCMVVMVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) OCMVVMVM *vm;

@property (nonatomic, strong) UIButton *btnDone;

@property (nonatomic, strong) UIView *viewBackground;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *arrayData;

@end

@implementation OCMVVMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"OCMVVM";
    self.navigationController.navigationBarHidden = false;
    self.view.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0, *)) {
     self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
     } else {
     self.automaticallyAdjustsScrollViewInsets = NO;
     }
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.extendedLayoutIncludesOpaqueBars = YES;
     self.edgesForExtendedLayout = UIRectEdgeNone;
    NSDictionary *dic = @{@"title": @"dd", @"subtitle": @"ddd"};
    _arrayData = [@[dic] mutableCopy];
    @weakify(self);
    dispatch_main_async_safe(^{
        @strongify(self);
        while (self.arrayData.count < 50) {
            [self.arrayData addObject:dic];
        }
    });
    
    [RACObserve(self, arrayData) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [UIView transitionWithView:self.tableView duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            [self.tableView beginUpdates];
            [self.tableView reloadData];
            [self.tableView endUpdates];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    [self initViews];
    
    self.vm = [OCMVVMVM new];
    
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        [self.navigationController setNavigationBarHidden:false animated:true];
    }];
    
    [[self rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        [self.navigationController setNavigationBarHidden:true animated:true];
    }];
    
    NSBundle *bundle = [NSBundle bundleWithPath:@"Frameworks/BatteryCenter.framework"];
    if ([bundle load]) {
        
    }
    
}

- (void)initViews
{
    self.viewBackground = [UIView new];
    [self.view addSubview:self.viewBackground];
    [self.viewBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
       make.edges.mas_equalTo(self.view.safeAreaInsets);
       } else {
       make.edges.equalTo(self.view);
       }
    }];
    
    _btnDone = [UIButton new];
    [_btnDone setTitle:@"Do" forState:UIControlStateNormal];
    [_btnDone setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    _btnDone.backgroundColor = UIColor.blackColor;
    [self.viewBackground addSubview:_btnDone];
    [_btnDone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.viewBackground);
        make.height.mas_equalTo(50.0);
    }];
    [[_btnDone rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        MSMessage *msg = [MSMessage new];
        if([msg respondsToSelector:@selector(isFromMe)]){
            BOOL isFromMe = (BOOL)[msg performSelector:@selector(isFromMe)];
            DDLogInfo(@"%d", isFromMe);
        }
        MSSticker *sticker = [MSSticker new];
        if ([sticker respondsToSelector:@selector(_thumbnail)]) {
            UIImage *img = [sticker performSelector:@selector(_thumbnail)];
            DDLogInfo(@"%@", img);
        }
        if ([self.view respondsToSelector:@selector(recursiveDescription)]) {
            DDLogInfo(@"%@", [self.view performSelector:@selector(recursiveDescription)]);
        }
        if ([self.view respondsToSelector:@selector(_focusedSound)]) {
            long long l = (long long)[self.view performSelector:@selector(_focusedSound)];
            DDLogInfo(@"%lld", l);
        }
    }];
    
    self.tableView = [UITableView new];
    [self.viewBackground addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.viewBackground);
        make.top.equalTo(_btnDone.mas_bottom);
        make.bottom.equalTo(self.viewBackground);
    }];
    
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:OCMVVMCell.class forCellReuseIdentifier:kCellIdentifier];
    
    @weakify(self);
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        RACTupleUnpack(UITableView *tableView, NSIndexPath *indexPath) = x;
        OCMVVMCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        NSLog(@"cell = %@, indexPath = %@",cell, self.arrayData[indexPath.row]);
        [self.view makeToast:[NSString stringWithFormat:@"cell = %@, indexPath = %@",cell, self.arrayData[indexPath.row][@"title"]]];
        DDLogInfo(@"cell = %@, indexPath = %@",cell, self.arrayData[indexPath.row]);
        
    }];
    
    [[self rac_signalForSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        RACTupleUnpack(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) = x;
        OCMVVMCell *cell1 = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        [UIView transitionWithView:cell duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    [[self rac_signalForSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:) fromProtocol:@protocol(UITableViewDataSource)] subscribeNext:^(RACTuple * _Nullable x) {
        RACTupleUnpack(UITableView *tableView, UITableViewCellEditingStyle style, NSIndexPath *indexPath) = x;
        @try {
            [tableView beginUpdates];
            [self.arrayData removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [tableView endUpdates];
        } @catch (NSException *exception) {
            NSLog(@"exception = %@", exception.description);
        } @finally {
            
        }

        
    }];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
//    @weakify(self);
//    [[self.tableView rac_signalForSelector:@selector(tableView:cellForRowAtIndexPath:) fromProtocol:@protocol(UITableViewDataSource)] subscribeNext:^(RACTuple * _Nullable x) {
//        RACTupleUnpack(UITableView *tableView, NSIndexPath *indexPath) = x;
//
//    } error:^(NSError * _Nullable error) {
//
//    }];
    
//    map:^id _Nullable(RACTuple * _Nullable value) {
//                 NSLog(@"x first = %@ second = %@", value.first, value.second);
//        return [UITableViewCell new];
//    }];
     
//     subscribeNext:^(RACTuple * _Nullable x) {
//         NSLog(@"x first = %@ second = %@", x.first, x.second);
//     } error:^(NSError * _Nullable error) {
//
//     }];
    
//    [[[self rac_signalForSelector:@selector(tableView:numberOfRowsInSection:) fromProtocol:@protocol(UITableViewDataSource)] map:^id _Nullable(RACTuple * _Nullable value) {
//        return RACTuplePack(value.first, @1);
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x = %@", x);
//    }];
    
//     subscribeNext:^(RACTuple * _Nullable x) {
//         @strongify(self);
//         x = RACTuplePack(self.tableView, @1);
//         RACTupleUnpack(UITableView *tableView, NSNumber *count) = x;
//         NSLog(@"count = %@", count);
//     } error:^(NSError * _Nullable error) {
//
//     }];
    
//    [[[self rac_signalForSelector:@selector(tableView:heightForRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
//        return RACTuplePack(value.first, @30.0);
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x = %@", x);
//    }];
//     subscribeNext:^(RACTuple * _Nullable x) {
//         NSLog(@"x first = %@ second = %@", x.first, x.second);
//     } error:^(NSError * _Nullable error) {
//
//     }]
    
//     RACDelegateProxy *delegateProxy = [[RACDelegateProxy alloc]initWithProtocol:@protocol(UITableViewDataSource)];
//     [[delegateProxy rac_signalForSelector:@selector(tableView:heightForRowAtIndexPath:)] subscribeNext:^(RACTuple *args) {
//
//    }];
//
//    self.tableView.dataSource = (id<UITableViewDataSource>)delegateProxy;
//
//    objc_setAssociatedObject(self.tableView, &tableViewDataSource, delegateProxy, OBJC_ASSOCIATION_ASSIGN);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OCMVVMCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    @weakify(self);
    [[cell rac_valuesForKeyPath:@"lblTitle" observer:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:UILabel.class]) {
            ((UILabel*)x).text = self.arrayData[indexPath.row][@"title"];
        }
    }];
    [[cell rac_valuesForKeyPath:@"lblSubTitle" observer:nil] subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:UILabel.class]) {
            ((UILabel*)x).text = self.arrayData[indexPath.row][@"subtitle"];
        }
    }];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return true;
}

@end
