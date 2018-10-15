//
//  ZLSettingCell.swift
//  TodayNew_Swift
//
//  Created by LiuLei on 2016/12/30.
//  Copyright © 2016年 LiuLei. All rights reserved.
//

import UIKit

class ZLSettingCell: UITableViewCell {

    
    var setting: ZLSettingModel! {
        didSet {
            lb_title.text = setting.title
            lb_subTitle.text = setting.subtitle
            lb_rightTitle.text = setting.rightTitle
            img_arraw.isHidden = setting.isHiddenArraw!
            witchView.isHidden = setting.isHiddenSwitch!
//            line.isHidden = setting.isHiddenLine!
            lb_rightTitle.isHidden = setting.isHiddenRightTitle!
            if (setting.subtitle?.characters.count)! > 0 {
                titleConstrait.constant = -kMargin
            }
        }
    }
    
    
    @IBOutlet weak var titleConstrait: NSLayoutConstraint!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_subTitle: UILabel!
    @IBOutlet weak var lb_rightTitle: UILabel!
    @IBOutlet weak var img_arraw: UIImageView!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var witchView: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
