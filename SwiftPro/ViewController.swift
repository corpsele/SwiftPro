//
//  ViewController.swift
//  SwiftPro
//
//  Created by eport on 2019/7/11.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit
import Spring
import Sica
import SwipeCellKit
import Alamofire
import ZHRefresh
import SQLite.Swift
//import ToastSwiftFramework
import RealmSwift
import Material
import pop
import JJException
import Eureka
import SwiftMessages
import Realm
import Toast_Swift
import RxSwift
import RxCocoa
import AuthenticationServices
import CoreServices
import LocalAuthentication

struct MainStatusView {
    static var statusView: UIView?;
    static var statusWindow: UIWindow?;
}

struct CellDic {
    var cellIdentify: String;
    var cellType: AnyClass;
    
    init(cellIdentify: String, cellType: AnyClass){
        self.cellIdentify = cellIdentify;
        self.cellType = cellType;
    }
}

enum ViewControllerCellType {
    case VCCellTypeDisplay(UITableViewCell)
    case VCCellTypeAuth(TableViewCell)
}

// MARK: - TableViewCell Identify
struct TableViewCellIdentify {
     static let kkTableViewCell: String = "TableViewCell";
    static let kkTableViewCellCheck: String = "TableViewCheckCell";
    static let kkTableViewCellAuth: String = "TableViewCheckCellAuth"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding {
    var arrayCell: [Any] = [Any](repeating: 0, count: 500);
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        if UIDevice.current.isGeneratingDeviceOrientationNotifications == false {
            UIDevice.current.beginGeneratingDeviceOrientationNotifications();
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationListener), name: UIDevice.orientationDidChangeNotification, object: self);
        
        
        
       let _  = NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification, object: self).subscribe(onNext: { (noti) in
            let orientation = UIDevice.current.orientation;
            if orientation != UIDeviceOrientation.portrait {
                UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
            }
        }, onError: { (err) in
            print(err)
        })

    }
    
    fileprivate lazy var vlcPlayerMediaVC: FFMpegVideoViewController? = {
        let vc = FFMpegVideoViewController();
        return vc;
    }()
    
    fileprivate lazy var xMovieVC: KxMovieViewController? = {
        let vc = KxMovieViewController.movieViewController(withContentPath: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", parameters: nil) as? KxMovieViewController;
        return vc;
    }()
        
    fileprivate lazy var videoVC: VideoViewController? = {
        let vc = VideoViewController();
        return vc;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white;
        
        addViews();
        registerTableViewCell();
        
        let type = CellDic(cellIdentify: TableViewCellIdentify.kkTableViewCellCheck, cellType: CheckCell.self);
        arrayCell[10] = type;
        arrayCell[15] = ViewControllerCellType.VCCellTypeDisplay(UITableViewCell())
        tableView.register(type.cellType, forCellReuseIdentifier: type.cellIdentify);
        
//        let authType = CellDic(cellIdentify: TableViewCellIdentify.kkTableViewCellAuth, cellType: TableViewCell.self);
        arrayCell[20] = ViewControllerCellType.VCCellTypeAuth(TableViewCell());

        if #available(iOS 11.0, *) {
            // 作用于指定的UIScrollView
            tableView.contentInsetAdjustmentBehavior = .automatic;
            // 作用与所有的UIScrollView
            
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        self.edgesForExtendedLayout = [];

        
        tableView.header = ZHRefreshNormalHeader.headerWithRefreshing(block: { [weak self] in
            self?.tableView.reloadData();
            self?.tableView.header?.endRefreshing();
        })
        
        xMovieVC?.orientationBlock = {
            let orientation = UIDevice.current.orientation;
            if orientation != UIDeviceOrientation.portrait {
//                UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
            }

        };
        
//        view.subviews[999];
    }
    
    @objc func deviceOrientationListener(noti: Notification) {
        
        let orientation = UIDevice.current.orientation;
        if orientation != UIDeviceOrientation.portrait {
            UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    deinit {
        
        
        
    }
    
    fileprivate func addStatusBar(){
        let window = UIApplication.shared.keyWindow;
        windowStatusBar.addSubview(viewStatusBar);
        MainStatusView.statusView = viewStatusBar;
        viewStatusBar.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview();
        }
        window?.addSubview(windowStatusBar);
        MainStatusView.statusWindow = windowStatusBar;
        windowStatusBar.makeKeyAndVisible();
        window?.makeKeyAndVisible();
        windowStatusBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview();
                        if UIDevice.isX() == true{
                            make.height.equalTo(44.0);
                        }else{
                            make.height.equalTo(20.0);
                        }

        }
    }
    
    fileprivate lazy var viewStatusBar: UIView = {
        let view = UIView();
        view.backgroundColor = UIColor.white;
        return view;
    }()
    
    fileprivate lazy var windowStatusBar: UIWindow = {
        let view = UIWindow();
        view.windowLevel = .statusBar + 100;
        return view;
    }()

    
    // MARK: - Add Views
    private func addViews(){
        view.addSubview(tableView);
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview();
        }
        
        addStatusBar();
    }
    
    // MARK: - Register TableViewCell
    private func registerTableViewCell(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCellIdentify.kkTableViewCell);
        tableView.register(CheckCell.self, forCellReuseIdentifier: "CheckCell");
        tableView.delegate = self;
        tableView.dataSource = self;
    }

    // MARK: - TableView
    private var tableView: UITableView = {
        let view = UITableView();
        return view;
    }();
    
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCell.count;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentify.kkTableViewCell) as? SwipeTableViewCell {
        
            CellAnimator.animate(cell, withDuration: 1, animation: .Wave);
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: type.cellIdentify, for: indexPath) as? CheckCell {
                cell.textLabel?.text = "checkcell";
                return cell;
            }
        }
        else {
            switch arrayCell[indexPath.row] {
            case ViewControllerCellType.VCCellTypeDisplay(let cell):
                cell.textLabel?.text = getTotalCacheSize()
                return cell
            case ViewControllerCellType.VCCellTypeAuth(let cell):
                if #available(iOS 13.0, *) {
                    let btnAuth = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black);
                    btnAuth.addTarget(self, action: #selector(btnAuthAction(sender:)), for: .touchUpInside);
                    cell.addSubview(btnAuth);
                    return cell;
                }

            default:
                print("no")
                
            }
            let cell = TableViewCell(style: .default, reuseIdentifier: TableViewCellIdentify.kkTableViewCell);
            cell.textLabel?.text = "\(indexPath.row + 1)"
            return cell;
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
        return UITableViewCell();
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.shake();
        }
        
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(videoVC ?? UIViewController(), animated: true);
        case 1:
        
            print("");
            
        case 2:
            playWithKXMovie();
        case 3:
            playWithVLCMedia();
        case 4:
            playWithVLCInLocal();
        case 5:
