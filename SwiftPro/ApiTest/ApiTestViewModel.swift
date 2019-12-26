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

class ApiTestViewModel: NSObject {
    private var apiModel: Observable<[SectionModel<String, City>]>?
    private var tableView: UITableView?
    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, City>>(configureCell: { (_, table, index, model) in
        let cell = table.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = model.cityname
        return cell!
    })
    
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
                self?.requestApi()
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
            self?.bindData()
            })

    }
    
    private func bindData()
    {
        
        apiModel?.bind(to: (tableView?.rx.items(dataSource: dataSource))!)
        print("row total = \((tableView?.numberOfRows())!)")
//        dataSource.configureCell = { (_, tableView, indexPath, model) in
////            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//            //处理返回数据
//
//            return cell!
//        }
    }
    
    override init() {
        super.init()
        

    }

}
