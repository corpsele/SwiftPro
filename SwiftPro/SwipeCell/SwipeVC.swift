//
//  SwipeVC.swift
//  SwiftPro
//
//  Created by eport on 2019/8/12.
//  Copyright © 2019 eport. All rights reserved.
//

import MGSwipeTableCell
import UIKit

class SwipeVC: BaseWithNaviVC, UITableViewDelegate, UITableViewDataSource {
    enum MGSwipeTableCellType {
        case kMGSwipeCellNormal(title: String, cell: MGSwipeTableCell, index: Int)
    }

    let kMGSwipeCellIdentify: String = "MGSwipeCell"

//    var arrayCell: [MGSwipeTableCellType] = [MGSwipeTableCellType](repeating: .kMGSwipeCellNormal(title: ""), count: 10)
    var arrayCell: [MGSwipeTableCellType] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }

        tableView.register(MGSwipeTableCell.self, forCellReuseIdentifier: kMGSwipeCellIdentify)

        addCells()
    }

    func addCells() {
        let cell = MGSwipeTableCell(style: .default, reuseIdentifier: kMGSwipeCellIdentify)
        cell.textLabel?.text = "mg1"
        let leftSetting = MGSwipeSettings()
        leftSetting.transition = .rotate3D
        leftSetting.enableSwipeBounces = true
        cell.leftSwipeSettings = leftSetting
        let btnLeft1 = MGSwipeButton(title: "Read", backgroundColor: .red)
        cell.leftButtons = [btnLeft1]

        arrayCell.append(.kMGSwipeCellNormal(title: "mg1", cell: cell, index: 0))

        let cell1 = MGSwipeTableCell(style: .default, reuseIdentifier: kMGSwipeCellIdentify)
        cell1.textLabel?.text = "mg2"
        let rightSetting = MGSwipeSettings()
        rightSetting.transition = .clipCenter
        rightSetting.enableSwipeBounces = true
        cell1.rightSwipeSettings = rightSetting
        let rightExSetting = MGSwipeExpansionSettings()
        rightExSetting.expansionLayout = .center
        cell1.rightExpansion = rightExSetting
        let btnRight1 = MGSwipeButton(title: "Trash", backgroundColor: .blue)
        cell1.rightButtons = [btnRight1]

        arrayCell.append(.kMGSwipeCellNormal(title: "mg2", cell: cell1, index: 1))
    }

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return arrayCell.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch arrayCell[indexPath.row] {
        case let .kMGSwipeCellNormal(_, cell, _):
            return cell
//        default:
//            print("no cell")
        }
//        return UITableViewCell()
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
