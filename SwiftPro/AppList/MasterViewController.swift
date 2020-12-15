//
//  MasterViewController.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2017 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    var appListDataSource: AppListDataSource = AppListDataSource()
    let evenColor = UIColor(white: 0.9, alpha: 1.0)
    var searchController = UISearchController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.current.userInterfaceIdiom == .pad {
            clearsSelectionOnViewWillAppear = false
            preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = appListDataSource
        
        configureSearchController()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            let navigationController = controllers[controllers.count-1] as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }
        
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            // Fallback on earlier versions
//            automaticallyAdjustsScrollViewInsets = false
//            tableView.contentInset = .zero
//            if #available(iOS 13.0, *) {
//                tableView.automaticallyAdjustsScrollIndicatorInsets = false
//            } else {
//                // Fallback on earlier versions
//            }
//            tableView.scrollIndicatorInsets = .zero
//        }

        
    }
    
    // MARK: - SearchController
    
    func configureSearchController() {
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            
            controller.searchBar.scopeButtonTitles = ["All", "System", "User"]
            controller.searchBar.showsBookmarkButton = true
            controller.searchBar.delegate = appListDataSource
            
            controller.searchResultsUpdater = appListDataSource
            controller.delegate = appListDataSource
            appListDataSource.tableView = tableView
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
            tableView.tableHeaderView = controller.searchBar
            definesPresentationContext = true
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            } else {
                // Fallback on earlier versions
            }
            
            tableView.contentInset = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 24.0), left: 0.0, bottom: 0.0, right: 0.0)
            tableView.scrollIndicatorInsets = tableView.contentInset
            controller.definesPresentationContext = true
            controller.searchBar.frame = CGRect(x: 0.0, y: 44.0 + 24.0, width: UIScreen.main.bounds.width, height: 44.0)
            
            return controller
        })()
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isEven = ((indexPath as NSIndexPath).row%2 == 0)
        
        if isEven {
            cell.backgroundColor = evenColor
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = appListDataSource[(indexPath as NSIndexPath).row] as! AppInfo
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.appListDataSource = appListDataSource
                controller.title = object["localizedName"] as! String?
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

