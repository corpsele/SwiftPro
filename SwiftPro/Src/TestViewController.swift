//
//  TestViewController.swift
//  SwiftPro
//
//  Created by eport2 on 2019/11/19.
//  Copyright © 2019 eport. All rights reserved.
//


class TestViewController: UIViewController {

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
    }
    
}
