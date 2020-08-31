//
//  TodayViewController.swift
//  TodayExtention
//
//  Created by eport2 on 2020/8/28.
//  Copyright © 2020 eport. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit
import RxSwift
import RxCocoa

class TodayViewController: UIViewController, NCWidgetProviding {
    
    private let dispose = DisposeBag()
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblText1: UILabel!
    private var msg = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        

        
//        view.addSubview(btnVolumeAdd)
//        btnVolumeAdd.snp_makeConstraints { (make) in
//            make.left.top.equalToSuperview()
//            make.width.equalTo(100)
//            make.height.equalTo(30)
//        }
//        view.addSubview(btnVolumeDec)
//        btnVolumeDec.snp_makeConstraints { (make) in
//            make.centerY.equalTo(btnVolumeAdd)
//            make.width.height.equalTo(btnVolumeAdd)
//            make.left.equalTo(btnVolumeAdd.snp_right).offset(10)
//        }
        
//        btnVolumeAdd.rx.tap.subscribe({ _ in
//            print("add tap")
//            }).disposed(by: dispose)
//
//        btnVolumeDec.rx.tap.subscribe({ _ in
//            print("dec tap")
//            }).disposed(by: dispose)
        
//        btnAdd.addTarget(self, action: #selector(volumeAddEvent(sender:)), for: .touchUpInside)
        
        
        view.isUserInteractionEnabled = true
        
        
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "kTodayExtensionMsg1")).subscribe(onNext: { (noti) in
            
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: dispose)
        
    }
    
    @IBAction @objc func volumeAddEvent(sender: Any){
        
    }
    
    @IBAction func btnAddEvent(_ sender: Any) {
        print("btnAddEvent")
    }
    lazy var btnVolumeAdd: UIButton = {
       let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    lazy var btnVolumeDec: UIButton = {
       let btn = UIButton()
        btn.setTitle("-", for: .normal)
        return btn
    }()
    
    lazy var text: UITextView = {
       let text = UITextView()
        text.text = "测试"
        return text
    }()
    
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        print("result = \(NCUpdateResult.newData)")
        
        DispatchQueue.global().async {
            let todayExtension = UserDefaults(suiteName: "group.swiftpro")
            let str = todayExtension?.object(forKey: "msg") as? String
            DispatchQueue.main.async {
                if let s = str {
                    self.lblText1.text = s
                }
            }
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
