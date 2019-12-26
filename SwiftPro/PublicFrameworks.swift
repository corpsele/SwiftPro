//
//  PublicFrameworks.swift
//  SwiftPro
//
//  Created by eport on 2019/7/12.
//  Copyright © 2019 eport. All rights reserved.
//

import Alamofire
import AlamofireImage
import AlamofireObjectMapper
import CryptoSwift
import ObjectMapper
import Reachability
import ReactiveCocoa
import ReactiveSwift
import Realm
import RxAlamofire
import RxCocoa
import RxSwift
import SnapKit
import Spring
import SQLite
import SwifterSwift
import SwiftHEXColors
import SwiftyJSON
import Toast_Swift
import UIKit

func safeAreaTop() -> CGFloat {
    if #available(iOS 11.0, *) {
        // iOS 12.0以后的非刘海手机top为 20.0
        if (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom == 0 {
            return 20.0
        }
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.top ?? 20.0
    }
    return 20.0
}

func safeAreaBottom() -> CGFloat {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? 0
    }
    return 0
}

func hasSafeArea() -> Bool {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? CGFloat(0) > CGFloat(0)
    } else { return false }
}

func toolBarHeight() -> CGFloat {
    return 49 + safeAreaBottom()
}

func navigationHeight() -> CGFloat {
    return 44 + safeAreaTop()
}
