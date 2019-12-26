//
//  ApiTestModel.swift
//  SwiftPro
//
//  Created by eport2 on 2019/12/24.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit
import SwiftyJSON
import ReactiveCocoa
import RxSwift
import Alamofire
import RxAlamofire
import RxDataSources

class ApiTestModel: NSObject {
    var dn: String?
    var city: [City]
    var error_code: Int?
    
    init(data: JSON) {
        dn = data["@attributes"]["dn"].stringValue
        
        var array: [City] = []
        for d in data["city"].arrayValue {
            array.append(City(data: d["@attributes"]))
        }
        city = array
        
        error_code = data["error_code"].intValue
    }
    
    static func requestApi() -> Observable<[SectionModel<String, City>]> {
        let disposeBag = DisposeBag()
        let apiObModel: Observable<[SectionModel<String, City>]> = Observable<[SectionModel<String, City>]>.create { observer -> Disposable in
            requestJSON(.get, "http://zhouxunwang.cn/data/", parameters: ["id":"7","key":"AOrA8YduH93+jJuK8o87QW/HMwTgsJeZ/px1","name":"beijing"], encoding: URLEncoding.queryString, headers: [:]).subscribe(onNext: { (response, json) in
                
                let model = ApiTestModel.init(data: JSON(json))
                let section: [SectionModel<String, City>] = [SectionModel<String, City>(model: "", items: model.city)]
                observer.onNext(section)
                    observer.onCompleted()

            }, onError: { (err) in
                
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: disposeBag)


            return Disposables.create()
        }
        

        return apiObModel
    }
}

struct City {
    var cityX: String?
    var cityY: String?
    var cityname: String?
    var centername: String?
    var fontColor: String?
    var pyName: String?
    var state1: String?
    var state2: String?
    var stateDetailed: String?
    var tem1: String?
    var tem2: String?
    var temNow: String?
    var windState: String?
    var windDir: String?
    var windPower: String?
    var humidity: String?
    var time: String?
    var url: String?
    
    init(data: JSON) {
        cityX = data["cityX"].stringValue
        cityY = data["cityY"].stringValue
        cityname = data["cityname"].stringValue
        centername = data["centername"].stringValue
        fontColor = data["fontColor"].stringValue
        pyName = data["pyName"].stringValue
        state1 = data["state1"].stringValue
        state2 = data["state2"].stringValue
        stateDetailed = data["stateDetailed"].stringValue
        tem1 = data["tem1"].stringValue
        tem2 = data["tem2"].stringValue
        temNow = data["temNow"].stringValue
        windState = data["windState"].stringValue
        windDir = data["windDir"].stringValue
        windPower = data["windPower"].stringValue
        humidity = data["humidity"].stringValue
        time = data["time"].stringValue
        url = data["url"].stringValue
    }
}

struct ApiTestSectionModel {
    var items: [Item]
}

extension ApiTestSectionModel: SectionModelType {
  
    // 重定义 Item 的类型为 LXFModel
    typealias Item = City
  
    // 实现协议中的方式
    init(original: ApiTestSectionModel, items: [ApiTestSectionModel.Item]) {
        self = original
        self.items = items
    }
    
}
