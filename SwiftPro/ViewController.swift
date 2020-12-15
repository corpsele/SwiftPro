//
//  ViewController.swift
//  SwiftPro
//
//  Created by eport on 2019/7/11.
//  Copyright © 2019 eport. All rights reserved.
//

import Alamofire
// import AuthenticationServices
import CoreServices
//import Eureka
import JJException
import LocalAuthentication
import Material
import pop
//import Realm
// import ToastSwiftFramework
//import RealmSwift
import RxCocoa
import RxSwift
import Sica
import Spring
import SQLite.Swift
import SwiftMessages
import SwipeCellKit
import Toast_Swift
import UIKit
import ZHRefresh

typealias initWithServers = (Any) -> (Any)

struct MainStatusView {
    static var statusView: UIView?
    static var statusWindow: UIWindow?
}

struct CellDic {
    var cellIdentify: String
    var cellType: AnyClass

    init(cellIdentify: String, cellType: AnyClass) {
        self.cellIdentify = cellIdentify
        self.cellType = cellType
    }
}

enum ViewControllerCellType {
    case VCCellTypeDisplay(UITableViewCell)
    case VCCellTypeAuth(TableViewCell)
}

// MARK: - TableViewCell Identify

struct TableViewCellIdentify {
    static let kkTableViewCell: String = "TableViewCell"
    static let kkTableViewCellCheck: String = "TableViewCheckCell"
    static let kkTableViewCellAuth: String = "TableViewCheckCellAuth"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { // , ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding
    var arrayCell: [Any] = [Any](repeating: 0, count: 500)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if UIDevice.current.isGeneratingDeviceOrientationNotifications == false {
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        }

//        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationListener), name: UIDevice.orientationDidChangeNotification, object: self);

        _ = NotificationCenter.default.rx.notification(NSNotification.Name.UIDeviceOrientationDidChange, object: self).subscribe(onNext: { _ in
            let orientation = UIDevice.current.orientation
            if orientation != UIDeviceOrientation.portrait {
                UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
            }
        }, onError: { err in
            print("\(#function) in \(#file) : \(#line) = \(err)")
        })
    }

    fileprivate lazy var vlcPlayerMediaVC: FFMpegVideoViewController? = {
        let vc = FFMpegVideoViewController()
        return vc
    }()

