//
//  MainNaviViewController.swift
//  SwiftPro
//
//  Created by eport on 2019/7/19.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit

class MainNaviViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        _ = NotificationCenter.default.rx.notification(NSNotification.Name.UIDeviceOrientationDidChange, object: self).subscribe(onNext: { _ in
            let orientation = UIDevice.current.orientation
            if orientation != UIDeviceOrientation.portrait {
//                UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
            }
        }, onError: { err in
            print(err)
        })
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
