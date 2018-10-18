//
//  UserChannelCell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/14.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

protocol UserSelctedChannelCellDelegate : class {
    func deleteChannelButtonClicked(of cell: UserChannelCell)
}

class UserChannelCell: UICollectionViewCell {

    weak var delegate: UserSelctedChannelCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = RGBAColor(r: 245, g: 245, b: 245, a: 1)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        
        btn_title.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn_title.setTitleColor(ZLBlackTextColor(), for: .normal)
        btn_title.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    // 编辑状态
    var isEdit = false {
        didSet {
            btn_delete.isHidden = !isEdit || isFixed
        }
    }
    
    // 固定 不可编辑
    var isFixed = false {
        didSet {
            btn_delete.isHidden = !isEdit || isFixed
            if (isFixed) {
                btn_title.setTitleColor(ZLGrayTextColor(), for: .normal)
            }else{
                btn_title.setTitleColor(ZLBlackTextColor(), for: .normal)
            }
        }
    }
    
    
    @IBOutlet weak var btn_title: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    
    @IBAction func btn_deleteClick(_ sender: Any) {
        delegate?.deleteChannelButtonClicked(of: self)
    }
    
    @IBAction func btn_titleClick(_ sender: Any) {
        
    }
}