    fileprivate lazy var xMovieVC: KxMovieViewController? = {
        let vc = KxMovieViewController.movieViewController(withContentPath: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", parameters: nil) as? KxMovieViewController
        return vc
    }()

    fileprivate lazy var videoVC: VideoViewController? = {
        let vc = VideoViewController()
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.backgroundColor = UIColor.white

        addViews()
        registerTableViewCell()

        let type = CellDic(cellIdentify: TableViewCellIdentify.kkTableViewCellCheck, cellType: UITableViewCell.self)
        arrayCell[10] = type
        arrayCell[15] = ViewControllerCellType.VCCellTypeDisplay(UITableViewCell())
        tableView.register(type.cellType, forCellReuseIdentifier: type.cellIdentify)

//        let authType = CellDic(cellIdentify: TableViewCellIdentify.kkTableViewCellAuth, cellType: TableViewCell.self);
        arrayCell[20] = ViewControllerCellType.VCCellTypeAuth(TableViewCell())

        if #available(iOS 11.0, *) {
            // 作用于指定的UIScrollView
            tableView.contentInsetAdjustmentBehavior = .automatic
            // 作用与所有的UIScrollView
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        edgesForExtendedLayout = []

        tableView.header = ZHRefreshNormalHeader.headerWithRefreshing(block: { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.header?.endRefreshing()
        })

        xMovieVC?.orientationBlock = {
            let orientation = UIDevice.current.orientation
            if orientation != UIDeviceOrientation.portrait {
//                UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
            }
        }

//        view.subviews[999];
//        /System/Library/PrivateFrameworks/WiFiKit.framework
        let lib = dlopen("/Users/eport2/Documents/Apple-Runtime-Headers/iOS_S/System/Library/PrivateFrameworks/NetworkExtension.framework/NetworkExtension", RTLD_LAZY)
        if lib != nil {
            println("framework init successed")
            print("\(#file) in \(#function) : \(#line) = framework init successed")
//            initWithServers = dlsym(lib, "initWithServers");
        }

//        printApplicationState();

        if let framework = Bundle(path: "/Users/eport2/Documents/Apple-Runtime-Headers/iOS_S/System/Library/PrivateFrameworks/NetworkExtension.framework") {
            print("bundle framework init successed")
            HGLog("bundle framework init successed")
            do {
                try framework.loadAndReturnError()

                let DnsSettingsClass = NSClassFromString("NEDNSSettings") as? NSObject.Type

//                dns.perform(Selector("initWithServers"), with: "192.168.0.101");

//                let dns = DnsSettingsClass.initWithServers("192.168.0.101");

                print("dns = \(DnsSettingsClass!)")
                let dns = DnsSettingsClass?.init()
//                dns?.perform(#selector(initWithServers), with: "192.168.0.101")
                dns?.perform(Selector(("initWithServers:")), with: "192.168.0.101")
            } catch let err {
                print(err.localizedDescription)
            }
        }
        
        NotificationCenter.default.rx.notification(Notification.Name.init("kTodayExtensionMsg1")).subscribe(onNext: { (noti) in
            
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }
        
//        let LSApplicationWorkspace_class: AnyClass = NSClassFromString("LSApplicationWorkspace") ?? UIViewController.self
        
        let LSApplicationWorkspace_class: LSApplicationWorkspace = LSApplicationWorkspace.defaultWorkspace() as! LSApplicationWorkspace
        
//        self.workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        
        let apps = LSApplicationWorkspace_class.allApplications()
        
//        let apps = workspace.perform(Selector("allApplications")) as AnyObject
        
         
//        todayDefault?.set("I Quit", forKey: "msg")
    }

    @objc func deviceOrientationListener(noti _: Notification) {
        let orientation = UIDevice.current.orientation
        if orientation != UIDeviceOrientation.portrait {
            UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }

    deinit {}

    fileprivate func addStatusBar() {
        let window = UIApplication.shared.windows.last
        windowStatusBar.addSubview(viewStatusBar)
        MainStatusView.statusView = viewStatusBar
        viewStatusBar.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        window?.addSubview(windowStatusBar)
        MainStatusView.statusWindow = windowStatusBar
        windowStatusBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            if UIDevice.isX() == true {
                make.height.equalTo(44.0)
            } else {
                make.height.equalTo(20.0)
            }
        }
        windowStatusBar.makeKeyAndVisible()
        window?.makeKeyAndVisible()
    }

    fileprivate lazy var viewStatusBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    fileprivate lazy var windowStatusBar: UIWindow = {
        let view = UIWindow()
        view.windowLevel = UIWindowLevelStatusBar + 1000
        return view
    }()

    // MARK: - Add Views

    private func addViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.addStatusBar()
        }
    }

    // MARK: - Register TableViewCell

    private func registerTableViewCell() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCellIdentify.kkTableViewCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CheckCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - TableView

    private var tableView: UITableView = {
        let view = UITableView()
        return view
    }()

    // MARK: - TableView Delegate

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return arrayCell.count
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt _: IndexPath) {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentify.kkTableViewCell) as? SwipeTableViewCell {

        CellAnimator.animate(cell, withDuration: 1, animation: .Wave)
//        let animation = POPSpringAnimation.init(propertyNamed: "springpop");
//        animation?.dynamicsFriction = 12.0;
//        animation?.dynamicsMass = 12.0;
//        let animation2 = POPBasicAnimation.init();
//        animation2.duration = 1;
//        animation2.timingFunction = .init(name: CAMediaTimingFunctionName.easeIn);
//        animation2.fromValue = 0.0;
//        animation2.toValue = 2.0;
//
//        cell.pop_add(animation, forKey: "springpop");
//        cell.pop_add(animation2, forKey: "basicpop")

//        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let type = arrayCell[indexPath.row] as? CellDic {
            if let cell = tableView.dequeueReusableCell(withIdentifier: type.cellIdentify, for: indexPath) as? UITableViewCell {
                cell.textLabel?.text = "checkcell"
                return cell
            }
        } else {
            switch arrayCell[indexPath.row] {
            case let ViewControllerCellType.VCCellTypeDisplay(cell):
                cell.textLabel?.text = getTotalCacheSize()
                return cell

            case ViewControllerCellType.VCCellTypeAuth:
//                if #available(iOS 13.0, *) {
//                    let btnAuth = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
//                    btnAuth.addTarget(self, action: #selector(btnAuthAction(sender:)), for: .touchUpInside)
//                    cell.addSubview(btnAuth)
//                    return cell
//                }
                break

            default:
                print("no")
            }
            let cell = TableViewCell(style: .default, reuseIdentifier: TableViewCellIdentify.kkTableViewCell)
            cell.textLabel?.text = "\(indexPath.row + 1)"
            return cell
        }
