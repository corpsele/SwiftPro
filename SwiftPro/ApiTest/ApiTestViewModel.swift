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
import RxDataSources
import Toast_Swift
import NVActivityIndicatorView

class ApiTestViewModel: NSObject {
    var viewAppearSignal: SignalProducer<Void, Never>! {
        didSet{
            viewAppearSignal.startWithValues { (Void) in
                print("SignalProducer<Void, Never>")
            }
        }
    }
    private var apiModel: Observable<[SectionModel<String, City>]>?
    private var tableView: UITableView?
    private var view: UIView?
    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, City>>(configureCell: { (_, table, index, model) in
        let cell = table.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = model.cityname
        cell?.detailTextLabel?.text = "\(model.stateDetailed!) | \(model.windState!)"
        return cell!
    })
    
    var isBinded: Bool = false
    
    var viewSignal: SignalProducer<UIView, Never>?{
        didSet{
            self.viewSignal?.producer.startWithValues({[weak self] (v) in
                self?.view = v
            })
        }
    }
    
    let clickCommand = PublishSubject<Int>()
    var count: Int = 0
    
    var tableViewProperty: Property<UITableView>?{
        didSet{
            tableViewProperty?.producer.startWithValues({[weak self] (table) in
                print("tableView = \(table)")
                self?.tableView = table
            })

        }
    }
    var btnSearchDriver: ControlEvent<Void>?{
        didSet{
            btnSearchDriver?.subscribe(onNext: {[weak self] () in
                self?.count = (self?.count)! + 1
                self?.clickCommand.onNext((self?.count)!)
//                 NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
                self?.requestApi()
                IQKeyboardManager.shared().resignFirstResponder()
                })
        }
    }
    
    var searchText: ControlProperty<String?>?{
        didSet{
//            let disposeBag = DisposeBag()
            self.searchText?.subscribe(onNext: {[weak self] (str) in
                print("str = \(str!)")
                
                })
            
            
        }
    }
    
    private func requestApi(){
        
        apiModel = ApiTestModel.requestApi()
        apiModel?.subscribe(onNext: {[weak self] (model) in
            print("model = \(model)")
//            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            self?.bindData()
            }).disposed(by: disposeBag)
        if !isBinded {
            apiModel?.bind(to: (tableView?.rx.items(dataSource: dataSource))!).disposed(by: disposeBag)
            isBinded = true
        }
        

    }
    
    private func bindData()
    {
        
        
        tableView?.rx.itemSelected.map({ (index) in
            return (index,self.dataSource[index])
        }).subscribe(onNext: {[weak self] (index, city) in
            self?.view?.makeToast(city.cityname)
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
        })
//        dataSource.configureCell = { (_, tableView, indexPath, model) in
////            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//            //处理返回数据
//
//            return cell!
//        }
    }


}
