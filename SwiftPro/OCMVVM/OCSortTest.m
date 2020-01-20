//
//  OCSortTest.m
//  SwiftPro
//
//  Created by eport2 on 2020/1/19.
//  Copyright © 2020 eport. All rights reserved.
//

#import "OCSortTest.h"

@implementation OCSortTest

static OCSortTest *sortTest;

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sortTest = [OCSortTest new];
    });
    return sortTest;
}

// MARK: 冒泡排序
-(void)bubbleSequence:(NSMutableArray *)arr
{
    //普通排序-交换次数较多
    for (int i = 0; i < arr.count; ++i) {
        for (int j = 0; j < arr.count-1-i; ++j) {
            if ([arr[j+1] intValue] < [arr[j] intValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    //优化后算法-从第一个开始排序，空间复杂度相对更大一点
    for (int i = 0; i < arr.count; ++i) {
        bool flag=false;
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = 0; j < arr.count-1-i; ++j) {
            
            //根据索引的`相邻两位`进行`比较`
            if ([arr[j+1] intValue] < [arr[j] intValue]) {
                flag = true;
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
        if (!flag) {
            break;//没发生交换直接退出，说明是有序数组
        }
    }
    //优化后算法-从最后一个开始排序
    for (int i = 0; i <arr.count; ++i) {
        bool flag=false;
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = (int)arr.count-1; j >i; --j) {
            
            //根据索引的`相邻两位`进行`比较`
            if ([arr[j-1] intValue] > [arr[j] intValue]) {
                flag = true;
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
            }
        }
        if (!flag) {
            break;//没发生交换直接退出，说明是有序数组
        }
    }
}

// MARK: 选择排序
-(void)chooseSequence:(NSMutableArray *)arr
{
    //选择排序-依次找出剩余元素最小值 ,对于长度为 N 的数组,选择排序需要大约 N^2 次比较和 N 次交换
    for (int i = 0; i<arr.count; i++) {
        int min = i;
        int a = [arr[i] intValue];
        for (int j = i+1; j<arr.count; j++) {
            if ([arr[j] intValue]<a) {
                min = j;
                a = [arr[j] intValue];
            }
        }
        [arr exchangeObjectAtIndex:i withObjectAtIndex:min];
    }

   //或者下面方法，就是交换次数比较多
    for (int i = 0; i<arr.count; i++) {
        for (int j = i+1; j<arr.count; j++) {
            if ([arr[j] intValue]<[arr[i] intValue]) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
}

// MARK: 插入排序
-(NSMutableArray *)insertSequence:(NSMutableArray *)arr
{
    for (int i = 1; i<arr.count; i++) {
        int a=[arr[i] intValue];
        int k = i-1;
        while (k>=0&&[arr[k] intValue]>a) {
            arr[k + 1] = arr[k];
            k-=1;
        }
        arr[k+1] = [NSString stringWithFormat:@"%d",a];
        NSLog(@"%@",arr);
    }
    return arr;
}

// MARK: 快速排序
-(void)quickSequence:(NSMutableArray *)arr andleft:(int)left andright:(int)right
{
    if (left >= right) {//如果数组长度为0或1时返回
        return ;
    }
    int key = [arr[left] intValue];
    int i = left;
    int j = right;
    
    while (i<j){
        while (i<j&&[arr[j] intValue]>=key) {
            j--;
        }
        arr[i] = arr[j];
        
        while (i<j&&[arr[i] intValue]<=key) {
            i++;
        }
        arr[j] = arr[i];
    }
    arr[i] = [NSString stringWithFormat:@"%d",key];
    [self quickSequence:arr andleft:left andright:i-1];
    [self quickSequence:arr andleft:i+1 andright:right];
}

@end
