//
//  LiveVC_VideoListVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/11.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

/// 西瓜视频——页面

import UIKit

class LiveVC_VideoListVC: BaseViewController {

    var categary : NewsTitleCategory = .recommend
    
    /// 数据
    var dataArr = [Any]()
    /// 刷新时间
    var maxBehotTime: TimeInterval = Date().timeIntervalSince1970
    /// TTFrom
    var ttfrom: TTFrom = .enterAuto
    /// listCount
    var listCount : Int = 20
    
    private lazy var tableView: UITableView = {
        let tableView : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - kTabbarHeight - 36), style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        tableView.register(UINib.init(nibName: "Live_VideoCell", bundle: nil), forCellReuseIdentifier: "Live_VideoCell")
        
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresh()
    
    }

}

extension LiveVC_VideoListVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : Live_VideoCell = tableView.dequeueReusableCell(withIdentifier: "Live_VideoCell") as! Live_VideoCell
        
        if self.categary == .subv_video_live_toutiao {
            cell.liveData = self.dataArr[indexPath.section] as! LiveModel
        }else{
            cell.video = self.dataArr[indexPath.section] as! NewsModel
        }
        
        cell.playBtnClickClosure = {
            if self.categary == .subv_video_live_toutiao {
                self.togoIJKLiveVC(indexPath: indexPath)
            }else{
                self.togoPlayVideoVC(indexPath: indexPath)
            }
        }
        
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
    
}


extension LiveVC_VideoListVC {
    
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
        
        if self.categary == .subv_video_live_toutiao {
            
            NetManager.loadApiLiveFeeds(category: self.categary, ttFrom: self.ttfrom, maxBehotTime: self.maxBehotTime, listCount: self.listCount) { liveModelList in
                
                if self.tableView.mj_header.isRefreshing {self.tableView.endHeaderRefresh()}
                if self.tableView.mj_footer.isRefreshing {self.tableView.endFooterRefresh()}
                
                if (self.ttfrom == TTFrom.pull || self.ttfrom == TTFrom.enterAuto) { self.dataArr.removeAll() }
                
                self.dataArr.append(contentsOf: liveModelList)
                
                self.listCount = self.dataArr.count > 0 ? self.dataArr.count : 20
                
                self.tableView.reloadData()
                
                if liveModelList.count == 0 {
                    self.tableView.noticeNoMoreData()
                }
            }
            
        }else{
            
            NetManager.loadApiNewsFeeds(apiFrom: .live, category: self.categary, ttFrom: self.ttfrom, maxBehotTime: self.maxBehotTime, listCount: self.listCount) { (aNewsModelList) in
                
                if self.tableView.mj_header.isRefreshing {self.tableView.endHeaderRefresh()}
                if self.tableView.mj_footer.isRefreshing {self.tableView.endFooterRefresh()}
                
                if (self.ttfrom == TTFrom.pull || self.ttfrom == TTFrom.enterAuto) { self.dataArr.removeAll() }
                
                self.dataArr.append(contentsOf: aNewsModelList)
                
                self.listCount = self.dataArr.count > 0 ? self.dataArr.count : 20
                
                self.tableView.reloadData()
                
                if aNewsModelList.count == 0 {
                    self.tableView.noticeNoMoreData()
                }
            }
        }
    }
    
    
    func togoIJKLiveVC(indexPath: IndexPath) {
        let liveData = self.dataArr[indexPath.section] as! LiveModel
        
        var ijkLiveVC : IJKLiveBaseVC
        if liveData.raw_data.live_info.orientation == 0 { //秀场直播
            
            ijkLiveVC =  IJKLiveVC_Show()
            ijkLiveVC.liveData = liveData
            self.present(ZL_NaviVC.init(rootViewController: ijkLiveVC), animated: true, completion: nil)
            
        }else{
            
            ijkLiveVC =  IJKLiveVC_Room()
            ijkLiveVC.liveData = liveData
            self.navigationController?.pushViewController(ijkLiveVC, animated: true)
        
        }
    }
    
    func togoPlayVideoVC(indexPath: IndexPath) {
//        let videoModel = self.dataArr[indexPath.section] as! NewsModel
       
    }
    
}
