//
//  UserSelectedChannelHeaderView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/14.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class UserSelectedChannelHeaderView: UICollectionReusableView {

    var editBtnClickClosure: ((_ sender: UIButton) -> ())?
    
    private lazy var lb_title: UILabel = {
        let lb_title = UILabel()
        addSubview(lb_title)
        lb_title.text = "我的频道"
        lb_title.textColor = ZLBlackTextColor()
        lb_title.font = AdaptedCustomBlodFont(size: 16)
        return lb_title
    }()
    
    private lazy var lb_desc: UILabel = {
        let lb_desc = UILabel()
        addSubview(lb_desc)
        lb_desc.text = "点击进入频道"
        lb_desc.textColor = ZLGrayTextColor()
        lb_desc.font = UIFont.systemFont(ofSize: 14)
        return lb_desc
    }()
    
    private lazy var btn_edit: UIButton = {
        let btn_edit = UIButton()
        btn_edit.setTitle("编辑", for: .normal)
        btn_edit.setTitle("完成", for: .selected)
        btn_edit.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn_edit.setTitleColor(ZLGlobalRedColor(), for: .normal)
        btn_edit.imageView?.contentMode = .scaleAspectFit
        addSubview(btn_edit)
        btn_edit.addTarget(self, action: #selector(btn_editClick(sender:)), for: .touchUpInside)
        return btn_edit
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView() {
        lb_title.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.bottom.equalTo(0)
        }
        
        lb_desc.snp.makeConstraints { (make) in
            make.left.equalTo(lb_title.snp.right).offset(10)
            make.top.bottom.equalTo(0)
        }
        
        btn_edit.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        }
    }
    
    @objc func btn_editClick(sender : UIButton) {
        sender.isSelected = !sender.isSelected
        isEdit = sender.isSelected
        lb_desc.text = sender.isSelected ? "拖拽可以排序" : "点击进入频道"
        editBtnClickClosure?(sender)
    }
    
    
    var isEdit = false {
        didSet {
            btn_edit.isSelected = isEdit
            lb_desc.text = isEdit ? "拖拽可以排序" : "点击进入频道"
        }
    }
}
