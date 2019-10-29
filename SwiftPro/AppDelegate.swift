//
//  AppDelegate.swift
//  SwiftPro
//
//  Created by eport on 2019/7/11.
//  Copyright © 2019 eport. All rights reserved.
//

import IQKeyboardManager
import UIKit
// import CocoaLumberjack
// import Spring
// import pop
// import JJException
// import OOMDetector

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var vc: ViewController?
    var mainNavi: MainNaviViewController?
    var allowRotation: Bool = true

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        WOCrashProtectorManager.makeAllEffective();
//        JJException.configExceptionCategory(.allExceptZombie);
//        JJException.startGuard();
//        JJException.register(self);
        // Override point for customization after application launch.
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = sb.instantiateViewController(withIdentifier: "ViewController") as? ViewController

        mainNavi = MainNaviViewController(rootViewController: vc ?? UIViewController())
        mainNavi?.isNavigationBarHidden = true

        window?.rootViewController = mainNavi

//        addStatusBar();
        IQKeyboardManager.shared().enableDebugging = true

//        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
//
//        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
//        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
//        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
//        DDLog.add(fileLogger)
//
//            DDLogVerbose("Verbose")
//        DDLogDebug("Debug")
//        DDLogInfo("Info")
//        DDLogWarn("Warn")
//        DDLogError("Error")

//        OOMDetector.getInstance()?.setupWithDefaultConfig()
//        OOMDetector.getInstance()?.setupLeakChecker()

        return true
    }

    func applicationWillResignActive(_: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        if let vc = window?.topMostWindowController() {
//            if vc.isKind(of: ViewController.self) {
//                return .portrait
//            }
//        }
        if allowRotation {
            return [.portrait, .landscapeRight];
        }
        return .portrait
    }

    func handleCrashException(_ exceptionMessage: String, extraInfo _: [AnyHashable: Any]?) {
        print(exceptionMessage)
    }
}
