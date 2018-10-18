//
//  ZL_EdgeInsetsLabel.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/18.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_EdgeInsetsLabel: UILabel {

    var edgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0) {
        didSet{
            
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = edgeInsets
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
    
    // 文字区域
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
        
    }
}
