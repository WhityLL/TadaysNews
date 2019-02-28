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
        self.title = "登录"
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.presentingViewController != nil){
            dismiss(animated: false, completion: nil)
        }else{
            navigationController?.popViewController(animated: false)
        }
    }

}
