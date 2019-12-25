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

        
        
    }
    
    private func initViews()
    {
        view.addSubview(searchView)
        searchView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(kkTopHeight)
            make.right.equalToSuperview().offset(-100.0)
            make.height.equalTo(80.0)
        })
        
        view.addSubview(btnSearch)
        btnSearch.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(kkTopHeight)
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
