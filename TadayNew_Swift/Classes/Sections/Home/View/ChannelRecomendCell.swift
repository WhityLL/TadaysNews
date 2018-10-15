//
//  ChannelRecomendCell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/14.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ChannelRecomendCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btn_recommendTitle.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        btn_recommendTitle.sizeToFit()
        
        btn_recommendTitle.setTitleColor(ZLBlackTextColor(), for: .normal)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = RGBAColor(r: 240, g: 240, b: 240, a: 1).cgColor
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor.white
        
        btn_recommendTitle.layer.shadowColor = RGBAColor(r: 240, g: 240, b: 240 ,a: 1).cgColor
        btn_recommendTitle.layer.shadowOffset = CGSize(width: 0, height: 0)        //shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
        btn_recommendTitle.layer.shadowOpacity = 1                                 //阴影透明度，默认0
        btn_recommendTitle.layer.shadowRadius = 1                                  //阴影半径，默认3
        btn_recommendTitle.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        btn_recommendTitle.isEnabled = false
        
    }
    @IBOutlet weak var btn_recommendTitle: UIButton!
    
    @IBAction func btn_recommendTitleClick(_ sender: Any) {
    }
    
}
