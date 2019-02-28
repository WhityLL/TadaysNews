//
//  IJKLiveVC_Room.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/12.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class IJKLiveVC_Room: IJKLiveBaseVC {

    lazy var btn_back: UIButton = {
        let btn_back = UIButton()
        view.addSubview(btn_back)
        btn_back.addTarget(self, action: #selector(back_closeClick), for: .touchUpInside)
        return btn_back
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubView()
    }
    
}

extension IJKLiveVC_Room {
    
    func setupSubView() {
        
        btn_back.setImage(UIImage(named: "personal_home_back_white_24x24_"), for: .normal)
        btn_back.frame = CGRect.init(x: 15, y: kStatusBarHeight, width: 30, height: 30)
        btn_back.backgroundColor = ZLRandomColor()
        
        firstFrameImageView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: (SCREEN_WIDTH * 9) / 16.0 + 1)
        
        player.view.frame = firstFrameImageView.bounds
        
        view.insertSubview(player.view, aboveSubview: firstFrameImageView)
        
        view.bringSubviewToFront(btn_back)
    }
    
}
