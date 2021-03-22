//
//  BaiduTrackVC.swift
//  SwiftPro
//
//  Created by eport2 on 2021/1/29.
//  Copyright © 2021 eport. All rights reserved.
//

import UIKit
import BaiduTraceSDK

class BaiduTrackVC: UIViewController {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        title = "鹰眼轨迹"
        
        requestLocationAuthByPlist()
    }
    
    func requestLocationAuthByPlist() {
        let bundle = Bundle.main
        let accessTypeAlways = bundle.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription")
        let accessTypeWhen = bundle.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription")
        let accessTypeBoth = bundle.object(forInfoDictionaryKey: "NSLocationAlwaysAndWhenInUseUsageDescription")
        if accessTypeAlways != nil && accessTypeWhen != nil && accessTypeBoth != nil {
            // 申请前后台定位权限
            locationManager.requestAlwaysAuthorization()
        }else{
            // 申请前台定位权限
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func doSomething() {
        
    }
    
//    - (void)requestLocAuthByPlist {
//        NSBundle *bundle = [NSBundle mainBundle];
//        NSObject *accessTypeAlways = [bundle objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"];
//        NSObject *accessTypeWhen = [bundle objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"];
//        NSObject *accessTypeBoth = [bundle objectForInfoDictionaryKey:@"NSLocationAlwaysAndWhenInUseUsageDescription"];
//        if (accessTypeAlways && accessTypeWhen && accessTypeBoth) {
//            // 申请前后台定位权限
//            [self.locationManager requestAlwaysAuthorization];
//        } else if (accessTypeWhen){
//            // 申请前台定位权限
//            [self.locationManager requestWhenInUseAuthorization];
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
