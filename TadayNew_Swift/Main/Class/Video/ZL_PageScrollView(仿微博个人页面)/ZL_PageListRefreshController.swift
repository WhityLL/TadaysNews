//
//  ZL_PageListRefreshController.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/11/1.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

/// 子控制器刷新 ZL_PageListRefreshController 继承自 ZL_PageListController
/// 重写 preferredSubScrollViewDidScroll/preferredMainTableViewDidScroll方法
/// 子控制器需要添加刷新控件
/// 视情况给子控制器分别加上底部刷新

import UIKit

class ZL_PageListRefreshController: ZL_PageListController {

    var lastScrollingListViewContentOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.bounces = false
    }
    
    override func preferredSubScrollViewDidScroll(_ scrollView: UIScrollView) {
        var shouldProcess: Bool = true
        
        if currentScrollingListView!.contentOffset.y > lastScrollingListViewContentOffsetY {
            //往上滚动
        }else {
            //往下滚动
            if mainTableView.contentOffset.y == 0 {
                shouldProcess = false
            }else {
                if mainTableView.contentOffset.y < mainTableHeaderViewHeight {
                    //mainTableView的header还没有消失，让listScrollView一直为0
                    currentScrollingListView!.contentOffset = CGPoint.zero
                    currentScrollingListView!.showsVerticalScrollIndicator = false
                }
            }
        }
        if (shouldProcess) {
            if mainTableView.contentOffset.y < mainTableHeaderViewHeight {
                //处于下拉刷新的状态，scrollView.contentOffset.y为负数，就重置为0
                if currentScrollingListView!.contentOffset.y > 0 {
                    //mainTableView的header还没有消失，让listScrollView一直为0
                    currentScrollingListView!.contentOffset = CGPoint.zero
                    currentScrollingListView!.showsVerticalScrollIndicator = false
                }
            } else {
                //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
                mainTableView.contentOffset = CGPoint.init(x: 0, y: mainTableHeaderViewHeight);
                currentScrollingListView!.showsVerticalScrollIndicator = true;
            }
        }
        self.lastScrollingListViewContentOffsetY = currentScrollingListView!.contentOffset.y;
        
    }
    
    override func preferredMainTableViewDidScroll(_ scrollView: UIScrollView) {
        if currentScrollingListView != nil && currentScrollingListView!.contentOffset.y > 0 {
            //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
            mainTableView.contentOffset = CGPoint.init(x: 0, y: mainTableHeaderViewHeight)
        }
        
        if scrollView.contentOffset.y < mainTableHeaderViewHeight {
            //mainTableView已经显示了header，listView的contentOffset需要重置
            for subVC: ZL_PageListSubScrollVCDelegate in subViewControllers {
                //正在下拉刷新时，不需要重置
                let scrollView = subVC.getScrollViewOfSubView()
                if scrollView.contentOffset.y > 0 {
                    scrollView.contentOffset = CGPoint.zero
                }
            }
        }
    }
    
    
    override func requestData() {
        sectionHeaderTitles.append(contentsOf: ["AAA","BBB"])
        guard sectionHeaderTitles.count > 0 else {
            sectionHeaderHeight = 0.01
            return
        }
        
        /// sectionHeader
        sectionHeaderView.height = sectionHeaderHeight
        
        segmentView = SGPageTitleView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: sectionHeaderHeight), delegate: self, titleNames: sectionHeaderTitles, configure: SGPageTitleViewConfigure())
        sectionHeaderView.addSubview(segmentView!)
        
        let rowHeight = SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - sectionHeaderHeight
        //        let rowHeight = view.bounds.height - sectionHeaderHeight
        
        let vc1 = ZL_PageListRefreshVC()
        let vc2 = ZL_PageListRefreshVC()
        subViewControllers.append(vc1)
        subViewControllers.append(vc2)
        for obj in subViewControllers {
            obj.getSubView().height = rowHeight
            obj.getScrollViewOfSubView().height = rowHeight
        }
        
        contentView = SGPageContentCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:rowHeight), parentVC: self, childVCs: subViewControllers as! [UIViewController])
        contentView?.delegateCollectionView = self
        
        mainTableView.rowHeight = rowHeight
        mainTableView.reloadData()
        
        /// 子控制器滑动Block监听
        configListViewDidScrollCallback()
    }
    
}
