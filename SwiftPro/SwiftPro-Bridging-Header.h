//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "KxMovieViewController.h"
//#import "WOCrashProtectorManager.h"
#import "CYLTabBarController.h"

#import <dlfcn.h>

#import "HGNotifactionMainView.h"

//#import <Masonry/Masonry.h>
//#import <AuthenticationServices/AuthenticationServices.h>


//void printApplicationState()
//{
//    Class UIApplicationClass = NSClassFromString(@"UIApplication");
//    if (Nil == UIApplicationClass) {
//        void *handle = dlopen("System/Library/Frameworks/UIKit.framework/UIKit", RTLD_NOW);
//        if (handle) {
//            UIApplicationClass = NSClassFromString(@"UIApplication");
//            assert(UIApplicationClass != Nil);
//            NSInteger applicationState = [UIApplicationClass applicationState];
//            printf("app state: %ti\n", applicationState);
//            if (0 != dlclose(handle)) {
//                printf("dlclose failed! %s\n", dlerror());
//            }
//        } else {
//            printf("dlopen failed! %s\n", dlerror());
//        }
//    } else {
//        printf("app state: %ti\n", [UIApplicationClass applicationState]);
//    }
//}
