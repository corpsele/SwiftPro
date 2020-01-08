//
//  CheckSignCer.m
//  SwiftPro
//
//  Created by eport2 on 2020/1/6.
//  Copyright © 2020 eport. All rights reserved.
//

#import "CheckSignCer.h"
#import <sys/sysctl.h>

@implementation CheckSignCer

static CheckSignCer *checkSignCer;
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checkSignCer = [CheckSignCer new];
    });
    return checkSignCer;
}

- (void)checkDebugWithExit
{
    if (checkDebugger()) {
        exit(0);
       
    }
}

+ (BOOL)isFromJailbrokenChannel
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        checkSignCer = [CheckSignCer new];
//    });
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey];
    if (![bundleId isEqualToString:@"com.chinaportdatacentre.SwiftPro"]) {
        return YES;
    }
    //取出embedded.mobileprovision这个描述文件的内容进行判断
    NSString *mobileProvisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    NSData *rawData = [NSData dataWithContentsOfFile:mobileProvisionPath];
    NSString *rawDataString = [[NSString alloc] initWithData:rawData encoding:NSASCIIStringEncoding];
    NSRange plistStartRange = [rawDataString rangeOfString:@"<plist"];
    NSRange plistEndRange = [rawDataString rangeOfString:@"</plist>"];
    if (plistStartRange.location != NSNotFound && plistEndRange.location != NSNotFound) {
        NSString *tempPlistString = [rawDataString substringWithRange:NSMakeRange(plistStartRange.location, NSMaxRange(plistEndRange))];
        NSData *tempPlistData = [tempPlistString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *plistDic =  [NSPropertyListSerialization propertyListWithData:tempPlistData options:NSPropertyListImmutable format:nil error:nil];
        
//        NSArray *applicationIdentifierPrefix = [plistDic getArrayValueForKey:@"ApplicationIdentifierPrefix" defaultValue:nil];
        NSArray *applicationIdentifierPrefix = [plistDic valueForKey:@"ApplicationIdentifierPrefix"];
//        NSDictionary *entitlementsDic = [plistDic getDictionaryValueForKey:@"Entitlements" defaultValue:nil];
        NSDictionary *entitlementsDic = [plistDic valueForKey:@"Entitlements"];
//        NSString *mobileBundleID = [entitlementsDic getStringValueForKey:@"application-identifier" defaultValue:nil];
        NSString *mobileBundleID = [entitlementsDic valueForKey:@"application-identifier"];
        if (applicationIdentifierPrefix.count > 0 && mobileBundleID != nil) {
            if (![mobileBundleID isEqualToString:[NSString stringWithFormat:@"%@.%@",[applicationIdentifierPrefix firstObject],@"7CA8C4DULN.cn.gov.customs.zshg"]]) {
                return YES;
            }
        }
    }

    return NO;
    
}

void  checkCodesign(NSString *id){
    // 描述文件路径
    NSString *embeddedPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    // 读取application-identifier  注意描述文件的编码要使用:NSASCIIStringEncoding
    NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
    NSArray *embeddedProvisioningLines = [embeddedProvisioning componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (int i = 0; i < embeddedProvisioningLines.count; i++) {
        if ([embeddedProvisioningLines[i] rangeOfString:@"application-identifier"].location != NSNotFound) {
            
            NSInteger fromPosition = [embeddedProvisioningLines[i+1] rangeOfString:@"<string>"].location+8;
            
            NSInteger toPosition = [embeddedProvisioningLines[i+1] rangeOfString:@"</string>"].location;
            
            NSRange range;
            range.location = fromPosition;
            range.length = toPosition - fromPosition;
            
            NSString *fullIdentifier = [embeddedProvisioningLines[i+1] substringWithRange:range];
            NSArray *identifierComponents = [fullIdentifier componentsSeparatedByString:@"."];
            NSString *appIdentifier = [identifierComponents firstObject];
       
            // 对比签名ID
            if (![appIdentifier isEqual:id]) {
                //exit
                exit(0);
            }
            break;
        }
    }
}


bool checkDebugger(){
    //控制码
    int name[4];//放字节码-查询信息
    name[0] = CTL_KERN;//内核查看
    name[1] = KERN_PROC;//查询进程
    name[2] = KERN_PROC_PID; //通过进程id查进程
    name[3] = getpid();//拿到自己进程的id
    //查询结果
    struct kinfo_proc info;//进程查询信息结果
    size_t info_size = sizeof(info);//结构体大小
    int error = sysctl(name, sizeof(name)/sizeof(*name), &info, &info_size, 0, 0);
    assert(error == 0);//0就是没有错误
    
    //结果解析 p_flag的第12位为1就是有调试
    //p_flag 与 P_TRACED =0 就是有调试
    return ((info.kp_proc.p_flag & P_TRACED) !=0);
   
}

@end
