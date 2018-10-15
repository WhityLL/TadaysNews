//
//  ProfileHeaderBottomView.swift
//  TodayNew_Swift
//
//  Created by LiuLei on 2016/12/27.
//  Copyright © 2016年 LiuLei. All rights reserved.
//

import UIKit

class ProfileHeaderBottomView: UIView {

    /// 收藏按钮回调
    var collectionButtonClosure: ((_ collectionButton: UIButton) -> ())?
    /// 夜间按钮回调
    var nightButtonClosure: ((_ nightButton: UIButton) -> ())?
    /// 设置按钮回调
    var settingButtonClosure: ((_ settingButton: UIButton) -> ())?
    
    /// 懒加载，创建收藏按钮
    private lazy var collectionButton: UIButton = {
        let collectionButton = UIButton.init(type: .custom)
        collectionButton.setTitle("收藏", for: .normal)
        collectionButton.setTitleColor(UIColor.black, for: .normal)
        collectionButton.addTarget(self, action: #selector(collectionBtnClick), for: .touchUpInside)
        collectionButton.setImage(UIImage(named: "favoriteicon_profile_24x24_"), for: .normal)
        collectionButton.tag = 10101;
        collectionButton.setImage(UIImage(named: "favoriteicon_profile_press_24x24_"), for: .highlighted)
        collectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return collectionButton
    }()
    
    /// 懒加载，创建夜间按钮
    private lazy var nightButton: UIButton = {
        let nightButton = UIButton.init(type: .custom)
        nightButton.setTitle("历史", for: .normal)
        nightButton.setTitleColor(UIColor.black, for: .normal)
        nightButton.addTarget(self, action: #selector(nightBtnClick), for: .touchUpInside)
        nightButton.setImage(UIImage(named: "history_profile_24x24_"), for: .normal)
        nightButton.setImage(UIImage(named: "history_profile_press_24x24_"), for: .highlighted)
        nightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return nightButton
    }()
    
    /// 懒加载，创建设置按钮
    private lazy var settingButton: UIButton = {
        let settingButton = UIButton.init(type: .custom)
        settingButton.setTitle("夜间", for: .normal)
        settingButton.setTitleColor(UIColor.black, for: .normal)
        settingButton.setImage(UIImage(named: "nighticon_profile_24x24_"), for: .normal)
        settingButton.setImage(UIImage(named: "nighticon_profile_press_24x24_"), for: .highlighted)
        settingButton.addTarget(self, action: #selector(settingBtnClick), for: .touchUpInside)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return settingButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionButton.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeCenterImageTop, zl_padding_inset: 1)
        nightButton.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeCenterImageTop, zl_padding_inset: 1)
        settingButton.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeCenterImageTop, zl_padding_inset: 1)
    }

}

extension ProfileHeaderBottomView {
    
    private func setupUI() {
        
        // 添加收藏按钮
        addSubview(collectionButton)
        // 添加夜间按钮
        addSubview(nightButton)
        // 添加设置按钮
        addSubview(settingButton)
        
        collectionButton.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(30)
        }
        
        nightButton.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.top.bottom.equalTo(self)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        settingButton.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-30)
        }
    }
    
    // MARK: 按钮点击事件
    @objc func collectionBtnClick(button: UIButton) {
        collectionButtonClosure?(button)
    }
    
    @objc func nightBtnClick(button: UIButton) {
        nightButtonClosure?(button)
    }
    
    @objc func settingBtnClick(button: UIButton) {
        settingButtonClosure?(button)
    }
    
}
