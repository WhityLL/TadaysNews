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
         self.backgroundColor = UIColor.white
        
        btn_recommendTitle.titleLabel?.adjustsFontSizeToFitWidth = true
        btn_recommendTitle.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeNormal, zl_padding_inset: 1, space: 4)
        
        btn_recommendTitle.setTitleColor(ZLBlackTextColor(), for: .normal)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = RGBAColor(r: 240, g: 240, b: 240, a: 1).cgColor
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = ZLRandomColor().cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)        //shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 1                                 //阴影透明度，默认0
        self.layer.shadowRadius = 1                                  //阴影半径，默认3
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        btn_recommendTitle.isEnabled = false
        
    }
    @IBOutlet weak var btn_recommendTitle: UIButton!
    
    @IBAction func btn_recommendTitleClick(_ sender: Any) {
        
    }
    
}
