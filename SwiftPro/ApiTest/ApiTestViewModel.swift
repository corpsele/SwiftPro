//
//  ApiTestViewModel.swift
//  SwiftPro
//
//  Created by eport2 on 2019/12/24.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import RxCocoa
import RxSwift
import SwiftyJSON
import RxAlamofire
import Alamofire

class ApiTestViewModel: NSObject {
    var apiModel: Observable<ApiTestModel>?
    var btnSearchDriver: ControlEvent<Void>?{
        didSet{
            let disposeBag = DisposeBag()
            btnSearchDriver?.subscribe(onNext: {[weak self] () in
                self?.requestApi()
            }, onError: { (err) in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
                }).disposed(by: disposeBag)
        }
    }
    
    var searchText: ControlProperty<String?>?{
        didSet{
            let disposeBag = DisposeBag()
            self.searchText?.subscribe(onNext: {[weak self] (str) in
                print("str = \(str!)")
                
            }, onError: { (err) in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
                }).disposed(by: disposeBag)
            
            
        }
    }
    
    private func requestApi(){
        let disposeBag = DisposeBag()
        apiModel = ApiTestModel.requestApi()
        apiModel?.subscribe(onNext: {[weak self] (model) in
            print("model = \(model)")
            self?.bindData()
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
            }).disposed(by: disposeBag)
    }
    
    private func bindData()
    {
//        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Any>>()
//        let dataArray = Variable([SectionModel<String, Any>]())
    }
    
    override init() {
        super.init()
        

    }

}
