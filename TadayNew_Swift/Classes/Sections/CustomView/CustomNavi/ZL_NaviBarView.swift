//
//  ZL_NaviBarView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/9.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_NaviBarView: UIView {
    
    var didClickCameraBtn: ((_ sender: UIButton)->())?
    var didClickSearchBtn: (()->())?
    
    private lazy var searchBtn : UIButton = {
        let searchBtn : UIButton = UIButton.init(type: .custom)
        searchBtn.backgroundColor = UIColor.white
        searchBtn.setImage(UIImage.init(named: "search_small_16x16_"), for: .normal)
        searchBtn.addTarget(self, action: #selector(searchBtnClicked), for: .touchUpInside)
        searchBtn.setTitle("搜索内容", for: .normal)
        searchBtn.setTitleColor(ZLGrayTextColor(), for: .normal)
        searchBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        searchBtn.titleLabel?.textColor = ZLBlackTextColor()
        searchBtn.contentHorizontalAlignment = .left
        searchBtn.contentVerticalAlignment = .center
        searchBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        searchBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 0)
        searchBtn.layer.cornerRadius = 6;
        
        return searchBtn
    }()
    
    private lazy var cameraBtn : UIButton = {
        let cameraBtn : UIButton = UIButton.init(type: .custom)
        cameraBtn.setImage(UIImage.init(named: "home_camera"), for: .normal)
        cameraBtn.setTitle("发布", for: .normal)
        cameraBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        cameraBtn.addTarget(self, action: #selector(cameraBtnClicked), for: .touchUpInside)
        return cameraBtn
    }()
    
    override var intrinsicContentSize: CGSize{
        return UIView.layoutFittingExpandedSize
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))

        setupSubView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cameraBtn.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeCenterImageTop, zl_padding_inset: 1 ,space: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZL_NaviBarView {
    
    private func setupSubView() {
        addSubview(searchBtn)
        addSubview(cameraBtn)

//        searchBtn.frame = CGRect.init(x: 5, y: 5, width: SCREEN_WIDTH - 60, height: 34)
//        cameraBtn.frame = CGRect.init(x: searchBtn.frame.maxX + 5, y: 7, width: 30, height: 30)
        
        cameraBtn.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
        }

        searchBtn.snp.makeConstraints { (make) in
            make.height.equalTo(34)
            make.left.equalTo(self.snp.left).offset(5)
            make.centerY.equalTo(self)
            make.right.equalTo(cameraBtn.snp.left).offset(-10)
        }
    }
    
    @objc func cameraBtnClicked(sender : UIButton) {
        didClickCameraBtn?(sender)
    }
    
    @objc func searchBtnClicked(sender : UIButton) {
        didClickSearchBtn?()
    }
    
}
