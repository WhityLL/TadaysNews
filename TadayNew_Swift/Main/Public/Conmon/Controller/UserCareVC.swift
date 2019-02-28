//
//  UserCareVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/10.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

/// 关注

import UIKit

class UserCareVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let lb = UILabel.init(frame: CGRect.init(x: 50, y: 100, width: 100, height: 30))
        view.addSubview(lb)
        lb.text = "关注"
        lb.textAlignment = .center
        lb.textColor = ZLGlobalRedColor()
        lb.font = AdaptedCustomBlodFont(size: 20);
        lb.centerX = view.centerX
        
    }
    
}
