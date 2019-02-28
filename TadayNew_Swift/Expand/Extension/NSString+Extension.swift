//
//  NSString+Extension.swift
//  TodaysNews_Swift4
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import Foundation
import UIKit

extension NSString{
    
    /// 获取字符串size
    class func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        return CGSize.zero
    }
    
    /// 获取字符串 width
    ///
    /// - Parameters:
    ///   - str: 字符串 （可选）
    ///   - attriStr: 富文本 （可选）
    ///   - font: 字体大小
    ///   - h: 限制高度
    /// - Returns: CGFloat
    class func getNormalStrWidth(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, h: CGFloat) -> CGFloat {
        return NSString.getNormalStrSize(str: str, attriStr: attriStr, font: font, w: CGFloat(MAXFLOAT), h: h).width
    }
    
    /// 获取字符串 height
    ///
    /// - Parameters:
    ///   - str: 字符串 （可选）
    ///   - attriStr: 富文本 （可选）
    ///   - font: 字体大小
    ///   - w: 限制宽度
    /// - Returns: CGFloat
    class func getNormalStrHeight(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat) -> CGFloat {
        return NSString.getNormalStrSize(str: str, attriStr: attriStr, font: font, w: w, h: CGFloat(MAXFLOAT)).height
    }
    
}

/**
 样例
 func getNormalStrH(str: String, strFont: CGFloat, w: CGFloat) -> CGFloat {
    return NSString.getNormalStrSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
 }
 
 */
