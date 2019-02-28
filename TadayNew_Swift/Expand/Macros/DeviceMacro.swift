//
//  DeviceMacro.swift
//  TodayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import Foundation
import UIKit

// MARK: ========= DeviceInfo ==========
/// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/// iPhone4
let isIphone4 = SCREEN_HEIGHT  < 568 ? true : false
/// iPhone 5
let isIphone5 = SCREEN_HEIGHT  == 568 ? true : false
/// iPhone 6
let isIphone6 = SCREEN_HEIGHT  == 667 ? true : false
/// iphone 6P
let isIphone6P = SCREEN_HEIGHT == 736 ? true : false
/// iphone X_XS
let isIphoneX_XS = SCREEN_HEIGHT == 812 ? true : false
/// iphone XR_XSMax
let isIphoneXR_XSMax = SCREEN_HEIGHT == 896 ? true : false
/// 全面屏
let isFullScreen = (isIphoneX_XS || isIphoneXR_XSMax)

let kStatusBarHeight : CGFloat = isFullScreen ? 44 : 20
let kNavigationBarHeight : CGFloat =  44
let kStatusBarAndNavigationBarHeight : CGFloat = isFullScreen ? 88 : 64
let kBottomSafeMargin : CGFloat = isFullScreen ? 34 : 0
let kTabbarHeight : CGFloat = isFullScreen ? 49 + 34 : 49

// MARK: ========= 屏幕适配 ==========
let  kScaleX : Float = Float(SCREEN_WIDTH / 375.0)
let  kScaleY : Float = Float(SCREEN_HEIGHT / 667.0)
///适配后的宽度
func AdaptedWidth(w : Float) -> Float {
    return ceilf(w * kScaleX)
}
///适配后的高度
func AdaptedHeight(h : Float) -> Float {
    return ceilf(h * kScaleY)
}

// MARK: ========= 字体适配 ==========
///适配后的普通字体(系统)
func AdaptedSystomFont(size : Float) -> UIFont {
    return UIFont.systemFont(ofSize: CGFloat(AdaptedWidth(w: size)))
}
///适配后的粗字体(系统)
func AdaptedSystomBlodFont(size : Float) -> UIFont {
    return UIFont.boldSystemFont(ofSize: CGFloat(AdaptedWidth(w: size)))
}

///字体名
let  CHINESE_FONT_NAME : String = "PingFangSC-Light"
let  CHINESE_BLODFONT_NAME : String = "PingFangSC-Regular"

///适配后的普通字体
func AdaptedCustomFont(size : Float) -> UIFont {
    if let font = UIFont.init(name: CHINESE_FONT_NAME, size: CGFloat(AdaptedWidth(w: size))) {
        return font
    }
    return UIFont.systemFont(ofSize: CGFloat(size))
    
}
///适配后的粗字体
func AdaptedCustomBlodFont(size : Float) -> UIFont {
    if let font = UIFont.init(name: CHINESE_BLODFONT_NAME, size: CGFloat(AdaptedWidth(w: size))) {
        return font
    }
    return UIFont.boldSystemFont(ofSize: CGFloat(size))
}
