//
//  ProfileHeaderView.swift
//  TodayNew_Swift
//
//  Created by LiuLei on 2016/12/27.
//  Copyright © 2016年 LiuLei. All rights reserved.
//

import UIKit
import SVProgressHUD
import SnapKit

let iconWH:CGFloat = 70.0

protocol ProfileHeaderViewDelegate:NSObjectProtocol {
    
    /// 手机号登录按钮点击
    func noLoginHeaderView(headerView: ProfileHeaderView, mobileLoginButtonClick: UIButton)
    /// 微信登录按钮点击
    func noLoginHeaderView(headerView: ProfileHeaderView, wechatLoginButtonClick: UIButton)
    /// QQ 登录按钮点击
    func noLoginHeaderView(headerView: ProfileHeaderView, qqLoginButtonClick: UIButton)
    /// 微博登录按钮点击
    func noLoginHeaderView(headerView: ProfileHeaderView, weiboLoginButtonClick: UIButton)
    /// 更多登录方式按钮点击
    func noLoginHeaderView(headerView: ProfileHeaderView, moreLoginButtonClick: UIButton)
}

class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    /// 懒加载，创建背景图片
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kZLMineHeaderImageHeight))
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.image = UIImage(named: "wallpaper_profile_night")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView =  UIStackView.init(frame: CGRect.init(x: 40, y: 70, width: SCREEN_WIDTH - 80, height: 80))
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = ZLRandomColor()
        return stackView
    }()
    
    /// 手机号登录按钮
    private lazy var mobileLoginButton: UIButton = {
        let mobileButton = UIButton()
        mobileButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        mobileButton.setImage(UIImage(named: "cellphoneicon_login_profile_66x66_"), for: .normal)
        mobileButton.addTarget(self, action: #selector(mobileLoginButtonClick), for: .touchUpInside)
        mobileButton.imageView?.contentMode = .scaleAspectFit
        return mobileButton
    }()
    
    /// 微信登录按钮
    private lazy var wechatLoginButton: UIButton = {
        let wechatLoginButton = UIButton()
        wechatLoginButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        wechatLoginButton.setImage(UIImage(named: "weixinicon_login_profile_66x66_"), for: .normal)
        wechatLoginButton.addTarget(self, action: #selector(wechatLoginButtonClick), for: .touchUpInside)
        wechatLoginButton.imageView?.contentMode = .scaleAspectFit
        return wechatLoginButton
    }()
    
    /// QQ 登录按钮
    private lazy var qqLoginButton: UIButton = {
        let qqLoginButton = UIButton()
        qqLoginButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        qqLoginButton.setImage(UIImage(named: "qqicon_login_profile_66x66_"), for: .normal)
        qqLoginButton.addTarget(self, action: #selector(qqLoginButtonClick), for: .touchUpInside)
        qqLoginButton.imageView?.contentMode = .scaleAspectFit
        return qqLoginButton
    }()
    
    /// 微博登录按钮
    private lazy var weiboLoginButton: UIButton = {
        let weiboLoginButton = UIButton()
        weiboLoginButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        weiboLoginButton.setImage(UIImage(named: "sinaicon_login_profile_66x66_"), for: .normal)
        weiboLoginButton.addTarget(self, action: #selector(weiboLoginButtonClick), for: .touchUpInside)
        weiboLoginButton.imageView?.contentMode = .scaleAspectFit
        return weiboLoginButton
    }()
    
    /// 创建 更多登录方式按钮
    private lazy var moreLoginButton: UIButton = {
        let moreLoginButton = UIButton()
        moreLoginButton.setTitle(" 更多登录方式 >", for: .normal)
        moreLoginButton.setTitleColor(UIColor.white, for: .normal)
        moreLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        moreLoginButton.backgroundColor = RGBAColor(r: 170, g: 170, b: 170, a: 0.6)
        moreLoginButton.layer.cornerRadius = 15
        moreLoginButton.layer.masksToBounds = true
        moreLoginButton.addTarget(self, action: #selector(moreLoginButtonClick), for: .touchUpInside)
        return moreLoginButton
    }()
    
    /// 懒加载，创建底部白色 view
    lazy var bottomView: ProfileHeaderBottomView = {
        let bottomView = ProfileHeaderBottomView.init(frame: CGRect.init(x: 0, y: bgImageView.bottom, width: SCREEN_WIDTH, height: self.height - kZLMineHeaderImageHeight))
        return bottomView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.orange
        
        setupUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileHeaderView {
    
    private func setupUI() {
        
        // 添加背景图片
        addSubview(bgImageView)
        
        addSubview(stackView)
        
        // 添加四个按钮
        stackView.addArrangedSubview(mobileLoginButton)
        stackView.addArrangedSubview(wechatLoginButton)
        stackView.addArrangedSubview(qqLoginButton)
        stackView.addArrangedSubview(weiboLoginButton)
        
        // 添加更多登录按钮
        addSubview(moreLoginButton)
        
        // 添加底部 view
        addSubview(bottomView)
        
        moreLoginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.width.equalTo(150)
        }
        
    }
    
    /// 手机号登录按钮点击
    @objc func mobileLoginButtonClick(button: UIButton) {
        delegate?.noLoginHeaderView(headerView: self, mobileLoginButtonClick: button)
    }
    
    /// 微信登录按钮点击
    @objc func wechatLoginButtonClick(button: UIButton) {
        delegate?.noLoginHeaderView(headerView: self, wechatLoginButtonClick: button)
    }
    
    /// QQ 登录按钮点击
    @objc func qqLoginButtonClick(button: UIButton) {
        delegate?.noLoginHeaderView(headerView: self, qqLoginButtonClick: button)
    }
    
    /// 微博登录按钮点击
    @objc func weiboLoginButtonClick(button: UIButton) {
        delegate?.noLoginHeaderView(headerView: self, weiboLoginButtonClick: button)
    }
    
    /// 更多登录方式按钮点击
    @objc func moreLoginButtonClick(button: UIButton) {
        delegate?.noLoginHeaderView(headerView: self, moreLoginButtonClick: button)
    }
}
