//
//  IJKLive_Show_UserInfoView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/13.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class IJKLive_Show_UserInfoView: UIView {
    
    private lazy var btn_avatar: UIButton = {
        let btn_avatar = UIButton()
        btn_avatar.addTarget(self, action: #selector(btn_avatarClick), for: .touchUpInside)
        btn_avatar.backgroundColor = ZLRandomColor()
        btn_avatar.frame = CGRect.init(x: 0, y: 0, width: 36, height: 36)
        btn_avatar.layer.cornerRadius = 18
        btn_avatar.layer.masksToBounds = true
        addSubview(btn_avatar)
        return btn_avatar
    }()
    
    private lazy var lb_nikeName: UILabel = {
        let lb_nikeName: UILabel = UILabel.init(frame: CGRect.init(x: btn_avatar.right + 5, y: btn_avatar.top, width: self.width - btn_avatar.width - 10, height: 18))
        addSubview(lb_nikeName)
        lb_nikeName.font = UIFont.boldSystemFont(ofSize: 13)
        lb_nikeName.textColor = ZLBlackTextColor()
        return lb_nikeName
    }()
    
    lazy var lb_renqi: UILabel = {
        let lb_renqi: UILabel = UILabel.init(frame: CGRect.init(x: btn_avatar.right + 5, y: lb_nikeName.bottom, width: self.width - btn_avatar.width - 10, height: 18))
        addSubview(lb_renqi)
        lb_renqi.font = UIFont.systemFont(ofSize: 12)
        lb_renqi.textColor = ZLGrayTextColor()
        return lb_renqi
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        btn_avatar.top = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btn_avatarClick() {
        print("text------")
    }
    
    var liveData = LiveModel() {
        didSet {
            
            btn_avatar.kf.setImage(with: URL(string: liveData.raw_data.user_info.avatar_url), for: .normal)
            lb_nikeName.text = liveData.raw_data.user_info.name
            lb_renqi.text = liveData.raw_data.live_info.watching_count_str
            
        }
    }
}
