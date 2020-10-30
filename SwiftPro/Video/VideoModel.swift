//
//  VideoModel.swift
//  SwiftPro
//
//  Created by eport on 2019/7/12.
//  Copyright © 2019 eport. All rights reserved.
//

import ObjectMapper
import UIKit

class VideoModel: NSObject, Mappable {
    var urlPath: String?
    var url: URL?
    static let shared = VideoModel()
    fileprivate override init() {
        super.init()
    }

    required init?(map: Map) {
        urlPath <- map["urlPath"]
        url = URL(string: urlPath ?? "")
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapping(map: Map) {
        urlPath <- map["urlPath"]
    }

    static func getModel(_ dic: [String: Any]) -> VideoModel {
        shared.urlPath = dic["urlPath"] as? String ?? ""
        shared.url = URL(string: shared.urlPath ?? "")
        return shared
    }
}
