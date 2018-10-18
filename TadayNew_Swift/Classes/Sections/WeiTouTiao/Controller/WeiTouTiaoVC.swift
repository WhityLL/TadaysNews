//
//  WeiTouTiaoVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class WeiTouTiaoVC: BaseViewController {
    
    /// 导航栏按钮 左边
    private lazy var leftNaviItem : UIBarButtonItem = {
        let leftbutton = crearNaviBtn(title: "找人", imageStr: "icon_invite_24x24_")
        leftbutton.addTarget(self, action: #selector(clickNaviLeft), for: .touchUpInside)
        let leftNaviItem : UIBarButtonItem = UIBarButtonItem.init(customView: leftbutton)
        return leftNaviItem
    }()
    
    private lazy var rightNaviItem : UIBarButtonItem = {
        let rightbutton = crearNaviBtn(title: "发布", imageStr: "short_video_publish_icon_camera_24x24_")
        rightbutton.addTarget(self, action: #selector(clickNaviRight(sender:)), for: .touchUpInside)
        let rightNaviItem : UIBarButtonItem = UIBarButtonItem.init(customView: rightbutton)
        return rightNaviItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = leftNaviItem
        self.navigationItem.rightBarButtonItem = rightNaviItem
        
        requestData()
    }
}


extension WeiTouTiaoVC {
    
    private func requestData() {
        
    }
    
    ///导航栏按钮点击事件
    @objc private func clickNaviLeft() {
        
    }
    
    @objc private func clickNaviRight(sender : UIButton) {
        self.showRelyOn(view: sender)
    }
    
    /// 导航按钮
    private func crearNaviBtn(title: String , imageStr: String) ->UIButton {
        let btn : UIButton = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: imageStr), for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width: 34, height: 34)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.setTitleColor(ZLBlackTextColor(), for: .normal)
        btn.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeCenterImageTop, zl_padding_inset: 1 ,space: 2)
        return btn
    }
}
