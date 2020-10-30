//
//  AllPrefixHeader.h
//  CL
//
//  Created by eport2 on 2020/10/22.
//

#ifndef AllPrefixHeader_h
#define AllPrefixHeader_h


// MARK: -- Block 1

//  Log:日志输出
#ifdef DEBUG
# define NSLog(fmt, ...)                   NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(Format, ...)
#endif

#define WriteText(fmt, ...)  [NSString stringWithFormat:(@"%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]

#define PropertyBlock(Class, block) @property(nonatomic, copy) Class block

#define PropertyBool(b) @property(nonatomic, assign) BOOL b

#define PropertyEnumReadonly(Class, t) @property(nonatomic, assign, readonly) Class t

#define PropertyEnum(Class, t) @property(nonatomic, assign) Class t

#define PropertyString(s) @property(nonatomic,copy) NSString *s

#define PropertyStringNullable(s) @property(nonatomic,copy, nullable) NSString *s

#define PropertyNSInteger(s) @property(nonatomic,assign)NSInteger s

#define PropertyFloat(s) @property(nonatomic,assign) float s

#define PropertyLongLong(s) @property(nonatomic,assign) long long s

#define PropertyNSDictionary(s) @property(nonatomic,copy) NSDictionary *s
#define PropertyNSDictionaryNullable(s) @property(nonatomic,copy, nullable) NSDictionary *s

#define PropertyNSArray(s) @property(nonatomic,copy) NSArray *s

#define PropertyNSMutableArray(s) @property(nonatomic,strong) NSMutableArray *s

#define PropertyNSMutableDictionary(s) @property(nonatomic,strong) NSMutableDictionary *s

#define PropertyTableView(t) @property(nonatomic, strong) UITableView *t

#define PropertyClass(c, s) @property(nonatomic, strong) c *s

#define StrValid(f)(f!=nil && [f isKindOfClass:[NSString class]]&& ![f isEqualToString:@""] && f.length != 0)

#define SafeStr(f)(StrValid(f)?f:@"")

#define HasString(str,eky)([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f)StrValid(f)

#define ValidDict(f)(f!=nil &&[f isKindOfClass:[NSDictionary class]])

#define ValidArray(f)(f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)

#define ValidNum(f)(f!=nil &&[f isKindOfClass:[NSNumber class]])

#define ValidClass(f,cls)(f!=nil &&[f isKindOfClass:[cls class]])

#define ValidData(f)(f!=nil &&[f isKindOfClass:[NSData class]])

#define IdToString(method) NSString *s = method

#ifndef dispatch_main_async
#define dispatch_main_async(block)\
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

/*
颜色
 */
#define COLOR_HEX(hexValue)                [UIColor colorWithHexValue:hexValue]
#define RGB_COLOR(r, g, b)                 [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define rgba(r,g,b,a)                      [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]
#define rgb(r,g,b)                      [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]

#define BM_BlueTextColor   COLOR_HEX(0x0099A8)


#define BASE_THEME_COLOR  COLOR_HEX(0x0099A8)
#define BASE_THEME_COLOR_Menu  COLOR_HEX(0x67CED2)
#define YQ_GRAY_FONT_COLOR  COLOR_HEX(0x4C4F54)
#define YQ_WATERMELON_RED_COLOR  COLOR_HEX(0xFF8083)
#define YQ_LIGHT_GRAY_COLOR  COLOR_HEX(0x8c8c8c)
#define YQ_LIGHT_BLACK_COLOR  COLOR_HEX(0x3d3830)
#define YQ_Little_GRAY_COLOR  COLOR_HEX(0xd4d8d9)
#define YQ_Purple_COLOR COLOR_HEX(0xEC4B7B)
#define YQ_MenuBlack_Color COLOR_HEX(0x4C4F53)

