//
//  ZL_UserCareDetail_HeaderView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/31.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_UserCareDetail_HeaderView: UIView ,NibLoadable{
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: scrollTableHeaderViewHeight)
    }
    
}