//            performSQLite();
            break
        case 6:
//            writeColmn(id: indexPath.row, name: indexPath.row.string);
            break
        case 7:
//            getColmn();
            break
        case 8:
            let vc = EurekaTestViewController(style: .plain);
            self.navigationController?.pushViewController(vc);
        case 9:
            let vc = QueueDownloadVC();
            self.navigationController?.pushViewController(vc);
        case 11:
            let vc = CalendarVC();
            self.navigationController?.pushViewController(vc, animated: true);
        case 12:
            showSwiftMessage();
        case 13:
            let vc = ChartVC();
            self.navigationController?.pushViewController(vc, animated: true);
        case 14:
            let vc = SliderMenuTestVC();
            
            self.navigationController?.pushViewController(vc, animated: true);
        case 16:
            let vc = SwipeVC()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print(indexPath.row);
        }
        switch arrayCell[indexPath.row] {
        case ViewControllerCellType.VCCellTypeDisplay(let cell):
            CacheManager.clearCache()
            cell.textLabel?.text = getTotalCacheSize()
        default:
            print("no")
        }
    }
    
    @objc func btnAuthAction(sender: Any){
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider.init();
            
             // 创建新的AppleID 授权请求
            let appleIDRequest = appleIDProvider.createRequest();
             
             // 在用户授权期间请求的联系信息
            appleIDRequest.requestedScopes = [ASAuthorization.Scope.fullName, ASAuthorization.Scope.email];
             
             // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
            let authorizationController = ASAuthorizationController.init(authorizationRequests: [appleIDRequest]);
             
             // 设置授权控制器通知授权请求的成功与失败的代理
            authorizationController.delegate = self;
             
             // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
            authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding;
             
             // 在控制器初始化期间启动授权流
            authorizationController.performRequests();

        }
         

    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!;
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
    }
    
    fileprivate func getTotalCacheSize() -> String{
        let p1 = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        let d1 = CacheManager.getCacheSize(path: p1)
        let p2 = NSTemporaryDirectory()
        let d2 = CacheManager.getCacheSize(path: p2)
        let p3 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        let d3 = CacheManager.getCacheSize(path: p3)
        let t = d1.1 + d2.1 + d3.1
        return String(format: "%.2fmb", t)
        
        
    }
    
    fileprivate func showSwiftMessage(){
        let view = MessageView.viewFromNib(layout: .cardView);
        view.configureTheme(.info);
        view.configureDropShadow();
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        view.configureContent(title: "Info", body: "That's gooooood stuff", iconText: iconText);
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        view.backgroundView.cornerRadius = 10.0;
        view.button?.setTitle("Cancel", for: .normal);
        view.button?.setBackgroundImage(UIImage.init(color: .white, size: .init(width: view.button?.size.width ?? 0.0, height: view.button?.size.height ?? 0.0)), for: .normal);
        
        // Show the message.
        SwiftMessages.show(view: view)

    }
    
