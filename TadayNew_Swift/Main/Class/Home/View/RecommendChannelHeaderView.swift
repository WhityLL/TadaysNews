//
//  RecommendChannelHeaderView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/14.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class RecommendChannelHeaderView: UICollectionReusableView {
    lazy var lb_title: UILabel = {
        let lb_title = UILabel()
        addSubview(lb_title)
        lb_title.text = "频道推荐"
        lb_title.textColor = ZLBlackTextColor()
        lb_title.font = AdaptedCustomBlodFont(size: 16)
        return lb_title
    }()
    
    lazy var lb_desc: UILabel = {
        let lb_desc = UILabel()
        addSubview(lb_desc)
        lb_desc.text = "点击添加频道"
        lb_desc.textColor = ZLGrayTextColor()
        lb_desc.font = UIFont.systemFont(ofSize: 14)
        return lb_desc
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
    }
}
