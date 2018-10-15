//
//  UtilsMacro.swift
//  TodayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import Foundation
import UIKit

/// RGBA的颜色设置
func RGBAColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 随机色
func ZLRandomColor() -> UIColor{
    let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
    let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
    let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

/**
 *  16进制 转 RGB
 */
func HexColor(rgb:Int) -> UIColor {
    return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                   alpha: 1.0)
}

// MARK: ========= app信息 ==========
///app ID  上线构建版本产生
let kAppId = "1267669059"

let CurrentLanguage = NSLocale.preferredLanguages[0]

struct AppInfo {
    
    static let infoDictionary = Bundle.main.infoDictionary
    
    static let appDisplayName: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String //App 名称
    
    static let bundleIdentifier:String = Bundle.main.bundleIdentifier! // Bundle Identifier
    
    static let appVersion:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String// App 版本号
    
    static let buildVersion : String = Bundle.main.infoDictionary! ["CFBundleVersion"] as! String //Bulid 版本号
    static let iOSVersion:String = UIDevice.current.systemVersion //ios 版本
    
    static let identifierNumber = UIDevice.current.identifierForVendor //设备 udid
    
    static let systemName = UIDevice.current.systemName //系统名称  e.g. @"iOS"
    
    static let model = UIDevice.current.model //设备名称 e.g. @"iPhone", @"iPod touch"
    
    static let localizedModel = UIDevice.current.localizedModel  //设备区域化型号
    
}

// MARK: ========= GlobleFunc ==========
///自定义打印
func MYLog<T>(message: T)
{
    #if DEBUG
    print(" \(message)");
    #endif
}

///由角度转换弧度 (M_PI * (x) / 180.0)
func DegreesToRadian(degree : Double) -> Double {
    return Double.pi * degree / 180.0
}

///由弧度转换角度  (radian * 180.0) / (M_PI)
func RadianToDegrees(radian : Double) -> Double {
    return radian * 180.0 / Double.pi
}
