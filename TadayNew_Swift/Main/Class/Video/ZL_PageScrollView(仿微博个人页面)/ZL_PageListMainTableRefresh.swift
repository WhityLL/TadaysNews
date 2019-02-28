//
//  ZL_PageListMainTableRefresh.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/11/1.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

/// 主控制器刷新 ZL_PageListMainTableRefresh 继承自 ZL_PageListController
/// 直接添加刷新空间即可
/// 视情况给子控制器分别加上底部刷新

import UIKit
import MJRefresh

class ZL_PageListMainTableRefresh: ZL_PageListController {

    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            print("-=-=-=-=-=-")
            self.mainTableView.endHeaderRefresh()
        })
    }
}
