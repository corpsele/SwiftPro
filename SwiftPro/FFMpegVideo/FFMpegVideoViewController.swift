//
//  FFMpegVideoViewController.swift
//  SwiftPro
//
//  Created by eport on 2019/7/16.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit
import Alamofire

class FFMpegVideoViewController: UIViewController {
    
    fileprivate lazy var viewVideo: UIView? = {
        let view = UIView();
        view.backgroundColor = UIColor.black;
        return view;
    }()
    
    fileprivate lazy var session: URLSession? = {
        let configuration = URLSessionConfiguration();
        configuration.timeoutIntervalForRequest = 120;
        let session = URLSession(configuration: configuration);
        return session;
        
    }()
    
    fileprivate lazy var request: URLRequest? = {
       let request = URLRequest(urlString: "http://192.168.0.88:80/hgmeap-pluginserver-sp0619/flv.flv")
        return request
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = false;
        
        view.addSubview(viewVideo ?? UIView());
        
        viewVideo?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalToSuperview();
        })
        
        downloadFile();
    }
    
    
    func downloadFile(){
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        Alamofire.download("http://192.168.0.88:80/hgmeap-pluginserver-sp0619/flv.flv", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, to: destination).response { [weak self] (response) in
            print("response \(response)")
            
            let tmp = response.destinationURL?.absoluteString.replacingOccurrences(of: "file://", with: "");
            

        }
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
