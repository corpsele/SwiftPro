//
//  CheckSignCer.m
//  SwiftPro
//
//  Created by eport2 on 2020/1/6.
//  Copyright © 2020 eport. All rights reserved.
//

#import "CheckSignCer.h"

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

@end
