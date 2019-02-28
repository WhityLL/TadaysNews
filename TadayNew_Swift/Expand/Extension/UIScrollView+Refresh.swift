//
//  UIScrollView+Refresh.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/10.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

extension UIScrollView {
    
    func addHeaderGifRefresh(refreshBlock: @escaping MJRefreshComponentRefreshingBlock) {
        let zl_haader: ZL_RefreshHeader = ZL_RefreshHeader.init(refreshingBlock: refreshBlock)
        zl_haader.mj_h = 60
        
        // 图片数组
        var images = [UIImage]()
        for index in 0..<16 {
            let image = UIImage(named: "dropdown_loading_0\(index)")
            images.append(image!)
        }
        
        zl_haader.setImages(images, for: .idle)        // 设置空闲状态的图片
        zl_haader.setImages(images, for: .refreshing)  // 设置刷新状态的图片
        
        zl_haader.setTitle("下拉推荐", for: .idle)
        zl_haader.setTitle("松开推荐", for: .pulling)
        zl_haader.setTitle("推荐中", for: .refreshing)
        zl_haader.setTitle("", for: .willRefresh)
        
        /// 设置一些属性
        zl_haader.isAutomaticallyChangeAlpha = true
        zl_haader.lastUpdatedTimeLabel.isHidden = true
        
        self.mj_header = zl_haader
    }
    
    func addHeaderGifRefreshWithIgnoreHeight(refreshBlock: @escaping MJRefreshComponentRefreshingBlock) {
        let zl_haader: ZL_RefreshHeader = ZL_RefreshHeader.init(refreshingBlock: refreshBlock)
        zl_haader.ignoredScrollViewContentInsetTop = 150;
        zl_haader.mj_h = 60
        
        
        // 图片数组
        var images = [UIImage]()
        for index in 0..<16 {
            let image = UIImage(named: "dropdown_loading_0\(index)")
            images.append(image!)
        }
        
        zl_haader.setImages(images, for: .idle)        // 设置空闲状态的图片
        zl_haader.setImages(images, for: .refreshing)  // 设置刷新状态的图片
        
        zl_haader.setTitle("下拉推荐", for: .idle)
        zl_haader.setTitle("松开推荐", for: .pulling)
        zl_haader.setTitle("推荐中", for: .refreshing)
        zl_haader.setTitle("", for: .willRefresh)
        
        /// 设置一些属性
        zl_haader.isAutomaticallyChangeAlpha = true
        zl_haader.lastUpdatedTimeLabel.isHidden = true
        
        self.mj_header = zl_haader
    }
    
    func addFooterGifRefresh(refreshBlock: @escaping MJRefreshComponentRefreshingBlock) {
        let zl_footer: ZL_RefreshFooter = ZL_RefreshFooter.init(refreshingBlock: refreshBlock)
        // 设置控件的高度
        zl_footer.mj_h = 50;
        
        // 图片数组
        var images = [UIImage]()
        for index in 0..<8 {
            let image = UIImage(named: "sendloading_18x18_\(index)")
            images.append(image!)
        }
        zl_footer.setImages(images, for: .idle)        // 设置空闲状态的图片
        zl_footer.setImages(images, for: .refreshing)  // 设置刷新状态的图片
        
        zl_footer.setTitle("上拉加载数据", for: .idle)
        zl_footer.setTitle("正在努力加载", for: .pulling)
        zl_footer.setTitle("正在努力加载", for: .refreshing)
        zl_footer.setTitle("没有更多数据啦", for: .noMoreData)
        
        self.mj_footer = zl_footer
    }
    
    func beginHeaderRefresh() {
        self.mj_header.beginRefreshing()
    }
    
    func endHeaderRefresh() {
        self.mj_header.endRefreshing()
    }
    
    func beginFooterRefresh() {
        self.mj_footer.beginRefreshing()
    }
    
    func endFooterRefresh() {
        self.mj_footer.endRefreshing()
    }
    
    func noticeNoMoreData() {
        self.mj_footer.endRefreshingWithNoMoreData()
    }
    
    func resetNoMoreData() {
        self.mj_footer.resetNoMoreData()
    }
}

// MARK: - ========= 自定义RefreshHeader ==========
class ZL_RefreshHeader: MJRefreshGifHeader {
    
    /// 重新布局 必须覆写父类方法
    override func placeSubviews() {
        super.placeSubviews()
        
        gifView.frame = CGRect(x: 0, y: 5, width: mj_w, height: 30)
        gifView.contentMode = .center
        gifView.centerX = self.centerX
        
        stateLabel.font = UIFont.systemFont(ofSize: 10)
        stateLabel.frame = CGRect(x: 0, y: 35, width: mj_w, height: 25)
    }
    
    
}

// MARK: - ========= 自定义RefreshFooter ==========
class ZL_RefreshFooter: MJRefreshBackGifFooter {
    
    /// 重新布局 必须覆写父类方法
    override func placeSubviews() {
        super.placeSubviews()
        
        stateLabel.font = UIFont.systemFont(ofSize: 12)
        stateLabel.centerX = self.centerX - 25
        gifView.x = 100
        gifView.centerY = stateLabel.centerY
    }
}
