//
//  LoginVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 登录页面
        self.title = "登录"
        // commit 1
        // commit 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.presentingViewController != nil){
            dismiss(animated: false, completion: nil)
        }else{
            navigationController?.popViewController(animated: false)
        }
    }

}
