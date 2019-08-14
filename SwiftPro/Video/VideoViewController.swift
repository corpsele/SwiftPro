//
//  VideoViewController.swift
//  SwiftPro
//
//  Created by eport on 2019/7/12.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: AVPlayerViewController {
    var videoVM: VideoViewModel = VideoViewModel();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        videoVM.vc = self;
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