// 此App中使用的自定义字体颜色
#define BM_RED [UIColor redColor]
#define BM_DARKGRAY [UIColor darkGray]
#define BM_LIGHTGRAY [UIColor lightGrayColor]
#define BM_WHITE [UIColor whiteColor]
#define BM_GRAY [UIColor grayColor]
#define BM_FONTGRAY [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1]
#define BM_GREEN [UIColor greenColor]
#define BM_BLUE COLOR_HEX(0x1734FF)//[UIColor blueColor]
#define BM_CYAN [UIColor cyanColor]
#define BM_YELLOW [UIColor yellowColor]
#define BM_MAGENTA [UIColor magentaColor]
#define BM_ORANGE [UIColor orangeColor]
#define BM_PURPLE [UIColor purpleColor]
#define BM_BROWN [UIColor brownColor]
#define BM_CLEAR [UIColor clearColor]
#define BM_BLACK [UIColor blackColor]
//分割线颜色
#define BM_LINEVIEW [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1]
//分割线灰色颜色
#define BM_LINEGRAYVIEW [UIColor colorWithRed:211/256.0 green:225/256.0 blue:224/256.0 alpha:1]
//button粉色
#define BM_ThemePink YQ_WATERMELON_RED_COLOR//[UIColor colorWithRed:254/256.0 green:128/256.0 blue:131/256.0 alpha:1]


 
/**
 *  字体大小
 */
#define BM_FONTSIZE(f) [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(f)]
#define BM_BOLD_FONTSIZE(f)  [UIFont boldSystemFontOfSize:kSCREEN_MY_WIDTH(f)]
#define BM_FONTSIZE8 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(8.0)]
#define BM_FONTSIZE9 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(9.0)]
#define BM_FONTSIZE10 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(10.0)]
#define BM_FONTSIZE11 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(11.0)]
#define BM_FONTSIZE12 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(12.0)]
#define BM_FONTSIZE13 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(13.0)]
#define BM_FONTSIZE14 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(14.0)]
#define BM_FONTSIZE15 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(15.0)]
#define BM_FONTSIZE16 [UIFont systemFontOfSize:kSCREEN_MY_WIDTH(16.0)]

//
#define WeakSelf __weak __typeof(&*self) weakSelf = self;
#define StrongSelf __weak __typeof(&*WeakSelf) weakSelf = WeakSelf;
#define WSELF(obj)                         __weak typeof((obj))weakSelf = obj
#define SSELF(obj)                         __weak typeof((obj))strongSelf = obj

#define WeakS(type) __weak __typeof__(type) weakSelf = type;
#define StrongS(type) __strong __typeof__(type) strongSelf = type;

#define NSMutableArrayDefine(a) NSMutableArray *a = [NSMutableArray array]
#define NSMutableDictionaryDefine(a) NSMutableDictionary *a = [NSMutableDictionary dictionary]
#define NSArrayDefine(a) NSArray *a = [NSArray array]
#define NSDictionaryDefine(a) NSDictionary *a = [NSDictionary dictionary]
#define ClassDefine(c, s) c *s = c.new
#define ClassDefineWithProperty(c, s) s = c.new
#define ClassViewDefine(c, s, t, v) c *s = c.new; \
s.tag = t; \
[v addSubview: s];

#define ClassDefineVC(c, s) c *s = c.new; \
s.hidesBottomBarWhenPushed = true;

#define GetClassView(t, v) [v viewWithTag: t]

#define ClassLineDefine(c, s, t, v) c *s = c.new; \
s.tag = t; \
[v addSubview: s]; \
s.backgroundColor = UIColor.grayColor;

#define ClassDefineWithPropertyIf(c, s) if (!s) \
{ \
s = c.new; \
}

#define ClassDefineLazyWithPropertyIf(c, s, s1) \
- (c *)s1 \
{ \
    if (!s) \
    { \
    s = c.new; \
    } \
    return s; \
}

#define TableCellDefineDequeue(c, s, i, tv) c *s = [tv dequeueReusableCellWithIdentifier:i]


