//
//  BaseViewController.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var navibarButtonItemClickClosure : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZLBgColor()

        setupNavigationItem()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.hidesBackButton = true
    }
}

extension BaseViewController {
    
    private func setupNavigationItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            setLeftNavigationItemWith(image: "lefterbackicon_titlebar_24x24_") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setLeftNavigationItemWith(image: String , touchBlock: @escaping ()->()) {
        self.navibarButtonItemClickClosure = touchBlock
        
        let btn = UIButton.init(type: .custom)
        btn.addTarget(self, action: #selector(naviBackClick), for: .touchUpInside)
        btn.setImage(UIImage.init(named: image), for: .normal)
        btn.sizeToFit()
        
        if btn.bounds.size.width < 35 {
            let width = 35 / btn.bounds.size.height * btn.bounds.size.width
            btn.bounds = CGRect.init(x: 0, y: 0, width: width, height: 35)
        }
        if btn.bounds.size.height > 35 {
            let height = 35 / btn.bounds.size.width * btn.bounds.size.height
            btn.bounds = CGRect.init(x: 0, y: 0, width: 35, height: height)
        }
        btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -15, bottom: 0, right: 0)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)

    }
    
    /// 返回按钮点击事件，子类可以覆写
    @objc func naviBackClick() {
        if self.navibarButtonItemClickClosure != nil {
            self.navibarButtonItemClickClosure?()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
