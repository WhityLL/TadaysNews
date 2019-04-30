//
//  VideoVC_VideoNearbyVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/10.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class VideoVC_VideoNearbyVC: BaseViewController {
    
    var player: ZFPlayerController?
    
    var categary : NewsTitleCategory = .recommend
    
    /// 数据
    var dataArr = [Any]()
    var urls = [URL]()
    var dataSource = [ZFTableViewCellLayout]()
    /// 刷新时间
    var maxBehotTime: TimeInterval = Date().timeIntervalSince1970
    /// TTFrom
    var ttfrom: TTFrom = .enterAuto
    /// listCount
    var listCount : Int = 20
    
    private lazy var tableView: UITableView = {
        let tableView : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - kTabbarHeight), style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        tableView.register(UINib.init(nibName: "VideoVC_VideoNearbyCell", bundle: nil), forCellReuseIdentifier: "VideoVC_VideoNearbyCell")
        tableView.register(VideoVC_VideoNearbyVC_HeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: "VideoVC_VideoNearbyVC_HeaderView")
        
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var controlView: ZFPlayerControlView = {
        let controlView: ZFPlayerControlView = ZFPlayerControlView()
        controlView.fastViewAnimated = true
        controlView.horizontalPanShowControlView = false
        controlView.prepareShowLoading = true
        return controlView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresh()
        
        setupPlayer()
    }
    
    
    func setupPlayer() {
        let playerManager = ZFAVPlayerManager()
        player = ZFPlayerController.init(scrollView: self.tableView, playerManager: playerManager, containerViewTag: 100)
        player?.controlView = self.controlView
        player?.assetURLs = self.urls
        player?.playerDisapperaPercent = 0.8;
        player?.isWWANAutoPlay = true;
        
    }
}

extension VideoVC_VideoNearbyVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : VideoVC_VideoNearbyCell = tableView.dequeueReusableCell(withIdentifier: "VideoVC_VideoNearbyCell") as! VideoVC_VideoNearbyCell

        cell.video = self.dataArr[indexPath.section] as! NewsModel
        
        cell.setDelegate(delegate: self, indexPath: indexPath as NSIndexPath)
        
        cell.playCallback = {
            self.play(indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH*1.05 + 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let video = self.dataArr[section] as! NewsModel
        
        var headerH : CGFloat = 0
        if video.raw_data.title.count > 0 {
            headerH = Calculate.textHeight(text: video.raw_data.title, fontSize: 15, width: (SCREEN_WIDTH - 30)) + 8
        }
        return 15 + 36 + 8 + headerH
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == dataArr.count - 1 {return 0.01}
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header : VideoVC_VideoNearbyVC_HeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "VideoVC_VideoNearbyVC_HeaderView") as! VideoVC_VideoNearbyVC_HeaderView
        
        let video = self.dataArr[section] as! NewsModel
        header.video = video
        
        var headerH : CGFloat = 0
        if video.raw_data.title.count > 0 {
            headerH = Calculate.textHeight(text: video.raw_data.title, fontSize: 15, width: (SCREEN_WIDTH - 30)) + 8
        }
        
        header.height = 15 + 36 + 8 + headerH
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension VideoVC_VideoNearbyVC {

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

extension VideoVC_VideoNearbyVC {
    
    private func setupRefresh() {
        tableView.addHeaderGifRefresh {
            self.ttfrom = .pull
            self.maxBehotTime = Date().timeIntervalSince1970
            self.tableView.resetNoMoreData()
            self.requestData()
        }
        
        tableView.addFooterGifRefresh {
            self.ttfrom = .loadMore
            self.requestData()
        }
        
        tableView.beginHeaderRefresh()
    }
    
    private func requestData() {
        
        NetManager.loadApiNewsFeeds(apiFrom: .smallVideo, category: self.categary, ttFrom: self.ttfrom, maxBehotTime: self.maxBehotTime, listCount: self.listCount) { (aNewsModelList) in
            
            if self.tableView.mj_header.isRefreshing {self.tableView.endHeaderRefresh()}
            if self.tableView.mj_footer.isRefreshing {self.tableView.endFooterRefresh()}
            
            if (self.ttfrom == TTFrom.pull || self.ttfrom == TTFrom.enterAuto) { self.dataArr.removeAll() }
            
            self.dataArr.append(contentsOf: aNewsModelList)
            
            self.formatUrls()
            
            self.listCount = self.dataArr.count > 0 ? self.dataArr.count : 20
            
            self.tableView.reloadData()
            
            if aNewsModelList.count == 0 {
                self.tableView.noticeNoMoreData()
            }
        }
        
    }
    
    func formatUrls() {
        for item in self.dataArr {
            let videoModel = item as! NewsModel
            let url = videoModel.raw_data.first_frame_image_list.first!.urlString
            
            let tableData = ZFTableData.init();
            let layout = ZFTableViewCellLayout.init(data: tableData)
            dataSource.append(layout!)
            urls.append(URL.init(string: url)!)
        }
    }
    
    func playTheVideoAtIndexPath(indexPath: IndexPath , scrollToTop: Bool) {
        self.player?.playTheIndexPath(indexPath, scrollToTop: scrollToTop)
        let layout = self.dataSource[indexPath.row]
        
        controlView.showTitle(layout.data.title, coverURLString:layout.data.thumbnail_url, fullScreenMode: ZFFullScreenMode(rawValue: 0)!)
    }
    
    
    func play(indexPath: IndexPath) {
        if player?.playingIndexPath == indexPath {
            player?.stopCurrentPlayingCell()
        }
        
        if !(player?.currentPlayerManager.isPlaying)! {
            self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
        }
        
    }
    
}

extension VideoVC_VideoNearbyVC : ZL_PlayVideoTableViewCellDelegate{
    func zl_playTheVideoAtIndexPath(indexPath: IndexPath) {
        self.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
    }
}
