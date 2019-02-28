//
//  ZL_UserCareDetail_Navi.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/31.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_UserCareDetail_Navi: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(naviBar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var naviBar: UIView = {
        let naviBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kNavigationBarHeight))
        naviBar.backgroundColor = .clear
        return naviBar
    }()
    
}
