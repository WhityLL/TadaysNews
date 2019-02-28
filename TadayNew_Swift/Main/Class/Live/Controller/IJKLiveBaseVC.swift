//
//  IJKLiveBaseVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/12.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import IJKMediaFramework

class IJKLiveBaseVC: BaseViewController {

    var liveData = LiveModel()
    
    var player: IJKFFMoviePlayerController = IJKFFMoviePlayerController()
    
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
        
        firstFrameImageView.kf.setImage(with: URL(string: liveData.raw_data.large_image.urlString)!)
        
        creatPlayer()
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

extension IJKLiveBaseVC {
    
    func creatPlayer() {
        
        let options = IJKFFOptions.byDefault()
        
        //视频源地址
        let url = liveData.raw_data.live_info.stream_url.flv_pull_url
        
        //初始化播放器，播放在线视频或直播（RTMP）
        //IJKFFMoviePlayerController：专门用来直播
        player = IJKFFMoviePlayerController(contentURL: URL.init(string: url), with: options)
        
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
