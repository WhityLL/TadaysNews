//
//  PulishVideoVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/10.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class PulishVideoVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "拍摄视频"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

}
