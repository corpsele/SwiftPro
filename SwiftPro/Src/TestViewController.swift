//
//  TestViewController.swift
//  SwiftPro
//
//  Created by eport2 on 2019/11/19.
//  Copyright © 2019 eport. All rights reserved.
//
import WebKit
import RxSwift

class TestViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.view.backgroundColor = UIColor.white
        
        let model1 = HGNotifactionMainDataSource();
        model1.imgUrl = "";
        model1.strTitle = "标题1"
        model1.strSubText = "副标题1"
        model1.strDate = "2019/9/28"
        
        let model2 = HGNotifactionMainDataSource();
        model2.imgUrl = "";
        model2.strTitle = "标题2"
        model2.strSubText = "副标题2"
        model2.strDate = "2019/9/20"
        
        let model3 = HGNotifactionMainDataSource();
        model3.imgUrl = "";
        model3.strTitle = "标题3"
        model3.strSubText = "副标题3"
        model3.strDate = "2019/9/24"
        let view1 = HGNotifactionMainView(frame: CGRect.init(x: 10, y: 100, width: UIScreen.main.bounds.size.width-20, height: 60.0), withDuration: 3.0, with: [model1, model2, model3])
//        view1.layer.masksToBounds = true;
//        view1.layer.cornerRadius = 5;
//        view1.layer.borderColor = UIColor.black.cgColor;
//        view1.layer.borderWidth = 0.2;
//        view1.layer.shadowColor = UIColor.black.cgColor;
//        view1.layer.shadowOffset = CGSize.init(width: 2, height: 5);
//        view1.layer.shadowOpacity = 0.5;
//        view1.layer.shadowRadius = 5;
        view1.notifactionBlock = { (page) in
            print("page = \(page)");
        }
        self.view.addSubview(view1)
//        view1.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view).offset(10.0)
//            make.right.equalTo(self.view).offset(-10.0)
//            make.top.equalTo(self.view).offset(100.0)
//            make.height.equalTo(60.0)
////            make.width.equalTo(UIScreen.main.bounds.size.width)
//        }
        addWebView()
    }
    
    lazy var webView: WKWebView = {
       let view = WKWebView()
        return view
    }()
    
    lazy var btnBack: UIButton = {
       let btn = UIButton()
        btn.setTitle("后退", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        return btn
    }()
    
    lazy var btnForward: UIButton = {
       let btn = UIButton()
        btn.setTitle("前进", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        return btn
    }()
    
    fileprivate func addWebView(){
//        URL.init(string: "http://localhost:8050/SpringTest/") ?? URL.init(fileURLWithPath: "")
        webView.load(URLRequest.init(urlString: "http://localhost:8050/SpringTest/") ?? URLRequest.init(url: URL.init(string: "http://localhost:8050/SpringTest/") ?? URL.init(fileURLWithPath: "")))
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(300.0)
        }
        
        self.view.addSubview(btnBack)
        btnBack.snp.makeConstraints { (make) in
            make.bottom.equalTo(webView.snp.top)
            make.left.equalToSuperview()
            make.width.equalTo(100.0)
            make.height.equalTo(50.0)
        }
        self.view.addSubview(btnForward)
        btnForward.snp.makeConstraints { (make) in
            make.bottom.equalTo(webView.snp.top)
            make.right.equalToSuperview()
            make.width.equalTo(100.0)
            make.height.equalTo(50.0)
        }
        
        btnBack.rx.tap.subscribe {[weak self] (event) in
            guard let strongSelf = self else {return}
            strongSelf.webView.goBack()
        }.disposed(by: disposeBag)
        
        btnForward.rx.tap.subscribe {[weak self] (event) in
            guard let strongSelf = self else {return}
            strongSelf.webView.goForward()
        }.disposed(by: disposeBag)
        
        webView.rx.observeWeakly(Bool.self, "canGoBack").subscribe(onNext: {[weak self] (flag) in
            guard let strongSelf = self else {return}
            strongSelf.btnBack.isEnabled = (flag!)
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: disposeBag)
        
        webView.rx.observeWeakly(Bool.self, "canGoForward").subscribe(onNext: {[weak self] (flag) in
            guard let strongSelf = self else {return}
            strongSelf.btnForward.isEnabled = (flag!)
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: disposeBag)
        
    }
    
}
