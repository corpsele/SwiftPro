//
//  SortVC.swift
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ReactiveCocoa
import RxDataSources

class SortVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        vm.model = Observable<[SectionModel<String, String>]>.create {[weak self] (observer) -> Disposable in
            guard let strongSelf = self else {return Disposables.create()}
            observer.onNext([SectionModel<String,String>.init(model: "", items: strongSelf.vm.arrayData)])
            observer.onCompleted()
            return Disposables.create()
        }
        vm.model?.bind(to: (tableView?.rx.items(dataSource: vm.dataSource))!).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: {[weak self] (index) in
            guard let strongSelf = self else {return}
            switch index.row {
            case 0:
                HGLog("insertSort = \(SortTest.insertSorting(arr: strongSelf.vm.array))")
                break
            default:
                break
            }
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: disposeBag)
        
    }
    
    lazy var vm: SortVM = {
       let vm = SortVM()
        return vm
    }()
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
