//
//  VideoVC_VideoNearbyVC_HeaderView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/11.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class VideoVC_VideoNearbyVC_HeaderView: UITableViewHeaderFooterView {

    private lazy var bgView: UIView = {
        let bgView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 90))
        addSubview(bgView)
        bgView.backgroundColor = .white
        return bgView
    }()
    
    private lazy var avatar: UIImageView = {
        let avatar: UIImageView = UIImageView()
        avatar.frame = CGRect.init(x: 15, y: 15, width: 36, height: 36)
        avatar.layer.cornerRadius = 18
        avatar.layer.masksToBounds = true
        bgView.addSubview(avatar)
        return avatar
    }()
    
    private lazy var btn_close: UIButton = {
        let btn_close = UIButton()
        btn_close.setImage(UIImage(named: "add_textpage_17x12_"), for: .normal)
        btn_close.imageView?.contentMode = .scaleAspectFit
        bgView.addSubview(btn_close)
        return btn_close
    }()
    
    private lazy var btn_care: UIButton = {
        let btn_care = UIButton()
        btn_care.setTitle("关注", for: .normal)
        btn_care.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn_care.setTitleColor(ZLGlobalRedColor(), for: .normal)
        btn_care.imageView?.contentMode = .scaleAspectFit
        bgView.addSubview(btn_care)
        return btn_care
    }()
    
    private lazy var lb_nikeName: UILabel = {
        let lb_nikeName: UILabel = UILabel()
        bgView.addSubview(lb_nikeName)
        lb_nikeName.font = UIFont.boldSystemFont(ofSize: 13)
        lb_nikeName.textColor = ZLBlackTextColor()
        return lb_nikeName
    }()
    
    lazy var lb_location: UILabel = {
        let lb_location: UILabel = UILabel()
        bgView.addSubview(lb_location)
        lb_location.font = UIFont.systemFont(ofSize: 12)
        lb_location.textColor = ZLGrayTextColor()
        return lb_location
    }()
    
    lazy var lb_desc: UILabel = {
        let lb_desc: UILabel = UILabel()
        bgView.addSubview(lb_desc)
        lb_desc.font = UIFont.systemFont(ofSize: 15)
        lb_desc.textColor = ZLBlackTextColor()
        lb_desc.numberOfLines = 0
//        lb_desc.backgroundColor = ZLRandomColor()
        return lb_desc
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        btn_close.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.right.equalTo(bgView.snp.right).offset(-15)
            make.top.equalTo(bgView.snp.top).offset(10)
        }
        
        btn_care.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100, height: 30))
            make.right.equalTo(btn_close.snp.right).offset(-10)
            make.centerY.equalTo(btn_close.snp.centerY)
        }

        lb_nikeName.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp.top)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalTo(btn_care.snp.left).offset(-15)
            make.height.equalTo(18)
        }

        lb_location.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatar.snp.bottom)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalTo(btn_care.snp.left).offset(-15)
            make.height.equalTo(18)
        }
        
        lb_desc.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(avatar.snp.bottom).offset(8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ========= Setter ==========
    var video = NewsModel() {
        didSet {
            
            avatar.kf.setImage(with: URL(string: video.raw_data.user.info.avatar_url))
            lb_nikeName.text = video.raw_data.user.info.name
            lb_location.text = video.raw_data.distance
//            lb_desc.text = video.raw_data.title
            
            lb_desc.attributedText = video.raw_data.attrbutedText
        }
    }
    
}
