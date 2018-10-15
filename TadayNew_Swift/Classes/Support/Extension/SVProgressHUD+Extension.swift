//
//  SVProgressHUD+Extension.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/9.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    /// 设置 SVProgressHUD 属性
    static func configuration() {
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setBackgroundColor(RGBAColor(r: 0, g: 0, b: 0, a: 0.3))
    }
}
