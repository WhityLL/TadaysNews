//
//  ZL_PageListRefreshVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/11/1.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import MJRefresh

class ZL_PageListRefreshVC: ZL_PageListSubScrollVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            print("-=-=-=-=-=-")
            self.tableView.endHeaderRefresh()
        })
        
    }

}
