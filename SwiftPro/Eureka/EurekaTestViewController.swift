//
//  EurekaTestViewController.swift
//  SwiftPro
//
//  Created by eport on 2019/7/26.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit
import Eureka

class EurekaTestViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        CheckRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = .blue;
        };
        
        form +++ Section("section 1")
            <<< CheckRow() {
                $0.title = "checkcell 1";
                $0.value = false;
        }
                .onCellSelection({ (cell, row) in
                    cell.backgroundColor = .gray;
                    row.reload();
                })
        +++ Section("section 2")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false;
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
