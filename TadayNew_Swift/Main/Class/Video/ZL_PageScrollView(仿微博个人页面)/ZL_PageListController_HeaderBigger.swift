//
//  ZL_PageListController_HeaderBigger.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/11/1.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

/// 放大头部视图

import UIKit

class ZL_PageListController_HeaderBigger: ZL_PageListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 其中146 mainTableHeaderView里的值
        
        mainTableHeaderView.imageView.frame = CGRect.init(x: 0, y: -kStatusBarAndNavigationBarHeight, width: SCREEN_WIDTH, height: 146+kStatusBarAndNavigationBarHeight)
        mainTableView.tableHeaderView = nil
        mainTableView.tableHeaderView = mainTableHeaderView
        
    }
    
    override func mainScrollViewDidScroll(_ scrollView: UIScrollView) {
        
        mainTableHeaderView.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
        
    }
    
}
