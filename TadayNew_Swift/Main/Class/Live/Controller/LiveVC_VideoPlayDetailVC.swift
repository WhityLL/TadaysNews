//
//  LiveVC_VideoPlayDetailVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/26.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

let kVideoCover: String = "https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"

class LiveVC_VideoPlayDetailVC: UIViewController {

    var videoUrl: String = ""
    
    private let assetURLs = [URL(string: "https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"),
                     URL(string: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"),
                     URL(string: "https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"),
                     URL(string: "https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"),
                     URL(string: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"),
                     URL(string: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4")]
    
    private lazy var controlView : ZFPlayerControlView = {
        let controlView = ZFPlayerControlView()
        controlView.fastViewAnimated = true
        return controlView
    }()
    
    private lazy var player: ZFPlayerController = {
        let playerManager: ZFAVPlayerManager = ZFAVPlayerManager()
        let player: ZFPlayerController = ZFPlayerController.init(playerManager: playerManager, containerView: containerView)
        player.pauseWhenAppResignActive = false
        player.controlView = controlView
        return player
    }()
    
    private lazy var containerView: UIImageView = {
        let containerView = UIImageView()
        containerView.setImageWithURLString(kVideoCover, placeholder: ZFUtilities.image(with: UIColor.init(red: 220/255.0, green: 220/255, blue: 220/255, alpha: 1), size: CGSize.init(width: 1, height: 1)))
        return containerView
    }()
    
    private lazy var playBtn: UIButton = {
        let playBtn = UIButton.init(type: .custom)
        playBtn.setImage(UIImage(named: "ugc_video_list_play_32x32_"), for: .normal)
        playBtn.addTarget(self, action: #selector(playClick(sender:)), for: .touchUpInside)
        playBtn.backgroundColor = ZLRandomColor()
        return playBtn
    }()
    
    private lazy var changeBtn: UIButton = {
        let changeBtn = UIButton.init(type: .custom)
        changeBtn.setTitle("Change", for: .normal)
        changeBtn.addTarget(self, action: #selector(changeClick(sender:)), for: .touchUpInside)
        changeBtn.backgroundColor = ZLRandomColor()
        return changeBtn
    }()
    
    private lazy var nextBtn: UIButton = {
        let nextBtn = UIButton.init(type: .custom)
        nextBtn.setTitle("NEXT", for: .normal)
        nextBtn.addTarget(self, action: #selector(nextClick(sender:)), for: .touchUpInside)
        nextBtn.backgroundColor = ZLRandomColor()
        return nextBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(playBtn)
        view.addSubview(changeBtn)
        view.addSubview(nextBtn)
        player.assetURL = URL.init(string: videoUrl)!
//        player.assetURLs = assetURLs as? [URL]
    }
    
}

extension LiveVC_VideoPlayDetailVC{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if player.isFullScreen {
            return .lightContent
        }
        return .default
    }
    
    override var prefersStatusBarHidden: Bool{
        return player.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    
    override var shouldAutorotate: Bool{
        return player.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if player.isFullScreen {
            return .landscape
        }
        return .portrait
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = self.view.frame.size.width
        var h: CGFloat = w*9/16
        self.containerView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        w = 44;
        h = w;
        x = (self.containerView.width - w) / 2
        y = (self.containerView.height - h) / 2
        self.playBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        w = 100;
        h = 30;
        x = (self.view.frame.width-w)/2;
        y = self.containerView.bottom+50;
        self.changeBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        w = 100;
        h = 30;
        x = (self.view.frame.width-w)/2;
        y = self.changeBtn.bottom+50;
        self.nextBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
    }
}

extension LiveVC_VideoPlayDetailVC{
    
    //开始
    @objc func playClick(sender: UIButton) {
        player.playTheIndex(0)
        self.controlView.showTitle("标题", cover: UIImage(), fullScreenMode: .landscape)
    }
    
    @objc func nextClick(sender: UIButton) {
        player.playTheNext()
        if !player.isLastAssetURL {
            let title = "视频标题" + String(player.currentPlayIndex)
            controlView.showTitle(title, coverURLString:kVideoCover , fullScreenMode: .landscape)
        }else{
            print("最后一个视频了")
        }
    }
    
    @objc func changeClick(sender: UIButton) {
        let urlStr: String = "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"
        
        player.assetURL = URL(string: videoUrl)!
        
        controlView.showTitle("Apple", coverURLString:kVideoCover , fullScreenMode: .portrait)
    }
    
}
