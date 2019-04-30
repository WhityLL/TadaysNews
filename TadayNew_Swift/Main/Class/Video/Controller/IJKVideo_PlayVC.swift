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
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.pause()
        player.stop()
        player.shutdown()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZLBgColor()
        fd_prefersNavigationBarHidden = true
        
        firstFrameImageView.kf.setImage(with: URL(string: liveData.raw_data.first_frame_image_list.first!.urlString)!)
        
        creatPlayer()
        
        // 根据后台数据修改尺寸
        view.insertSubview(player.view, aboveSubview: firstFrameImageView)
        
        view.bringSubviewToFront(btn_back)
    }
    
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
        firstFrameImageView.frame = UIScreen.main.bounds
        view.addSubview(firstFrameImageView)
        return firstFrameImageView
    }()
    
    deinit {
        print("释放了")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension IJKVideo_PlayVC {
    @objc func back_closeClick() {
        if self.presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    func creatPlayer() {
        
        //1、视频源地址
        let url = liveData.raw_data.video.play_addr.url_list.first
        
        //2、初始化播放器，播放在线视频或直播（RTMP）
        //IJKFFMoviePlayerController：专门用来v播放视频
        player = IJKAVMoviePlayerController.init(contentURLString: url)
        player.view.frame = view.bounds
        player.scalingMode = .aspectFit  //缩放模式
        player.shouldAutoplay = true     //开启自动播放
        
        //3、播放页面视图宽高自适应
        let autoresize = UIView.AutoresizingMask.flexibleWidth.rawValue |
            UIView.AutoresizingMask.flexibleHeight.rawValue
        player.view.autoresizingMask = UIView.AutoresizingMask(rawValue: autoresize)
        player.scalingMode = .aspectFill
        self.view.autoresizesSubviews = true
        
        player.prepareToPlay()
    }
    //TODO：监听卡顿
    //评论 控制层
}
