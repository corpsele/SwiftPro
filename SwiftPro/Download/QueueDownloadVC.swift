//
//  QueueDownloadVC.swift
//  SwiftPro
//
//  Created by eport on 2019/8/2.
//  Copyright © 2019 eport. All rights reserved.
//

import Alamofire
import MMKV
import UIKit

class QueueDownloadVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = false

        view.addSubview(downLoadView)
        view.addSubview(downLoadView2)

        downLoadView.snp.makeConstraints { make in
            make.left.equalTo(30.0)
            make.width.equalTo(0.0)
            make.top.equalTo(30.0)
            make.height.equalTo(30.0)
        }

        downLoadView2.snp.makeConstraints { make in
            make.left.equalTo(30.0)
            make.width.equalTo(0.0)
            make.top.equalTo(downLoadView.snp.bottom).offset(30.0)
            make.height.equalTo(30.0)
        }

        view.addSubview(btnStart1)
        view.addSubview(btnPause1)
        view.addSubview(btnStop1)

        view.addSubview(btnStart2)
        view.addSubview(btnPause2)
        view.addSubview(btnStop2)
        
        btnStop2.shake(direction: UIView.ShakeDirection.horizontal, duration: TimeInterval.init(1), animationType: UIView.ShakeAnimationType.easeInOut) {
            
        };
        
        btnStop1.shake()

        btnStart1.snp.makeConstraints { make in
            make.left.equalTo(20.0)
            make.top.equalTo(downLoadView2.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(30.0)
        }

        btnPause1.snp.makeConstraints { make in
            make.left.equalTo(btnStart1.snp.right).offset(10.0)
            make.top.equalTo(downLoadView2.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(30.0)
        }

        btnStop1.snp.makeConstraints { make in
            make.left.equalTo(btnPause1.snp.right).offset(10.0)
            make.top.equalTo(downLoadView2.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(30.0)
        }

        btnStart2.snp.makeConstraints { make in
            make.left.equalTo(20.0)
            make.top.equalTo(btnStart1.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(30.0)
        }

        btnPause2.snp.makeConstraints { make in
            make.left.equalTo(btnStart1.snp.right).offset(10.0)
            make.top.equalTo(btnPause1.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(30.0)
        }

        btnStop2.snp.makeConstraints { make in
            make.left.equalTo(btnPause1.snp.right).offset(10.0)
            make.top.equalTo(btnStop1.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(30.0)
        }

        downloadQueue(url: "https://www.sample-videos.com/video123/mkv/720/big_buck_bunny_720p_1mb.mkv", 1)
        downloadQueue(url: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4", 2)
    }

    func downloadQueue(url: String, _ index: Int = 1) {
        let semaphore = DispatchSemaphore(value: 0)
        semaphoreArray.append(semaphore)

        let op: BlockOperation = BlockOperation { [weak self] in
            let destination = DownloadRequest.suggestedDownloadDestination()
            let request = Alamofire.download(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil, to: destination).downloadProgress { [weak self] pro in

                let percent = Float(pro.completedUnitCount) / Float(pro.totalUnitCount)

                if index == 1 {
                    self?.downLoadView.snp.remakeConstraints { make in
                        make.width.equalTo(300 * percent)
                        make.height.equalTo(30)
                        make.top.equalTo(130.0)
                        make.left.equalToSuperview().offset(30)
                    }
                } else if index == 2 {
                    self?.downLoadView2.snp.remakeConstraints { make in
                        make.width.equalTo(300 * percent)
                        make.height.equalTo(30)
                        make.top.equalTo((self?.downLoadView.snp.bottom)!).offset(30)
                        make.left.equalToSuperview().offset(30)
                    }
                }

            }.responseData { response in

                switch response.result {
                case .success:
                    print("success")
                case let .failure(err):
                    self?.tmpData = response.resumeData ?? Data()
//                        UserDefaults.standard.set(response.resumeData ?? Data(), forKey: "\(index)");
//                        UserDefaults.standard.synchronize();
                    MMKV.default()?.set(response.resumeData ?? Data(), forKey: "\(index)")
//                        MMKV.default().sync();
                    print("下载错误 err = \(err.localizedDescription)")

                default:
                    print("failed")
                }
                semaphore.signal()
                self?.downloadCount -= 1
            }
            // 单线程下载
//            semaphore.wait();
            self?.requests.append(request)
        }

        queue.addOperation(op)
    }

    func downloadQueueData(data: Data, _ index: Int = 1) {
        let op: BlockOperation = BlockOperation { [weak self] in
            let destination = DownloadRequest.suggestedDownloadDestination()
            let request = Alamofire.download(resumingWith: data, to: destination)

//            request.downloadProgress(closure: downloadProgress)
            request.downloadProgress(closure: { pro in
                let percent = Float(pro.completedUnitCount) / Float(pro.totalUnitCount)

                if index == 1 {
                    self?.downLoadView.snp.remakeConstraints { make in
                        make.width.equalTo(300 * percent)
                        make.height.equalTo(30)
                        make.top.equalTo(130.0)
                        make.left.equalToSuperview().offset(30)
                    }
                } else if index == 2 {
                    self?.downLoadView2.snp.remakeConstraints { make in
                        make.width.equalTo(300 * percent)
                        make.height.equalTo(30)
                        make.top.equalTo((self?.downLoadView.snp.bottom)!).offset(30)
                        make.left.equalToSuperview().offset(30)
                    }
                }
            })
//            request.responseData(completionHandler: downloadResponse)

            request.responseData(completionHandler: { response in
                switch response.result {
                case .success:
                    print("success")
                case .failure:
                    self?.tmpData = response.resumeData ?? Data()
//                    UserDefaults.standard.set(response.resumeData ?? Data(), forKey: "\(index)");
//                    UserDefaults.standard.synchronize();

                    MMKV.default()?.set(response.resumeData ?? Data(), forKey: "\(index)")

                default:
                    print("failed")
                }
                self?.downloadCount -= 1

            })
            let i = index - 1 < 0 ? 0 : index - 1
//            let i = index;
            self?.requests[i] = request
        }
        queue.addOperation(op)
    }

    var downloadCount = 2
    var tmpData: Data?
    var semaphoreArray: [DispatchSemaphore] = []
    var requests: [DownloadRequest] = []
    var downloadCancel: [Bool] = [false, false]

    let downLoadView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()

    let downLoadView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()

    let queue: OperationQueue = {
        let que: OperationQueue = OperationQueue()
        que.maxConcurrentOperationCount = 1
        return que
    }()

    let btnStart1: UIButton = {
        let btn = UIButton()
        btn.setTitle("开始线程1", for: .normal)
        btn.addTarget(self, action: #selector(btnStart1Event), for: .touchUpInside)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }()

    let btnPause1: UIButton = {
        let btn = UIButton()
        btn.setTitle("暂停线程1", for: .normal)
        btn.addTarget(self, action: #selector(btnPause1Event), for: .touchUpInside)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }()

    let btnStop1: UIButton = {
        let btn = UIButton()
        btn.setTitle("停止线程1", for: .normal)
        btn.addTarget(self, action: #selector(btnStop1Event), for: .touchUpInside)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }()

    let btnStart2: UIButton = {
        let btn = UIButton()
        btn.setTitle("开始线程2", for: .normal)
        btn.addTarget(self, action: #selector(btnStart2Event), for: .touchUpInside)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }()

    let btnPause2: UIButton = {
        let btn = UIButton()
        btn.setTitle("暂停线程2", for: .normal)
        btn.addTarget(self, action: #selector(btnPause2Event), for: .touchUpInside)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }()

    let btnStop2: UIButton = {
        let btn = UIButton()
        btn.setTitle("停止线程2", for: .normal)
        btn.addTarget(self, action: #selector(btnStop2Event), for: .touchUpInside)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }()

    @objc func btnStart1Event(sender _: UIButton) {
        let request = requests.first
        if downloadCancel[0] == true {
//            let data: Data = UserDefaults.standard.data(forKey: "1") ?? Data();
            let data: Data = MMKV.default()?.data(forKey: "1") ?? Data()
            downloadQueueData(data: data, 1)
            downloadCount += 1
            downloadCancel[0] = false
        } else {
            request?.resume()
        }
    }

    @objc func btnPause1Event(sender _: UIButton) {
        let request = requests.first
        request?.suspend()
    }

    @objc func btnStop1Event(sender _: UIButton) {
        let request = requests.first
        request?.cancel()
        downloadCount -= 1
        downloadCancel[0] = true
    }

    @objc func btnStart2Event(sender _: UIButton) {
        let request = requests.last
        if downloadCancel[1] == true {
//            let data: Data = UserDefaults.standard.data(forKey: "2") ?? Data();
            let data: Data = MMKV.default()?.data(forKey: "2") ?? Data()
            downloadQueueData(data: data, 2)
            downloadCount += 1
            downloadCancel[1] = false
        } else {
            request?.resume()
        }
    }

    @objc func btnPause2Event(sender _: UIButton) {
        let request = requests.last
        request?.suspend()
    }

    @objc func btnStop2Event(sender _: UIButton) {
        let request = requests.last
        request?.cancel()
        downloadCount -= 1
        downloadCancel[1] = true
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
