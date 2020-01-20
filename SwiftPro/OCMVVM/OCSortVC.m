//
//  OCSortVC.m
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

#import "OCSortVC.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "DYKit.h"
#import "OCSortVM.h"
#import "Define.h"

@interface OCSortVC ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) OCSortVM *vm;

@end

@implementation OCSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.vm = [OCSortVM new];
    @weakify(self);
    [self.tableView assembly:^(UITableViewCell *cell, id model, NSIndexPath *indexPath) {
        cell.textLabel.text = model;
    } withPlug:UITableViewCell.class];
    
    [[self.vm rac_valuesForKeyPath:@"arrayData" observer:self] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
//        RACTupleUnpack(NSMutableArray *array) = x;
        self.tableView.data = x;
    }];
    
    self.vm.didSelectedSignal = self.tableView.didSelectRowAtIndexPathSignal;
    [self.tableView.didSelectRowAtIndexPathSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        RACTupleUnpack(UITableView *tableView, NSIndexPath *index) = x;
        NSLog(@"indexPath = %@", index);

    }];
    
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
