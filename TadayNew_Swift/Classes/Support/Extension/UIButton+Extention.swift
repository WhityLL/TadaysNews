//
//  UIButton+Extention.swift
//  Paihuo_Swift
//
//  Created by LiuLei on 2018/3/9.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    /**
     button 的样式，以图片为基准
     
     - ZL_ButtonLayoutTypeNormal: button 默认样式：内容居中-图左文右
     - ZL_ButtonLayoutTypeCenterImageRight: 内容居中-图右文左
     - ZL_ButtonLayoutTypeCenterImageTop: 内容居中-图上文下
     - ZL_ButtonLayoutTypeCenterImageBottom: 内容居中-图下文上
     - ZL_ButtonLayoutTypeLeftImageLeft: 内容居左-图左文右
     - ZL_ButtonLayoutTypeLeftImageRight: 内容居左-图右文左
     - ZL_ButtonLayoutTypeRightImageLeft: 内容居右-图左文右
     - ZL_ButtonLayoutTypeRightImageRight: 内容居右-图右文左
     */
    enum ZL_ButtonLayoutType : Int {
        case ZL_ButtonLayoutTypeNormal
        case ZL_ButtonLayoutTypeCenterImageRight
        case ZL_ButtonLayoutTypeCenterImageTop
        case ZL_ButtonLayoutTypeCenterImageBottom
        case ZL_ButtonLayoutTypeLeftImageLeft
        case ZL_ButtonLayoutTypeLeftImageRight
        case ZL_ButtonLayoutTypeRightImageLeft
        case ZL_ButtonLayoutTypeRightImageRight
    }
    
    /// 设置按钮样式
    ///
    /// - Parameters:
    ///   - zl_BtnlayoutType: 按钮样式
    ///   - zl_padding_inset: 按钮上下左右的间距
    ///   - space: 图片文字的间距 (可选参数)
    func setBtn(zl_BtnlayoutType : ZL_ButtonLayoutType , zl_padding_inset : CGFloat , space : CGFloat? = nil) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleStr = self.titleLabel?.text ?? ""
        let titleFont = self.titleLabel?.font!
        let titleSize = titleStr.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var imageEdge: UIEdgeInsets = UIEdgeInsets.zero
        var titleEdge: UIEdgeInsets = UIEdgeInsets.zero
        
        //按钮文字图片的间距
        let zl_padding : CGFloat = (space != nil) ? space! : 5
        
        switch zl_BtnlayoutType {
        case .ZL_ButtonLayoutTypeNormal:
            titleEdge = UIEdgeInsets(top: 0, left: zl_padding, bottom: 0, right: 0);
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: zl_padding);
        
        case .ZL_ButtonLayoutTypeCenterImageRight:
            titleEdge = UIEdgeInsets(top: 0, left: -imageSize.width - zl_padding, bottom: 0, right: imageSize.width);
            imageEdge = UIEdgeInsets(top: 0, left: titleSize.width + zl_padding, bottom: 0, right: -titleSize.width);
        
        case .ZL_ButtonLayoutTypeCenterImageTop:
            titleEdge = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - zl_padding, right: 0);
            imageEdge = UIEdgeInsets(top: -titleSize.height - zl_padding, left: 0, bottom: 0, right: -titleSize.width);
        
        case .ZL_ButtonLayoutTypeCenterImageBottom:
            titleEdge = UIEdgeInsets(top: -imageSize.height - zl_padding, left: -imageSize.width, bottom: 0, right: 0);
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: -titleSize.height - zl_padding, right: -titleSize.width);
        
        case .ZL_ButtonLayoutTypeLeftImageLeft:
            titleEdge = UIEdgeInsets(top: 0, left: zl_padding + zl_padding_inset, bottom: 0, right: 0);
            imageEdge = UIEdgeInsets(top: 0, left: zl_padding_inset, bottom: 0, right: 0);
            self.contentHorizontalAlignment = .left;
            
        case .ZL_ButtonLayoutTypeLeftImageRight:
            titleEdge = UIEdgeInsets(top: 0, left: -imageSize.width + zl_padding_inset, bottom: 0, right: 0);
            imageEdge = UIEdgeInsets(top: 0, left: titleSize.width + zl_padding + zl_padding_inset, bottom: 0, right: 0);
            self.contentHorizontalAlignment = .left;
            
        case .ZL_ButtonLayoutTypeRightImageLeft:
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: zl_padding + zl_padding_inset);
            titleEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: zl_padding_inset);
            self.contentHorizontalAlignment = .right;
            
        case .ZL_ButtonLayoutTypeRightImageRight:
            titleEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageSize.width + zl_padding + zl_padding_inset);
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width + zl_padding_inset);
            self.contentHorizontalAlignment = .right;
        }
        
        self.imageEdgeInsets = imageEdge;
        self.titleEdgeInsets = titleEdge;
    }
    
    
}
