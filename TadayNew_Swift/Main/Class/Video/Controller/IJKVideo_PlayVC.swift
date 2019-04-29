//
//  IJKVideo_PlayVC.swift
//  TadayNew_Swift
//
//  Created by lishe on 2019/4/29.
//  Copyright © 2019 LiuLei. All rights reserved.
//

import UIKit
import IJKMediaFramework

class IJKVideo_PlayVC: UIViewController {

    var liveData = NewsModel()
    
    var player: IJKAVMoviePlayerController = IJKAVMoviePlayerController()
    
    lazy var btn_back: UIButton = {
        let btn_back = UIButton()
        view.addSubview(btn_back)
        btn_back.addTarget(self, action: #selector(back_closeClick), for: .touchUpInside)
        btn_back.setImage(UIImage(named: "personal_home_back_white_24x24_"), for: .normal)
        btn_back.frame = CGRect.init(x: 15, y: kStatusBarHeight, width: 30, height: 30)
        btn_back.backgroundColor = ZLRandomColor()
        return btn_back
    }()
    
    lazy var firstFrameImageView: UIImageView = {
        let firstFrameImageView: UIImageView = UIImageView.init()
        firstFrameImageView.contentMode = .scaleAspectFill
        view.addSubview(firstFrameImageView)
        return firstFrameImageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZLBgColor()
        fd_prefersNavigationBarHidden = true
        
        firstFrameImageView.kf.setImage(with: URL(string: liveData.raw_data.first_frame_image_list.first!.urlString)!)
        firstFrameImageView.frame = UIScreen.main.bounds
        
        creatPlayer()
        
        // 根据后台数据修改尺寸
        player.view.frame = firstFrameImageView.bounds
        view.insertSubview(player.view, aboveSubview: firstFrameImageView)
        
        view.bringSubviewToFront(btn_back)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.pause()
        player.stop()
        player.shutdown()
    }
    
    deinit {
        print("释放了")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension IJKVideo_PlayVC {
    
    func creatPlayer() {
        
        //视频源地址
        let url = liveData.raw_data.video.play_addr.url_list.first
        
        //初始化播放器，播放在线视频或直播（RTMP）
        //IJKFFMoviePlayerController：专门用来直播
        player = IJKAVMoviePlayerController.init(contentURLString: url)
        
        player.scalingMode = .aspectFit //缩放模式
        player.shouldAutoplay = true   //开启自动播放
        //播放页面视图宽高自适应
        let autoresize = UIView.AutoresizingMask.flexibleWidth.rawValue |
            UIView.AutoresizingMask.flexibleHeight.rawValue
        player.view.autoresizingMask = UIView.AutoresizingMask(rawValue: autoresize)
        self.view.autoresizesSubviews = true
        
        player.prepareToPlay()
    }
    
    @objc func back_closeClick() {
        if self.presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
}
