//
//  ZL_NotificationPopVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/30.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_NotificationPopVC: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalTransitionStyle = .crossDissolve
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = .overFullScreen
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
}
