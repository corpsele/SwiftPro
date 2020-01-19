//
//  SortTest.swift
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

import UIKit

class SortTest: NSObject {
    // MARK: 冒泡排序

    static func bubbleSorting1(arr: [Int]) -> [Int] {
        var sortArr: [Int] = arr
        var swapped = false
        for i in 0 ..< sortArr.count {
            swapped = false
            for j in 0 ..< sortArr.count - 1 - i {
                if sortArr[j] > sortArr[j + 1] {
                    sortArr.swapAt(j, j + 1)
                    swapped = true
                }
            }
            if swapped == false {
                break
            }
        }

        return sortArr
    }

    // MARK: 选择排序

    static func selectionSorting(arr: [Int]) -> [Int] {
        var sortArr = arr
        let n = sortArr.count
        for i in 0 ..< n {
            // 寻找[i, n)区间里的最小值的索引
            var minIndex = i
            for j in (i + 1) ..< n {
                if sortArr[minIndex] > sortArr[j] {
                    minIndex = j
                }
            }

            sortArr.swapAt(i, minIndex)
        }

        return sortArr
    }


    private
    static var arr: [Int] = Array()
    // MARK: 快速排序
    static func quickSort(arr: [Int]) -> [Int] {
        self.arr = arr
        recursiveQuickSort(l: 0, r: arr.count - 1)
        return self.arr
    }

    // MARK: 递归排序
    private
    static func recursiveQuickSort(l: Int, r: Int) {
        if l >= r {
            return
        }

        let p = partition(l: l, r: r)
        recursiveQuickSort(l: l, r: p - 1)
        recursiveQuickSort(l: p + 1, r: r)
    }

    // 对arr[l...r]部分进行partition
    // 返回p，使得arr[l...p-1] < arr[p]  arr[p+1...r] > arr[p]
    private
    static func partition(l: Int, r: Int) -> Int {
        let v = arr[l]

        // arr[l+1...j] < v   arr[j+1...i] > v
        var j = l
        for i in l + 1 ..< r + 1 {
            if arr[i] < v {
                arr.swapAt(j + 1, i)
                j += 1
            }
        }

        arr.swapAt(l, j)
        return j
    }
    
    // MARK: 插入排序
    static func insertSorting(arr:[Int]) -> Array<Int>{
        var sortArr = arr
        for i in 0..<sortArr.count {
            for j in stride(from: i, to: 0, by: -1) {
                if sortArr[j] < sortArr[j-1]{
                    sortArr.swapAt(j, j-1)
                }
            }
        }
        return sortArr
    }
}
