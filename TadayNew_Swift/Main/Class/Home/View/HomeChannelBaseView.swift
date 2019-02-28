//
//  HomeChannelBaseView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/11/29.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class HomeChannelBaseView: UIScrollView,UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // 在这里
        // gestureRecognizer 即是主要的滚动视图
        // otherGestureRecognizer 为gestureRecognizer的子视图
        let view = gestureRecognizer.view as! HomeChannelView
        // 正在移动时候 不能同时响应
        if view.isEditting {
            return false
        }
        
        return true
    }
    
}
