//
//  SliderMenuTestVC.swift
//  SwiftPro
//
//  Created by eport on 2019/8/6.
//  Copyright © 2019 eport. All rights reserved.
//

import SideMenu
import UIKit

class SliderMenuTestVC: BaseWithNaviVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        SideMenuManager.default.leftMenuNavigationController = leftSideVC

        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)

        view.addSubview(btnShowLeft)

        btnShowLeft.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150.0)
            make.height.equalTo(50.0)
        }
    }

    lazy var leftSideVC: LeftSideVC = {
        let vc = LeftSideVC()
        return vc
    }()

    lazy var btnShowLeft: UIButton = {
        let btn = UIButton()
        btn.setTitle("显示左侧menu", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(btnShowLeftEvent), for: .touchUpInside)
        return btn
    }()

    @objc func btnShowLeftEvent(sender _: UIButton) {
        present(leftSideVC, animated: true) {}
    }

//    override func navigationController(_: UINavigationController, willShow _: UIViewController, animated _: Bool) {}

    override func cyl_pushOrPop(to viewController: UIViewController, animated: Bool, callback: @escaping CYLPushOrPopCallback) {
        super.cyl_pushOrPop(to: viewController, animated: animated, callback: callback)
    }

    override func navigationShouldPopMethod() -> Bool {
//        rx.observe(String.self, NSStringFromClass(self.superclass!))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "popVC"), object: superclass, userInfo: nil)
        return true
    }
}