#define ClassViewDefineWithIf(c, s, v) if (!s) \
{ \
s = c.new; \
[v addSubview: s]; \
}

#define ClassViewDefineWithPropertyIf(c, s, t, v) if (!s) \
{ \
s = c.new; \
s.tag = t; \
[v addSubview: s]; \
}

#define ClassInit(method) if (self = [super init]) \
{ \
method; \
} \
return self

#define ClassInitWithoutMethod(method) \
- (instancetype)init \
{ \
  if (self = [super init]) \
  { \
    method; \
  } \
  return self; \
}

#define USER_DATA_PATH                      \
({\
NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];\
path = [path stringByAppendingPathComponent:@"loginUserData"];\
(path);\
})\

#define LPHHSingleton + (instancetype)sharedInstance; //.h文件中的定义
#define LPHMSingleton /* .m文件中的定义 */ \
static id shareInstance = nil;\
+ (instancetype)sharedInstance {\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        shareInstance = [[self alloc] init];\
    });\
    \
    return shareInstance;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
    \
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        shareInstance = [super allocWithZone:zone];\
    });\
    \
    return shareInstance;\
}\
\
- (id)copyWithZone:(NSZone *)zone{\
    return shareInstance;\
}

/**
 *  显示HUD
 */
#define DEFN_SHOW_HUD  @"show_hud"

/**
 *  隐藏HUD
 */
#define DEFN_HIDE_HUD  @"hide_hud"

#define LOGIN_STATUS_KEY @"LOGIN_STATUS_KEY"


/** textField的占位字符串颜色 */
#define BM_Color_Placeholder        [UIColor colorWithHexString:@"#d2d8e1"]
/** 分割线的颜色 */
#define BM_Color_SeparatorColor     [UIColor colorWithHexString:@"#E6E6E6"]
#define BM_Color_GrayColor          [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1]
/** 99灰，用于不显著的副标题、订单信息等 */
#define BM_Color_huiColor [UIColor colorWithHexString:@"#999999"]
/** 33黑，用于主要标题 */
#define BM_Color_BlackColor         [UIColor colorWithHexString:@"#333333"]
/** 用于分割线 */
#define BM_Color_LineColor         [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]


#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height //状态栏高度
#define iPhoneXHeight  812 //iphonex 高度
#define kNavBarHeight  44.0 //导航栏高度
#define kTabBarHeight  (kStatusBarHeight > 20.0 ? 83.0 : 49) //标签栏的高度
#define kTopHeight kStatusBarHeight + kNavBarHeight //状态栏加导航栏高度
#define isTypeiPhoneX (kStatusBarHeight > 20.0 ? YES : NO)
#define kHomeHeight (isTypeiPhoneX ? 34 : 0)


// MARK: -- Block 2

// .h 调用
#define singleton_for_header(className) \
\
+ (className *)shared##className;


// .m 调用
#if __has_feature(objc_arc)
// ARC default

#define singleton_for_class(className) \
\
+ (className *)shared##className { \
    static className *shared##className = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        shared##className = [[self alloc] init]; \
    }); \
    return shared##className; \
}


#else
// MRC

