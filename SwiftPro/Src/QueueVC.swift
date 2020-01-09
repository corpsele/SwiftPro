//
//  QueueVC.swift
//  SwiftPro
//
//  Created by eport2 on 2020/1/7.
//  Copyright © 2020 eport. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import RxCocoa
import RxSwift
import RxSwiftExt
import Toast_Swift
import Alamofire
import RxAlamofire
import SwiftyJSON

class QueueVC: UIViewController {
    @IBOutlet weak var btnDQ: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnDQCurrent: UIButton!
    @IBOutlet weak var btnGlobal: UIButton!
    @IBOutlet weak var btnMain: UIButton!
    @IBOutlet weak var btnOpration: UIButton!
    
    //串行
    let queueDQ = DispatchQueue(label: "label")
    //并行
    let queueDQCurrent = DispatchQueue(label: "label", attributes: .concurrent)
    //全局
    let queueGlobal = DispatchQueue.global()
    //主线程
    let queueMain = DispatchQueue.main
    let disposeBag = DisposeBag()
    
    let sessionManager = Alamofire.SessionManager.default
    let operationMain = OperationQueue.main
    let queueGroup = DispatchGroup()
    let sema = DispatchSemaphore(value: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMain.maxConcurrentOperationCount = 1

        // Do any additional setup after loading the view.
        btnDQ.rx.tap.subscribe {[weak self] (event) in
            guard let strongSelf = self else { return }
            strongSelf.btnDQ.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                strongSelf.btnDQ.isEnabled = true
            }
//            strongSelf.sessionManager.session.getTasksWithCompletionHandler { (dataTask, uploadTask, downloadTask) in
//                dataTask.forEach { (task) in
//                    task.cancel()
//                }
//            }
            print("serial sync thread", Thread.current)
            strongSelf.actionSheet("Sync", "Async") { (index) -> (Void) in
                switch index {
                case 0:
                    strongSelf.queueDQ.sync {
                        strongSelf.requestSomeApi()
                    }
                    break
                case 1:
                    strongSelf.queueDQ.async(group: strongSelf.queueGroup){
                        strongSelf.queueGroup.enter()
                        requestJSON(.post, URL.init(string: "http://localhost:8050/SpringTest/user/api_json.action") ?? URL.init(fileURLWithPath: ""), parameters: ["username":"corpse","password":"corpse"], encoding: URLEncoding.httpBody, headers: [:]).subscribe(onNext: {[weak self] (response, json) in
                            guard let strongSelf = self else {return}
                            let data = JSON(json)
                            strongSelf.view.makeToast("result = \(data.dictionary!)")
                            strongSelf.sema.signal()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
                                strongSelf.queueGroup.leave()
                            })
                            
                            
                            }, onError: {[weak self] (err) in
                                guard let strongSelf = self else{return}
                                strongSelf.view.makeToast("err \(err.localizedDescription)")
                                strongSelf.sema.signal()
                        }, onCompleted: {
                            strongSelf.sema.signal()
                        }) {
                            
                        }.disposed(by: strongSelf.disposeBag)
                        strongSelf.sema.wait()
                    }
                    strongSelf.queueGroup.notify(queue: strongSelf.queueDQ, execute: {[weak self] in
                        guard let strongSelf = self else {return}
                        DispatchQueue.main.async {
                                        strongSelf.view.makeToast("group notify")
                        }
                    })
                    break
                default:
                    break
                }
            }.show()
            strongSelf.view.makeToast(event.debugDescription)
        }.disposed(by: disposeBag)
        

        
        btnDQCurrent.rx.tap.subscribe {[weak self] (event) in
            guard let strongSelf = self else {return}
            print("serial sync thread", Thread.current)
            strongSelf.actionSheet("Sync", "Async") { (index) -> (Void) in
                switch index {
                case 0:
                    strongSelf.queueDQ.sync {
                        strongSelf.requestSomeApi()
                    }
                    break
                case 1:
                    strongSelf.queueDQ.async(group: strongSelf.queueGroup){
                        
                        requestJSON(.post, URL.init(string: "http://localhost:8050/SpringTest/user/api_json.action") ?? URL.init(fileURLWithPath: ""), parameters: ["username":"corpse","password":"corpse"], encoding: URLEncoding.httpBody, headers: [:]).subscribe(onNext: {[weak self] (response, json) in
                            guard let strongSelf = self else {return}
                            let data = JSON(json)
                            strongSelf.view.makeToast("result = \(data.dictionary!)")
                            strongSelf.sema.signal()
                            }, onError: {[weak self] (err) in
                                guard let strongSelf = self else{return}
                                strongSelf.view.makeToast("err \(err.localizedDescription)")
                                strongSelf.sema.signal()
                        }, onCompleted: {
                            strongSelf.sema.signal()
                        }) {
                            
                        }.disposed(by: strongSelf.disposeBag)
                        strongSelf.sema.wait()
                    }
                    break
                default:
                    break
                }
            }.show()
            strongSelf.view.makeToast(event.debugDescription)

        }.disposed(by: disposeBag)
        
        btnOpration.rx.tap.subscribe {[weak self] (event) in
            guard let strongSelf = self else{return}
            strongSelf.operationMain.addOperation {
                let _ = strongSelf.requestSomeApiWithoutRX()
            }
        }.disposed(by: disposeBag)
        
    }
    
    fileprivate func actionSheet(_ action1: String, _ action2: String, success: @escaping (Int) -> (Void)) -> UIAlertController
    {
        let sheet: UIAlertController = UIAlertController.init(title: "Choose Mode", message: "", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction.init(title: action1, style: .default, handler: {(action) in
//            guard let strongSelf = self else {return}
            success(0)
        }))
        sheet.addAction(UIAlertAction.init(title: action2, style: .default, handler: { (action) in
            success(1)
        }))
        sheet.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        return sheet
    }
    
    fileprivate func requestSomeApi() -> Void
    {
        let dic: [String: Any] = ["username": "corpse", "password": "corpse"]
        let header: [String: String] = ["": ""]
        requestJSON(.get, URL.init(string: "http://localhost:8050/SpringTest/user/getall.form") ?? URL.init(fileURLWithPath: ""), parameters: [:], encoding: URLEncoding.httpBody, headers: header).subscribe(onNext: {[weak self] (response, json) in
            guard let strongSelf = self else {return}
            let data = JSON(json)
            strongSelf.view.makeToast("result = \(data["result"])")
            }, onError: {[weak self] (err) in
                guard let strongSelf = self else{return}
                strongSelf.view.makeToast("err \(err.localizedDescription)")
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func requestSomeApiWithoutRX() -> Request
    {
//        let dic: [String: Any] = ["username": "corpse", "password": "corpse"]
//        let header: [String: String] = ["": ""]
        let req = Alamofire.request(URL.init(string: "http://localhost:8050/SpringTest/user/getall.form") ?? URL.init(fileURLWithPath: ""), method: .get, parameters: [:], encoding: URLEncoding.httpBody, headers: [:])
        req.responseJSON {[weak self] (response) in
            guard let strongSelf = self else {return}
            strongSelf.view.makeToast("response \(response.data!)")
        }
        return req
//        requestJSON(.get, URL.init(string: "http://localhost:8050/SpringTest/user/getall.form") ?? URL.init(fileURLWithPath: ""), parameters: [:], encoding: URLEncoding.httpBody, headers: header).subscribe(onNext: {[weak self] (response, json) in
//            guard let strongSelf = self else {return}
//            let data = JSON(json)
//            strongSelf.view.makeToast("result = \(data["result"])")
//            }, onError: {[weak self] (err) in
//                guard let strongSelf = self else{return}
//                strongSelf.view.makeToast("err \(err.localizedDescription)")
//        }, onCompleted: {
//
//        }) {
//
//        }.disposed(by: disposeBag)
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
