//
//  ZL_PagerListHeaderView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/24.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_PagerListHeaderView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "wallpaper_profile_night"))
        imageView.clipsToBounds = true
        imageView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: 200)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ZLRandomColor()
        
        addSubview(imageView)
        
        let lb_title = UILabel.init(frame: CGRect.init(x: 10, y: frame.size.height - 30, width: 200, height: 30))
        lb_title.font = UIFont.systemFont(ofSize: 20)
        lb_title.textColor = .red
        lb_title.text = "Whity.Swift"
        addSubview(lb_title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 提供给外界的方法 滚动后放大图片
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        let offsetY = contentOffsetY
        let navigationBarHeight: CGFloat = -kStatusBarAndNavigationBarHeight
        
        if offsetY < navigationBarHeight {
            /// 放大
            let totalOffset = 146 + abs(offsetY)
            let f = totalOffset / 146
            imageView.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
        }
    }
    
}
