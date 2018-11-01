//
//  WeiTouTiaoVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeiTouTiaoVC: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var categary : NewsTitleCategory = .weitoutiao
    
    /// 数据
    var dataArr = [Any]()
    /// 刷新时间
    var maxBehotTime: TimeInterval = Date().timeIntervalSince1970
    /// TTFrom
    var ttfrom: TTFrom = .enterAuto
    /// listCount
    var listCount : Int = 20
    
    /// 导航栏按钮 左边
    private lazy var leftNaviItem : UIBarButtonItem = {
        let leftbutton = crearNaviBtn(title: "找人", imageStr: "icon_invite_24x24_")
        leftbutton.addTarget(self, action: #selector(clickNaviLeft), for: .touchUpInside)
        let leftNaviItem : UIBarButtonItem = UIBarButtonItem.init(customView: leftbutton)
        return leftNaviItem
    }()
    
    private lazy var rightNaviItem : UIBarButtonItem = {
        let rightbutton = crearNaviBtn(title: "发布", imageStr: "short_video_publish_icon_camera_24x24_")
        rightbutton.addTarget(self, action: #selector(clickNaviRight(sender:)), for: .touchUpInside)
        let rightNaviItem : UIBarButtonItem = UIBarButtonItem.init(customView: rightbutton)
        return rightNaviItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = leftNaviItem
        self.navigationItem.rightBarButtonItem = rightNaviItem
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
        tableView.zl_registerCell(cell: WeiTouTiaoCell.self)
        tableView.separatorStyle = .none
        
        setupRefresh()
    }
    
    ///导航栏按钮点击事件
    @objc private func clickNaviLeft() {
        
    }
    
    @objc private func clickNaviRight(sender : UIButton) {
        self.showRelyOn(view: sender)
    }
    
    /// 导航按钮
    private func crearNaviBtn(title: String , imageStr: String) ->UIButton {
        let btn : UIButton = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: imageStr), for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width: 34, height: 34)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.setTitleColor(ZLBlackTextColor(), for: .normal)
        btn.setBtn(zl_BtnlayoutType: UIButton.ZL_ButtonLayoutType.ZL_ButtonLayoutTypeCenterImageTop, zl_padding_inset: 1 ,space: 2)
        return btn
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension WeiTouTiaoVC {
    
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
            
            self.listCount = self.dataArr.count > 0 ? self.dataArr.count : 20
            
            self.tableView.reloadData()
            
            if aNewsModelList.count == 0 {
                self.tableView.noticeNoMoreData()
            }
        }
        
    }
}

extension WeiTouTiaoVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aNews: NewsModel = dataArr[indexPath.row] as! NewsModel
        return aNews.weitoutiaoHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : WeiTouTiaoCell = tableView.dequeueReusableCell(withIdentifier: "WeiTouTiaoCell", for: indexPath) as! WeiTouTiaoCell
        
        cell.aNews = dataArr[indexPath.row] as! NewsModel

        /// 点击了
        cell.didSelectSubImageViewCellClasure = { (selectedIndex: Int) in
            
            let vc = PreviewImageViewVC()
            vc.selectedIndex = selectedIndex
            vc.images = cell.aNews.large_image_list
            self.present(vc, animated: false, completion: nil)
        }
        
        cell.btn_corver.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {
            print("=-=-=-=-=-=-=-=-")
        }).disposed(by: disposeBag)
        
        return cell
    }
}
