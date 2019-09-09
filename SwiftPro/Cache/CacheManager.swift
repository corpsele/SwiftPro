//
//  CacheManager.swift
//  SwiftPro
//
//  Created by eport on 2019/8/8.
//  Copyright © 2019 eport. All rights reserved.
//

import UIKit

class CacheManager: NSObject {

    ///获取APP缓存
    static func getCacheSize()-> String {
        
        // 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        if let arr = fileArr {
            for file in arr {
                
                // 把文件名拼接到路径中
                let path = cachePath! + ("/\(file)")
                // 取出文件属性
                let floder = try! FileManager.default.attributesOfItem(atPath: path)
                // 用元组取出文件大小属性
                for (key, fileSize) in floder {
                    // 累加文件大小
                    if key == FileAttributeKey.size {
                        size += (fileSize as AnyObject).integerValue
                    }
                }
            }

        }
        
        let totalCache = Double(size) / 1024.00 / 1024.00
        var temp = "无缓存"
        print("totalCache = \(totalCache)")
        if totalCache.isZero == false {
            temp = String(format: "%.2f", totalCache)
        }
        return temp
    }
    
    static func getCacheSize(path: String)-> (String, Double) {
        

        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: path)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        if let arr = fileArr {
            for file in arr {
                
                // 把文件名拼接到路径中
                let path1 = path + ("/\(file)")
                // 取出文件属性
                let floder = try! FileManager.default.attributesOfItem(atPath: path1)
                // 用元组取出文件大小属性
                for (key, fileSize) in floder {
                    // 累加文件大小
                    if key == FileAttributeKey.size {
                        size += (fileSize as AnyObject).integerValue
                    }
                }
            }
            
        }
        
        let totalCache = Double(size) / 1024.00 / 1024.00
        var temp = "无缓存"
        print("totalCache = \(totalCache)")
        if totalCache.isZero == false {
            temp = String(format: "%.2f", totalCache)
        }
        return (temp, totalCache)
    }
    
    
    ///删除APP缓存
    static func clearCache() {
        
        // 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        
        // 遍历删除
        print("cachepath = \(cachePath)")
        if let arr = fileArr {
            print("arr = \(arr)")
            for file in arr {
                
                let path = (cachePath! as NSString).appending("/\(file)")
                
                if FileManager.default.fileExists(atPath: path) {
                print("cache path = \(path)")
                    do {
                        
                        
                        try FileManager.default.removeItem(atPath: path)
                        
                    } catch let err {
                        
                        print("err = \(err)")
                        
                    }
                    
                }
                
            }

        }
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        
        let fileArr2 = FileManager.default.subpaths(atPath: documentPath!)
        
        // 遍历删除
        
        if let arr = fileArr2 {
            print("arr = \(arr)")
            for file in arr {
                
                let path = (documentPath! as NSString).appending("/\(file)")
                print("document path = \(path)")
                if FileManager.default.fileExists(atPath: path) {
                    
                    do {
                        
                        try FileManager.default.removeItem(atPath: path)
                        
                    } catch let err {
                        
                        print("err = \(err)")
                        
                    }
                    
                }
                
            }
            
        }

        
        
        let tmp = NSTemporaryDirectory()
        
        let fileArr1 = FileManager.default.subpaths(atPath: tmp)
        
        // 遍历删除
//        print("filearr1 = \(fileArr1)")
        if let arr = fileArr1 {
            for file in arr {
                
                let path = (tmp as NSString).appending("\(file)")
                print("tmp path = \(path)")
                if FileManager.default.fileExists(atPath: path) {
                    
                    do {
                        
                        try FileManager.default.removeItem(atPath: path)
                        
                    } catch let err {
                        
                        
                        print("err = \(err)")
                    }
                    
                }
                
            }
            
        }

    }
   
}
