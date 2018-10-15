//
//  Initialization.swift
//  Paihuo_Swift
//
//  Created by LiuLei on 2017/12/31.
//  Copyright © 2017年 LiuLei. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class Initialization: NSObject {
    /// 初始化外观（类方法）
    class func initializationAppearance() {
       
        /// 设置导航栏标题文字样式
        let naviAppearance =  UINavigationBar.appearance()
        naviAppearance.isTranslucent = false
        naviAppearance.titleTextAttributes =  {
            [
                NSAttributedString.Key.foregroundColor: ZLBlackTextColor(),
                NSAttributedString.Key.font: AdaptedCustomBlodFont(size: 16)
            ]
        }()

        /// 设置TabBar样式
        let tabBar = UITabBar.appearance()
        tabBar.backgroundColor = UIColor.white
        tabBar.isTranslucent = false;
        tabBar.shadowImage = UIImage.init(named: "tapbar_top_line")
        tabBar.tintColor = ZLBlackTextColor()
        
        
        /// 初始化SVProgressHUD
        SVProgressHUD.configuration()
        
    }
}
