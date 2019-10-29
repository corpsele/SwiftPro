//
//  BaseVC.swift
//  SwiftPro
//
//  Created by eport on 2019/8/5.
//  Copyright © 2019 eport. All rights reserved.
//

let kkStatusBarHeight = UIApplication.shared.statusBarFrame.height

let kkTopHeight = kkStatusBarHeight + 20

let kkTopNaviHeight = kkTopHeight + 64

import UIKit

class BaseWithNaviVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = false
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