//        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentify.kkTableViewCell) as? SwipeTableViewCell {
//            cell.textLabel?.text = "\(indexPath.row + 1)"
//
//            return cell
//        }
//        else if let cell = tableView.dequeueReusableCell(withIdentifier: "CheckCell", for: indexPath) as? CheckCell {
//            cell.textLabel?.text = "checkcell";
//            return cell;
//        }
//        else{
//
//        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.shake()
        }

        if let type = arrayCell[indexPath.row] as? CellDic {
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: type.cellIdentify, for: indexPath) as? UITableViewCell {
                view.makeToast("checkcell = \(cell1)")
            }
        }

        switch arrayCell[indexPath.row] {
        case let ViewControllerCellType.VCCellTypeDisplay(cell1):
            view.makeToast("cell1 = \((cell1.textLabel?.text)!)")
        case let ViewControllerCellType.VCCellTypeAuth(cell2):
            view.makeToast("cell2 = \(cell2)")
        default:
            break
        }

        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(videoVC ?? UIViewController(), animated: true)
        case 1:

            let n = forgJump(9)
            print("n = \(n!)")
            view.makeToast("n = \(n!)")
        case 2:
            chooseVideoURL()

        case 3:
            playWithVLCMedia()
        case 4:
            playWithVLCInLocal()
        case 5:
            performSQLite()
        case 6:
            writeColmn(id: indexPath.row, name: indexPath.row.string)
        case 7:
            getColmn()
        case 8:
//            let vc = EurekaTestViewController(style: .plain)
//            navigationController?.pushViewController(vc)
        break
        case 9:
            let vc = QueueDownloadVC()
            navigationController?.pushViewController(vc)
        case 11:
            let vc = CalendarVC()
            navigationController?.pushViewController(vc, animated: true)
        case 12:
            showSwiftMessage()
        case 13:
            let vc = ChartVC()
            navigationController?.pushViewController(vc, animated: true)
        case 14:
            let vc = SliderMenuTestVC()

            navigationController?.pushViewController(vc, animated: true)
        case 16:
            let vc = SwipeVC()
            navigationController?.pushViewController(vc, animated: true)
        case 19:
//            let url = URL(string: "CustomseSpace://dfdf");
            let url = URL(string: "CustomseSpace://dfdf")
            if #available(iOS 10, *) {
                UIApplication.shared.open(url ?? URL(fileURLWithPath: ""), options: [:],
                                          completionHandler: {
                                              success in
                                              print(success)
                })
            } else {
                UIApplication.shared.openURL(url ?? URL(fileURLWithPath: ""))
            }
        case 20:
            let vc = TestViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 21:
            let vc = ApiTestViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 22:
            let vc = OCMVVMVC()
            navigationController?.pushViewController(vc, animated: true)
        case 23:
            let vc = QueueVC()
            navigationController?.pushViewController(vc, animated: true)
        case 24:
            let vc = RACCollectionTestVC()
            navigationController?.pushViewController(vc, animated: true)
        case 25:
            let vc = SortVC()
            navigationController?.pushViewController(vc, animated: true)
        case 26:
            let vc = OCSortVC()
            navigationController?.pushViewController(vc, animated: true)
        case 27:
