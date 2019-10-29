//
//  CalendarVC.swift
//  SwiftPro
//
//  Created by eport on 2019/8/5.
//  Copyright © 2019 eport. All rights reserved.
//

import FSCalendar
import Motion
import UIKit
import ViewAnimator

class CalendarVC: BaseWithNaviVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.addSubview(cal)

        cal.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(100.0)
            make.right.equalToSuperview()
            make.bottom.equalTo(-100.0)
        }
    }

    let cal: FSCalendar = {
        let cal = FSCalendar()
        cal.locale = Locale(identifier: "zh-CN")
        let formatter = DateFormatter(withFormat: "yyyy年MM月dd日", locale: "zh-CN")
        cal.appearance.headerDateFormat = "yyyy年MM月dd日"
        cal.calendarHeaderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        cal.calendarWeekdayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        cal.appearance.eventSelectionColor = UIColor.white
        cal.appearance.eventOffset = CGPoint(x: 0, y: -7)
        cal.configureAppearance()
        return cal
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let animation = AnimationType.from(direction: .top, offset: 30.0)
        let a2 = AnimationType.random()
        view.animate(animations: [animation, a2], duration: 2)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        let animation = AnimationType.from(direction: .top, offset: 30.0);
//        let a2 = AnimationType.random();
//        view.animate(animations: [animation, a2]);
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
