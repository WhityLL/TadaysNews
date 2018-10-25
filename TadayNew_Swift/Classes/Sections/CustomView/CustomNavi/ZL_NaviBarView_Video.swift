//
//  ZL_NaviBarView_Video.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/9.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_NaviBarView_Video: UIView {

    var didClickCameraBtn: (()->())?
    
    /// 点击了 标题
    var pageTitleViewSelected: ((_ index: Int)->())?
    
    var pageTitleView: SGPageTitleView?
    
    private lazy var cameraBtn : UIButton = {
        let cameraBtn = crearNaviBtn(title: "发布", imageStr: "icon_video_titlebar_28x28_")
        cameraBtn.addTarget(self, action: #selector(cameraBtnClicked), for: .touchUpInside)
        return cameraBtn
    }()
    
    /// 导航按钮
    private func crearNaviBtn(title: String , imageStr: String) ->UIButton {
        let btn : UIButton = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: imageStr), for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width: 60, height: 34)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(ZLBlackTextColor(), for: .normal)
        btn.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeNormal, zl_padding_inset: 1 ,space: 2)
        return btn
    }
    
    private lazy var pageView : UIView = {
        let pageView : UIView = UIView()
        pageView.clipsToBounds = true
        return pageView
    }()
    
    override var intrinsicContentSize: CGSize{
        return UIView.layoutFittingExpandedSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleNames = [String]() {
        didSet {
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = ZLBlackTextColor()
            configuration.titleSelectedColor = ZLGlobalRedColor()
            configuration.titleFont = AdaptedCustomBlodFont(size: 14)
            configuration.titleTextZoom = true
            configuration.indicatorColor = .clear
            configuration.needBounces = false
            configuration.showBottomSeparator = false
            configuration.titleAdditionalWidth = 1
            
            pageTitleView = SGPageTitleView(frame: CGRect(x: -5, y: 0, width: pageView.width, height: pageView.height), delegate: self, titleNames: titleNames, configure: configuration)
            pageTitleView!.backgroundColor = .clear
            pageTitleView!.index = 1
            
            pageView.addSubview(pageTitleView!)
        }
    }

}

extension ZL_NaviBarView_Video {
    
    private func setupSubViews() {
        addSubview(cameraBtn)
        addSubview(pageView)
        
        cameraBtn.snp.makeConstraints { (make) in
            make.width.equalTo(66)
            make.height.equalTo(34)
            make.right.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        pageView.snp.makeConstraints { (make) in
            make.height.equalTo(34)
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.right.equalTo(cameraBtn.snp.left).offset(-50)
        }
    }
    
    @objc func cameraBtnClicked() {
        didClickCameraBtn?()
    }
    
}

extension ZL_NaviBarView_Video: SGPageTitleViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageTitleViewSelected?(index)
    }
}
