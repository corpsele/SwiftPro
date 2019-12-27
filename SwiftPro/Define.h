//
//  Define.h
//  SwiftPro
//
//  Created by eport2 on 2019/12/26.
//  Copyright © 2019 eport. All rights reserved.
//

#ifndef Define_h
#define Define_h

//是否是iPhone X
#define is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//状态栏高度
#define StatusBarHeight (is_iPhoneX ? 44.f : 20.f)
// 导航高度
#define NavigationBarHeight 44.f
// Tabbar高度. 49 + 34 = 83
#define TabbarHeight (is_iPhoneX ? 83.f : 49.f)
// Tabbar安全区域底部间隙
#define TabbarSafeBottomMargin (is_iPhoneX ? 34.f : 0.f)
// 状态栏和导航高度
#define StatusBarAndNavigationBarHeight (is_iPhoneX ? 88.f : 64.f)
#define ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#endif /* Define_h */