//            NotificationCenter.default.post(name: NSNotification.Name., object: nil, userInfo: ["msg": "I Quit"])
            appShared?.todayDefault?.set("I Quit", forKey: "msg")
            appShared?.todayDefault?.synchronize()
            print(appShared?.todayDefault?.object(forKey: "msg"))
            print("27")
            case 28:
            //            NotificationCenter.default.post(name: NSNotification.Name., object: nil, userInfo: ["msg": "I Quit"])
                        appShared?.todayDefault?.set("lossless", forKey: "msg")
                        appShared?.todayDefault?.synchronize()
                        print(appShared?.todayDefault?.object(forKey: "msg"))
                        print("28")
        default:
            print(indexPath.row)
        }
        switch arrayCell[indexPath.row] {
        case let ViewControllerCellType.VCCellTypeDisplay(cell):
            CacheManager.clearCache()
            cell.textLabel?.text = getTotalCacheSize()
        default:
            print("no")
        }
    }

    /*
     @objc func btnAuthAction(sender _: Any) {
         if #available(iOS 13.0, *) {
             let appleIDProvider = ASAuthorizationAppleIDProvider()

             // 创建新的AppleID 授权请求
             let appleIDRequest = appleIDProvider.createRequest()

             // 在用户授权期间请求的联系信息
             appleIDRequest.requestedScopes = [ASAuthorization.Scope.fullName, ASAuthorization.Scope.email]

             // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
             let authorizationController = ASAuthorizationController(authorizationRequests: [appleIDRequest])

             // 设置授权控制器通知授权请求的成功与失败的代理
             authorizationController.delegate = self

             // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
             authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding

             // 在控制器初始化期间启动授权流
             authorizationController.performRequests()
         }
     }
     */
    fileprivate func chooseVideoURL() {
        let sheetAlert = UIAlertController(title: "播放视频", message: "选择视频地址", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "sv_mp4", style: .default) { [weak self] _ in
            let vc = KxMovieViewController.movieViewController(withContentPath: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4", parameters: nil) as! KxMovieViewController
            self?.playWithKXMovie(movieVC: vc)
        }
        let action2 = UIAlertAction(title: "sv_flv", style: .default) { [weak self] _ in
            let vc = KxMovieViewController.movieViewController(withContentPath: "https://sample-videos.com/video123/flv/720/big_buck_bunny_720p_30mb.flv", parameters: nil) as! KxMovieViewController
            self?.playWithKXMovie(movieVC: vc)
        }
        let action3 = UIAlertAction(title: "sv_mkv", style: .default) { [weak self] _ in
            let vc = KxMovieViewController.movieViewController(withContentPath: "https://sample-videos.com/video123/mkv/720/big_buck_bunny_720p_30mb.mkv", parameters: nil) as! KxMovieViewController
            self?.playWithKXMovie(movieVC: vc)
        }
        let action4 = UIAlertAction(title: "test_avi", style: .default) { [weak self] _ in
            let vc = KxMovieViewController.movieViewController(withContentPath: "http://43.248.49.206/hgmeap-pluginserver-hgmeapDMZVideo/hgmeapAssist/video/avi.avi?token=1ZUWlS11Av7HIn41gsI9rZj7Q2YA3123gNXlujrIwLiTmKF4Sj", parameters: nil) as! KxMovieViewController
            self?.playWithKXMovie(movieVC: vc)
        }
        let action5 = UIAlertAction(title: "test_mp3", style: .default) { [weak self] _ in
//            http://43.248.49.206/hgmeap-pluginserver-hgmeapDMZVideo/hgmeapAssist/video/mp3.mp3?token=lCJ8a5aB7Segc8ZS2337aFpXHvKMCGCkV0LGC190kFkz8kt5GT
            let vc = KxMovieViewController.movieViewController(withContentPath: "http://43.248.49.206/hgmeap-pluginserver-hgmeapDMZVideo/hgmeapAssist/video/mp3.mp3?token=lCJ8a5aB7Segc8ZS2337aFpXHvKMCGCkV0LGC190kFkz8kt5GT", parameters: nil) as! KxMovieViewController
            self?.playWithKXMovie(movieVC: vc)
        }
        let action6 = UIAlertAction(title: "test_wma", style: .default) { [weak self] _ in
            //            http://43.248.49.206/hgmeap-pluginserver-hgmeapDMZVideo/hgmeapAssist/video/mp3.mp3?token=lCJ8a5aB7Segc8ZS2337aFpXHvKMCGCkV0LGC190kFkz8kt5GT
            let tmp = Bundle.main.path(forResource: "wma", ofType: "wma")
            let vc =
                KxMovieViewController.movieViewController(withContentPath: tmp, parameters: nil) as! KxMovieViewController
            self?.playWithKXMovie(movieVC: vc)
        }

        let action7 = UIAlertAction(title: "test_wav", style: .default) { [weak self] _ in
            //            http://43.248.49.206/hgmeap-pluginserver-hgmeapDMZVideo/hgmeapAssist/video/mp3.mp3?token=lCJ8a5aB7Segc8ZS2337aFpXHvKMCGCkV0LGC190kFkz8kt5GT
            let tmp = Bundle.main.path(forResource: "wav", ofType: "wav")
            let vc =
                KxMovieViewController.movieViewController(withContentPath: tmp, parameters: nil) as! KxMovieViewController
            self?.playWithKXMovie(movieVC: vc)
        }
//        http://43.248.49.206:80/hgmeap-pluginserver-hgmeapDMZVideo/hgmeapAssist/video/avi.avi?token=9fjeVM641qXWs9YCPZ1h1h6wBM9DLol18bRDro5NR7FL1pXX9S
        sheetAlert.addAction(action1)
        sheetAlert.addAction(action2)
        sheetAlert.addAction(action3)
        sheetAlert.addAction(action4)
        sheetAlert.addAction(action5)
        sheetAlert.addAction(action6)
        sheetAlert.addAction(action7)
        sheetAlert.addAction(title: "取消", style: .cancel, isEnabled: true) { _ in
        }

        sheetAlert.show(animated: true, vibrate: true) {}

//        playWithKXMovie();
    }

//    @available(iOS 13.0, *)
//    func presentationAnchor(for _: ASWebAuthenticationSession) -> ASPresentationAnchor {
//        return view.window!
//    }
//
//    @available(iOS 13.0, *)
//    func authorizationController(controller _: ASAuthorizationController, didCompleteWithError _: Error) {}
//
//    @available(iOS 13.0, *)
//    func authorizationController(controller _: ASAuthorizationController, didCompleteWithAuthorization _: ASAuthorization) {}

    fileprivate func getTotalCacheSize() -> String {
        let p1 = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        let d1 = CacheManager.getCacheSize(path: p1)
        let p2 = NSTemporaryDirectory()
        let d2 = CacheManager.getCacheSize(path: p2)
        let p3 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        let d3 = CacheManager.getCacheSize(path: p3)
        let t = d1.1 + d2.1 + d3.1
        return String(format: "%.2fmb", t)
    }

    fileprivate func showSwiftMessage() {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.info)
        view.configureDropShadow()
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        view.configureContent(title: "Info", body: "That's gooooood stuff", iconText: iconText)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        view.backgroundView.cornerRadius = 10.0
        view.button?.setTitle("Cancel", for: .normal)
        view.button?.setBackgroundImage(UIImage(color: .white, size: .init(width: view.button?.size.width ?? 0.0, height: view.button?.size.height ?? 0.0)), for: .normal)

        // Show the message.
        SwiftMessages.show(view: view)
    }

    fileprivate func performSQLite() {
        do {
            let dataPath = getDBFilePath()[0]
            let tmp = getDBFilePath()[1]
            let manager = FileManager.default

            if manager.fileExists(atPath: tmp) == false {
                try manager.createDirectory(atPath: dataPath, withIntermediateDirectories: true, attributes: nil)
                manager.createFile(atPath: tmp, contents: nil, attributes: nil)
            }

            let db = try Connection(tmp)
            let table = Table("MyTable")
            let id = Expression<Int64>("id")
            let name = Expression<String?>("name")
            try db.run(table.create(block: { tb in
                tb.column(id, primaryKey: true)
                tb.column(name)
            }))
            view.makeToast("创建成功")
        } catch let err as NSError {
            print(err.localizedDescription)
            if err.code == 14 {
                view.makeToast("无法保存文件")
            } else if err.code == 0 {
                view.makeToast("数据库已被创建")
            }
        }

        //        let strCreate = "create table MySQL ( id int primary key, name text );"
        //        sqlite.execute(query: strCreate);
    }

    fileprivate func writeColmn(id: Int, name: String) {
        do {
            let db = try Connection(getDBFilePath()[1])
            let table = Table("MyTable")
            let id1 = Expression<Int64>("id")
            let name1 = Expression<String?>("name")
            let insert = table.insert(id1 <- Int64(id), name1 <- name)
            let rowid = try db.run(insert)
            print(rowid)
            view.makeToast("写入数据成功")
        } catch let err as NSError {
            print(err.localizedDescription)
            view.makeToast("插入数据失败")
        }
    }

    fileprivate func getColmn() {
        do {
            let db = try Connection(getDBFilePath()[1])
            let table = Table("MyTable")
            let id1 = Expression<Int64>("id")
            let name1 = Expression<String?>("name")
            //            let select = table.select(id1, name1);
            var str = ""
            for t in try db.prepare(table) {
                print("id: \(t[id1]), name: \(t[name1]!)")
                // id: 1, name: Optional("Alice"), email: alice@mac.com
                str = "id: \(t[id1]), name: \(t[name1]!)"
            }
            view.makeToast("获取数据成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) { [weak self] in
                if let strongSelf = self {
                    strongSelf.view.makeToast(str)
                }
            }
        } catch let err as NSError {
            print(err.localizedDescription)
            view.makeToast("获取数据失败")
        }
    }

    // MARK: 青蛙跳

    // 若把条件修改成一次可以跳一级，也可以跳2级...也可以跳上n级呢，则f(n) = 2^{n-1}
    // 这里需要注意一下溢出的问题，因为在swift里若相加溢出，则会直接crash，所以这里相加使用了 &+，溢出后返回nil
    fileprivate func forgJump(_ number: UInt64) -> UInt64? {
        if number == 1 {
            return 1
        } else if number == 2 {
            return 1
        }
        var fibNMinusOne: UInt64 = 1
        var fibNMinusTwo: UInt64 = 1
        var fibN: UInt64 = 0
        for _ in 3 ... number {
            fibN = fibNMinusOne &+ fibNMinusTwo
            if fibN < fibNMinusOne {
                return nil
            }
            fibNMinusTwo = fibNMinusOne
            fibNMinusOne = fibN
        }
        return fibN
    }

    fileprivate func getDBFilePath() -> [String] {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("/db")
        let tmp = dataPath + "MySQL.db"
        return [dataPath, tmp]
    }

    fileprivate func playWithVLCInLocal() {
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            // 两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        Alamofire.download("http://192.168.0.88:80/hgmeap-pluginserver-sp0619/flv.flv", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, to: destination).response { response in
            print("response \(response)")

            _ = response.destinationURL?.absoluteString.replacingOccurrences(of: "file://", with: "")

            DispatchQueue.main.async {
                //            self.present(self.vlcPlayerVC ?? UIViewController(), animated: true, completion: nil);
            }
        }
    }