//    fileprivate func performSQLite(){
//        do {
//
//            let dataPath = getDBFilePath()[0];
//             let tmp = getDBFilePath()[1];
//            let manager = FileManager.default;
//
//            if manager.fileExists(atPath: tmp) == false{
//
//                try manager.createDirectory(atPath: dataPath, withIntermediateDirectories: true, attributes: nil);
//                manager.createFile(atPath: tmp, contents: nil, attributes: nil);
//            }
//            let db = try RxSwift.Connection(tmp);
//            let table = Table("MyTable");
//            let id = Expression<Int64>("id")
//            let name = Expression<String?>("name")
//            try db.run(table.create(block: { (tb) in
//                tb.column(id, primaryKey: true);
//                tb.column(name);
//            }));
//        } catch let err as NSError {
//            print(err.localizedDescription);
//            if err.code == 14 {
//                view.makeToast("无法保存文件");
//            }
//            else if err.code == 0 {
//                view.makeToast("数据库已被创建");
//            }
//        }
//
//
////        let strCreate = "create table MySQL ( id int primary key, name text );"
////        sqlite.execute(query: strCreate);
//    }
    
//    fileprivate func writeColmn(id: Int, name: String) {
//        do {
//            let db = try Connection(getDBFilePath()[1]);
//            let table = Table("MyTable");
//            let id1 = Expression<Int64>("id")
//            let name1 = Expression<String?>("name")
//            let insert = table.insert(id1 <- Int64(id), name1 <- name);
//            let rowid = try db.run(insert);
//            print(rowid);
//        } catch let err as NSError {
//            print(err.localizedDescription);
//            view.makeToast("插入数据失败");
//        }
//    }
//
//    fileprivate func getColmn(){
//        do {
//            let db = try Connection(getDBFilePath()[1]);
//            let table = Table("MyTable");
//            let id1 = Expression<Int64>("id");
//            let name1 = Expression<String?>("name");
////            let select = table.select(id1, name1);
//            for t in try db.prepare(table) {
//                print("id: \(t[id1]), name: \(t[name1]!)")
//                // id: 1, name: Optional("Alice"), email: alice@mac.com
//            }
//
//        } catch let err as NSError {
//            print(err.localizedDescription);
//        }
//
//
//    }
    
    fileprivate func getDBFilePath() -> [String] {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("/db");
        let tmp = dataPath + "MySQL.db";
        return [dataPath,tmp];
    }
    
    fileprivate func playWithVLCInLocal(){
        
            
            let destination: DownloadRequest.DownloadFileDestination = { _, response in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
                //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            Alamofire.download("http://192.168.0.88:80/hgmeap-pluginserver-sp0619/flv.flv", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, to: destination).response {  (response) in
                print("response \(response)")
                
                let _ = response.destinationURL?.absoluteString.replacingOccurrences(of: "file://", with: "");
                
                
                
                DispatchQueue.main.async {
                    //            self.present(self.vlcPlayerVC ?? UIViewController(), animated: true, completion: nil);
                    
                }
                
            }
        

    }
    
    fileprivate func initRealm(){
        do {
           let realm = try Realm();
            realm.create(TestModel.self);
        } catch let err as NSError {
            print(err.localizedDescription);
        }
        
        
    }
    
    fileprivate func showVideoChoose(){
        let view = UIView()
        view.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(self.view.snp.bottom)
            make.width.equalToSuperview();
            make.height.equalTo(200.0)
        }
        self.view.addSubview(view)
        
        
        let tableView = UITableView()
        
        tableView.rx.itemSelected.subscribe({(indexPath) in
            
        })
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        view.addSubview(tableView)
        
    }
    
    
    

    
    fileprivate func playWithKXMovie(){
        DispatchQueue.main.async {
            MainStatusView.statusView?.isHidden = true;
            MainStatusView.statusWindow?.isHidden = true;
//            self.present(self.xMovieVC ?? UIViewController(), animated: true, completion: nil);
            
            self.navigationController?.pushViewController(self.xMovieVC ?? UIViewController(), animated: true);
        }
    }
    
    fileprivate func playWithVLCMedia(){
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(self.vlcPlayerMediaVC ?? UIViewController(), animated: true);
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.isNavigationBarHidden = true;
        
        UIDevice.current.setValue(NSNumber(value: UIDeviceOrientation.portrait.rawValue), forKey: "orientation")
        
        NotificationCenter.default.rx.notification(Notification.Name("popVC")).subscribe(onNext: {[weak self] (noti) in
            if let cls = noti.object as? AnyClass {
                if cls == SliderMenuTestVC.superclass() {
                    self?.addStatusBar()
                }
            }
        }, onError: { (err) in
            
        }, onCompleted: {
            
        })
        
        MainStatusView.statusView?.isHidden = false;
        MainStatusView.statusWindow?.isHidden = false;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        //这里是强制竖屏  希望什么方向修改这个枚举即可
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
        return true;
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait;
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait;
    }

}

