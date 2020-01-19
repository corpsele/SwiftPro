//
//  SortVM.swift
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ReactiveCocoa
import ReactiveSwift
import RxDataSources

class SortVM: NSObject {
    let array: [Int] = [21,222,1231,22,121,1,0,44,454,33]
    let arrayData: [String] = ["插入排序", "选择排序"]
    
    var tableViewSignal: SignalProducer<Void, Never>? {
        didSet{
            
        }
    }
    
    var model: Observable<[SectionModel<String, String>]>?{
        didSet{
            
        }
    }
    
    var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { (_, table, index, model) in
        let cell = table.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = model
        return cell!
    })
    

}