//    fileprivate func initRealm() {
//        do {
//            let realm = try Realm()
//            realm.create(TestModel.self)
//        } catch let err as NSError {
//            print(err.localizedDescription)
//        }
//    }

    fileprivate func showVideoChoose() {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(self.view.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(200.0)
        }
        self.view.addSubview(view)

        let tableView = UITableView()

        tableView.rx.itemSelected.subscribe { _ in
            print("item selected")
        }
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        view.addSubview(tableView)
    }

    fileprivate func playWithKXMovie(movieVC: KxMovieViewController) {
        DispatchQueue.main.async {
            MainStatusView.statusView?.isHidden = true
            MainStatusView.statusWindow?.isHidden = true
//            self.present(self.xMovieVC ?? UIViewController(), animated: true, completion: nil);

            self.navigationController?.pushViewController(movieVC)
        }
    }

    fileprivate func playWithVLCMedia() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(self.vlcPlayerMediaVC ?? UIViewController(), animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true

        UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")

        NotificationCenter.default.rx.notification(Notification.Name("popVC")).subscribe(onNext: { [weak self] noti in
            if let cls = noti.object as? AnyClass {
                if cls == SliderMenuTestVC.superclass() {
                    self?.addStatusBar()
                }
            }
        }, onError: { _ in

        }, onCompleted: {})

        MainStatusView.statusView?.isHidden = false
        MainStatusView.statusWindow?.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 这里是强制竖屏  希望什么方向修改这个枚举即可
//        UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")

//        UIApplication.shared.setori
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }

    override func cyl_pushOrPop(to viewController: UIViewController, animated: Bool, callback: @escaping CYLPushOrPopCallback) {
        super.cyl_pushOrPop(to: viewController, animated: animated, callback: callback)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscapeRight]
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}
