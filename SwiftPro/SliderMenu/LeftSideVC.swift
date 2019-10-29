//
//  LeftSideVC.swift
//  SwiftPro
//
//  Created by eport on 2019/8/6.
//  Copyright © 2019 eport. All rights reserved.
//

import SideMenu
import UIKit

class LeftSideVC: UISideMenuNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.addSubview(lblTitle)

        lblTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150.0)
            make.height.equalTo(50.0)
        }
    }

    lazy var lblTitle: UILabel = {
        var lbl = UILabel()
        lbl.text = "Test"
        lbl.textColor = UIColor.orange
        return lbl
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = UIColor.white
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
