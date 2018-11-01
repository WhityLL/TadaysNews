//
//  ZL_VideoListVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/29.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_VideoListVC: UIViewController {

    let urls = [URL(string: "https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"),
    URL(string: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"),
    URL(string: "https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"),
    URL(string: "https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"),
    URL(string: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"),
    URL(string: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4")]
    
    lazy var tableView: UITableView = {
        let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        tableView.register(UINib.init(nibName: "Live_VideoCell", bundle: nil), forCellReuseIdentifier: "Live_VideoCell")

        return tableView
    }()
    
    lazy var controlView : ZFPlayerControlView = {
        let controlView = ZFPlayerControlView()
        controlView.fastViewAnimated = true
        return controlView
    }()
    
    var player: ZFPlayerController = ZFPlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    
        let playerManager: ZFAVPlayerManager = ZFAVPlayerManager()
        player = ZFPlayerController.player(with: tableView, playerManager: playerManager, containerViewTag: 2001)
        player.shouldAutoPlay = false
        player.playerDisapperaPercent = 1.0
        player.controlView = controlView
        player.isWWANAutoPlay = false
        player.assetURLs = urls as? [URL]

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let y: CGFloat = 0
        let h: CGFloat = view.height
        tableView.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
    }
 
}

extension ZL_VideoListVC{
 
}

extension ZL_VideoListVC: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : Live_VideoCell = tableView.dequeueReusableCell(withIdentifier: "Live_VideoCell") as! Live_VideoCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * 0.71
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 0.01}
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ZL_VideoListVC{
    override var shouldAutorotate: Bool{
        return player.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if player.isFullScreen && player.orientationObserver.fullScreenMode == .landscape {
            return .landscape
        }
        return .portrait
    }
    
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidEndDecelerating()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.zf_scrollViewDidEndDraggingWillDecelerate(decelerate)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScrollToTop()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScroll()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewWillBeginDragging()
    }
}
