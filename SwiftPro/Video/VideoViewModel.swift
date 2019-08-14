//
//  VideoViewModel.swift
//  SwiftPro
//
//  Created by eport on 2019/7/12.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit
import AVKit

class VideoViewModel: NSObject {
    
    fileprivate var videoModel: VideoModel?
    
    /// VC
    weak public var vc: VideoViewController? {
        didSet{
            initModel();
            
            initPlayer();
        }
    }
    
    // MARK: - 初始化模型
    fileprivate func initModel(){
        videoModel = VideoModel.getModel(["urlPath":"http://192.168.0.88:80/hgmeap-pluginserver-sp0619/flv.flv"])
    }
    
    // MARK: - 初始化播放器
    fileprivate func initPlayer(){
        
        vc?.player = AVPlayer(url: videoModel?.url ?? URL(fileURLWithPath: "www/index.html", isDirectory: false));
        vc?.player?.play();
        
    }

}
