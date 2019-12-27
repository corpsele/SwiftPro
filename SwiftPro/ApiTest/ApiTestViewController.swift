//
//  ApiTestViewController.swift
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

class ApiTestViewController: UIViewController {
    var vm: ApiTestViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ApiTest"
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        

        // Do any additional setup after loading the view.
        initViews()
        initVM()
    }
    
    private func initVM()
    {
        vm = ApiTestViewModel()
        
        vm.btnSearchDriver = btnSearch.rx.tap.asControlEvent()
        vm.searchText = searchView.rx.text
        vm.tableViewProperty = Property<UITableView>.init(initial: tableView, then: SignalProducer{[weak self] (observer, lifttime) in
            observer.send(value: (self?.tableView)!)
            observer.sendCompleted()
        })
        vm.viewSignal = SignalProducer<UIView, Never> {[weak self] observer,lifetime  in
            observer.send(value: (self?.view)!)
            observer.sendCompleted()
        }
        vm.clickCommand.subscribe(onNext: {[weak self] (i) in
            self?.btnSearch.setTitle("搜索(\(i))", for: .normal)
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }
        
        
    }
    
    private func initViews()
    {
        view.addSubview(searchView)
        searchView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(navigationHeight())
            make.right.equalToSuperview().offset(-100.0)
            make.height.equalTo(80.0)
        })
        
        view.addSubview(btnSearch)
        btnSearch.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(navigationHeight())
            make.width.equalTo(80.0)
            make.height.equalTo(80.0)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kkTopHeight)
            make.top.equalTo(searchView.snp.bottom)
        }
    }
    
    private lazy var searchView: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor.black
        view.textColor = UIColor.white
        return view
    }()
    
    private lazy var btnSearch: UIButton = {
       let btn = UIButton()
        btn.setTitle("搜索", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
       let view = UITableView()
        view.contentInset = .zero
        view.contentInsetAdjustmentBehavior = .never
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
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