#define singleton_for_class(className) \
\
static className *shared##className = nil; \
\
+ (className *)shared##className \
{ \
    @synchronized(self) \
    { \
        if (shared##className == nil) \
        { \
            shared##className = [[self alloc] init]; \
        } \
    } \
    \
    return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
    @synchronized(self) \
    { \
        if (shared##className == nil) \
        { \
            shared##className = [super allocWithZone:zone]; \
            return shared##className; \
        } \
    } \
    \
    return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
    return self; \
} \
\
- (id)retain \
{ \
    return self; \
} \
\
- (NSUInteger)retainCount \
{ \
    return NSUIntegerMax; \
} \
\
- (void)release \
{ \
} \
\
- (id)autorelease \
{ \
    return self; \
}


#endif


// MARK: -- Block 3

/**
 *    获取视图宽度
 *
 *    @param     view     视图对象
 *
 *    @return    宽度
 */
#define DEF_WIDTH(view) view.bounds.size.width

/**
 *    获取视图高度
 *
 *    @param     view     视图对象
 *
 *    @return    高度
 */
#define DEF_HEIGHT(view) view.bounds.size.height

/**
 *    获取视图原点横坐标
 *
 *    @param     view     视图对象
 *
 *    @return    原点横坐标
 */
#define DEF_LEFT(view) view.frame.origin.x

/**
 *    获取视图原点纵坐标
 *
 *    @param     view     视图对象
 *
 *    @return    原点纵坐标
 */
#define DEF_TOP(view) view.frame.origin.y

/**
 *    获取视图右下角横坐标
 *
 *    @param     view     视图对象
 *
 *    @return    右下角横坐标
 */
#define DEF_RIGHT(view) (DEF_LEFT(view) + DEF_WIDTH(view))

/**
 *    获取视图右下角纵坐标
 *
 *    @param     view     视图对象
 *
 *    @return    右下角纵坐标
 */
#define DEF_BOTTOM(view) (DEF_TOP(view) + DEF_HEIGHT(view))


// 屏幕比例
#define kSCALE [[UIScreen mainScreen] bounds].size.width/375
// 主屏的size
#define kSCREEN_SIZE   [[UIScreen mainScreen] bounds].size
// 主屏的frame
#define kSCREEN_FRAME  [UIScreen mainScreen].bounds
/**
 *  判断屏幕尺寸是否为640*1136
 *
 *    @return    判断结果（YES:是 NO:不是）
 */
#define DEF_SCREEN_IS_640_1136 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6 6s 7系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6p 6sp 7p系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)

//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)



#define STATUS_BAR_HEIGHT_VERSION ([[UIDevice currentDevice].systemVersion floatValue] >=11 ? STATUS_BAR_HEIGHT : STATUS_BAR_HEIGHT + 20.f)
// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_PhoneXAll ? 44.f : 20.f)
// 导航栏高度
#define DEF_NAVBARHEIGHT (IS_PhoneXAll ? 88.f : 64.f)
// tabBar高度
#define DEF_TABBARHEIGHT (IS_PhoneXAll ? (49.f+34.f) : 49.f)
// 底部高度
#define kBOTTOMHEIGHT (IS_PhoneXAll ? 34.f:0.f)

// 去除导航栏和状态栏的高度
#define DEF_CONTENT  kSCREEN_HEIGHT - DEF_NAVBARHEIGHT
// 获取appDelegate
#define KAPPDELEGATE     [AppDelegate appDelegate]
// 宽、高
#define kSCREEN_MY_WIDTH(a)        (a) * [[UIScreen mainScreen] bounds].size.width / 375.0
#define kSCREEN_MY_HEIGHT(a)       (a) * [[UIScreen mainScreen] bounds].size.height / 667.0

//#define kMaxLengthKey @"kMaxLengthKey"
// 主屏幕宽、高
#define kSCREEN_WIDTH                      [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT                     [UIScreen mainScreen].bounds.size.height
// 屏幕适配宽、高
#define kCEIL_SCREEN_MY_WIDTH(a)           ceil(kSCREEN_MY_WIDTH(a))
#define kCEIL_SCREEN_MY_HEIGHT(a)          ceil(kSCREEN_MY_HEIGHT(a))


#define Production 1

// MARK: -- Block 4

/**
 *    永久存储对象
 *
 *  NSUserDefaults保存的文件在tmp文件夹里
 *
 *    @param    object      需存储的对象
 *    @param    key         对应的key
 */
#define DEF_PERSISTENT_SET_OBJECT(object, key)                                                                                                 \
({                                                                                                                                             \
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];                                                                          \
    [defaults setObject:object forKey:key];                                                                                                    \
    [defaults synchronize];                                                                                                                    \
})

/**
 *    取出永久存储的对象
 *
 *    @param    key     所需对象对应的key
 *    @return    key     所对应的对象
 */
#define DEF_PERSISTENT_GET_OBJECT(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key]


/**
 *  清除 NSUserDefaults 保存的所有数据
 */
#define DEF_PERSISTENT_REMOVE_ALLDATA   [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]


/**
 *  清除 NSUserDefaults 保存的指定数据
 */
#define DEF_PERSISTENT_REMOVE(_key)                                         \
({                                                                          \
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
    [defaults removeObjectForKey:_key];                                     \
    [defaults synchronize];                                                 \
})



#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]

#define KHomeHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HomeSearchhistories.plist"]
#define KColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define KScreenWidth   [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height


// MARK: -- Block 5

//颜色
#define HGColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BASE_COLOUR HGColorFromRGB(0xEDEDED)
#define BLACK_COLOUR HGColorFromRGB(0x333333)
#define GRAY_COLOUR HGColorFromRGB(0x666666)
#define LIGHT_GRAY_COLOUR HGColorFromRGB(0x999999)
#define LINE_COLOUR HGColorFromRGB(0xEEEEEE)
#define BLUE_COLOUR HGColorFromRGB(0x2261c9)

#define BLUE_NEW_COLOUR HGColorFromRGB(0x082E6C)
#define BASE_NEW_COLOUR HGColorFromRGB(0xEDEDED)

#define HMColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define HMTintColor HMColor(94, 185, 173)
#define LOGBTN_COLOUR [UIColor colorWithRed:32/255.0 green:186/255.0 blue:248/255.0 alpha:1]
#define LIGHT_BLUE_COLOUR [UIColor colorWithRed:33/255.0 green:150/255.0 blue:226/255.0 alpha:1]

/*
 宏定义屏幕尺寸
 */
#define HG_SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define HG_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define HG_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/*
 导航栏/标签栏尺寸
 */
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height //状态栏高度
#define iPhoneXHeight  812 //iphonex 高度
#define kNavBarHeight  44.0 //导航栏高度
#define kTabBarHeight  (kStatusBarHeight > 20.0 ? 83.0 : 49) //标签栏的高度
#define kTopHeight kStatusBarHeight + kNavBarHeight //状态栏加导航栏高度
#define isTypeiPhoneX (kStatusBarHeight > 20.0 ? YES : NO)
#define kHomeHeight (isTypeiPhoneX ? 34 : 0)


#define isSmallScreen (HG_SCREEN_WIDTH<750/2.0 ? YES : NO)

//cell的宽度高度
#define BaseItemCellWidth (HG_SCREEN_WIDTH-20)/4.0  //宽度
#define BaseItemCellHeight (isSmallScreen ? (750/2.0-20)/4.0+15 : BaseItemCellWidth+15) //高度


//APP上线版本号
#define APP_VERSION [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//当前的状态是登录状态
#define LOGIN_STATUS @"loginstatus"

//权限列表数组信息
#define HG_ALL_APPLICATION_AUTH_LIST   @"ALL_APPLICATION_AUTH_LIST"

//小应用更新提示
#define UPDATE_APPLICATION_MESSAGE @"小应用版本已经更新，请及时更新到最新版本使用！"

//网络异常提示
#define NOT_NETWORK_MESSAGE @"网络连接异常，请稍后再试！"

//密码格式提示
#define ACCOUNT_PASSWORD_MESSAGE @"密码必须包含8-16位大写字母、小写字母、数字和符号中任意三种及以上的组合"

//下载失败提示
#define FAIL_DOWNLOAD_MESSAGE @"小应用下载失败"

/** NSLog 输出宏*/
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s %s:%d\t%s\n",__TIME__,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)


#endif


// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \

#endif /* AllPrefixHeader_h */
