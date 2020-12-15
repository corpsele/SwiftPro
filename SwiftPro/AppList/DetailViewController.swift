//
//  DetailViewController.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2017 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var tableview: UITableView!
  var appinfoDataSource: AppInfoDataSource?
  var appListDataSource: AppListDataSource?
  
  var detailItem: AppInfo? {
    didSet {
      appinfoDataSource = AppInfoDataSource(appProxy: detailItem!)
      configureView()
    }
  }
  
  func configureView() {
    if let dataSource: AppInfoDataSource = appinfoDataSource {
      tableview?.dataSource = dataSource
    }
    
    if #available(iOS 11.0, *) {
        tableview.contentInsetAdjustmentBehavior = .never
    } else {
        // Fallback on earlier versions
        automaticallyAdjustsScrollViewInsets = false
        tableview.contentInset = .zero
        if #available(iOS 13.0, *) {
            tableview.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        tableview.scrollIndicatorInsets = .zero
    }
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  @IBAction func openApp() {
    if let appListDataSource = appListDataSource {
      appListDataSource.openApp(appinfoDataSource?.getBundleID())
    }
  }
  
}

