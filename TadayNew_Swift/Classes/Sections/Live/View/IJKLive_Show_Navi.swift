//
//  IJKLive_Show_Navi.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/12.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class IJKLive_Show_Navi: UIView {

    var closeClosure: (() -> ())?
    
    private lazy var bgView: UIView = {
        let bgView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kStatusBarAndNavigationBarHeight))
        addSubview(bgView)
        bgView.backgroundColor = UIColor.clear
        return bgView
    }()
    
    private lazy var btn_back: UIButton = {
        let btn_back = UIButton()
        btn_back.addTarget(self, action: #selector(back_closeClick), for: .touchUpInside)
        btn_back.setBackgroundImage(UIImage(named: "closeicon_repost_18x18_"), for: .normal)
        btn_back.frame = CGRect.init(x: SCREEN_WIDTH - 30 - 15, y: kStatusBarHeight, width: 30, height: 30)
        return btn_back
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addGradientLayer()
        
        bgView.addSubview(btn_back)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension IJKLive_Show_Navi {
    
    @objc func back_closeClick() {
        closeClosure?()
    }
    
    func addGradientLayer() {
        
        let topColor = UIColor.init(white: 0, alpha: 0.3)
        let midColor = UIColor.init(white: 0, alpha: 0.15)
        let buttomColor = UIColor.init(white: 0, alpha: 0)
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,midColor.cgColor, buttomColor.cgColor] //定义渐变的颜色（从黄色渐变到橙色）
        gradientLayer.locations = [0.0,0.5,1.0]   //定义每种颜色所在的位置
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: bgView.height)
        bgView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
