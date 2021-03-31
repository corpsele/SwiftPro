//
//  FrameworkManagerVC.m
//  SwiftPro
//
//  Created by eport2 on 2021/3/22.
//  Copyright © 2021 eport. All rights reserved.
//

#import "FrameworkManagerVC.h"
#include <dlfcn.h>
@import CTAssetsPickerController;
#import "TZImagePickerController.h"

@import ReactiveObjC;

@interface FrameworkManagerVC () <CTAssetsPickerControllerDelegate, TZImagePickerControllerDelegate>

@property (nonatomic,strong) id runtime_Player;

@property (nonatomic, strong) UIButton *btnPhoto;

@property (nonatomic, strong) UIButton *btnTZPhoto;

@end

@implementation FrameworkManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    // Do any additional setup after loading the view.
    // 获取音乐资源路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"rain" ofType:@"mp3"];
//    // 加载库到当前运行程序
//    void *lib = dlopen("/System/Library/Frameworks/AVFoundation.framework/AVFoundation", RTLD_LAZY);
//    if (lib) {
//        // 获取类名称
//        Class playerClass = NSClassFromString(@"AVAudioPlayer");
//        // 获取函数方法
//        SEL selector = NSSelectorFromString(@"initWithData:error:");
//        // 调用实例化对象方法
//        _runtime_Player = [[playerClass alloc] performSelector:selector withObject:[NSData dataWithContentsOfFile:path] withObject:nil];
//        // 获取函数方法
//        selector = NSSelectorFromString(@"play");
//        // 调用播放方法
//        [_runtime_Player performSelector:selector];
//        NSLog(@"动态加载播放");
//    }
    
    @weakify(self);
    [[self.btnPhoto rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // init picker
                    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                
                    // set delegate
                    picker.delegate = self;
                    
                    // Optionally present picker as a form sheet on iPad
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        picker.modalPresentationStyle = UIModalPresentationFormSheet;
                    
                    // present picker
                    [self presentViewController:picker animated:YES completion:nil];
                });
        }];
    }];
    
    [[self.btnTZPhoto rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                    
//                TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
                TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:4 delegate:self pushPhotoPickerVc:true];
                [picker setAllowTakePicture:false];
                [picker setAllowTakeVideo:false];
                
                
                
                // You can get the photos by block, the same as by delegate.
                // 你可以通过block或者代理，来得到用户选择的照片.
                [picker setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
                    
                }];

                    
                    // Optionally present picker as a form sheet on iPad
//                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        picker.modalPresentationStyle = UIModalPresentationFullScreen;
                    
                    // present picker
                    [self presentViewController:picker animated:YES completion:nil];
                });
        }];

    }];
}

- (UIButton *)btnPhoto{
    if (!_btnPhoto) {
        _btnPhoto = UIButton.new;
        [_btnPhoto setTitle:@"Photo" forState:UIControlStateNormal];
        [_btnPhoto setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.view addSubview:_btnPhoto];
        [_btnPhoto setFrame:CGRectMake(120.0, 100.0, 120.0, 50.0)];
        
    }
    return _btnPhoto;
}

- (UIButton *)btnTZPhoto{
    if (!_btnTZPhoto) {
        _btnTZPhoto = UIButton.new;
        [_btnTZPhoto setTitle:@"TZPhoto" forState:UIControlStateNormal];
        [_btnTZPhoto setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.view addSubview:_btnTZPhoto];
        [_btnTZPhoto setFrame:CGRectMake(120.0, 200.0, 120.0, 50.0)];
        
    }
    return _btnTZPhoto;
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didSelectAsset:(PHAsset *)asset {
    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
         float imageSize = imageData.length; //convert to MB
        NSLog(@"%f",imageSize/1024);
         imageSize = imageSize/(1024*1024.0);
         NSLog(@"%f",imageSize);
     }];
    
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
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
