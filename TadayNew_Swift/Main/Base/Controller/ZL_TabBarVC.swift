//
//  ZL_TabBarVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子控制器
        addChildViewControllers()
        
    }
    
    // MARK: ========= 添加子控制器 ==========
    private func addChildViewControllers() {
        setChildViewController(HomeVC(), title: "首页", imageName: "home")
        setChildViewController(LiveVC(), title: "西瓜视频", imageName: "video")
        setChildViewController(WeiTouTiaoVC(), title: "微头条", imageName: "weitoutiao")
        setChildViewController(VideoVC(), title: "小视频", imageName: "huoshan")
        setChildViewController(ProfileVC(), title: "我的", imageName: "no_login")
    }
    
    /// 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        // 设置 tabbar 文字和图片
        setDayChildController(controller: childController, imageName: imageName)
        
        childController.title = title
        
        // 添加导航控制器为 TabBarController 的子控制器
        addChild(ZL_NaviVC.init(rootViewController: childController))
    }
    
    private func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
}
