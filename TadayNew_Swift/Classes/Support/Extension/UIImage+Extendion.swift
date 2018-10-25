//
//  UIImage+Extendion.swift
//  TodaysNews_Swift4
//
//  Created by LiuLei on 2017/12/19.
//  Copyright © 2017年 LiuLei. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func creatImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
