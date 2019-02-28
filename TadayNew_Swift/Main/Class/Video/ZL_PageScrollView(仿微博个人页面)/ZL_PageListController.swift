//
//  ZL_PageListController.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/31.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

/// 参考资料 JXPagerViewExample-OC
/// 主控制器 其中 mainTableHeaderView的高度和cell高度需要 计算得出，视情况而定

import UIKit

class ZL_GestureTableView: UITableView,UIGestureRecognizerDelegate {
    /// ⚠️是否同时支持多个手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder())
    }
}

    /// ⚠️子类视图必须实现协议
protocol ZL_PageListSubScrollVCDelegate: NSObjectProtocol {
    /// 返回SubView。如果是vc包裹的就是vc.view；如果是自定义view包裹的，就是自定义view自己。
    func getSubView() -> UIView
    
    /// 返回SubView内部持有的UIScrollView或UITableView或UICollectionView
    func getScrollViewOfSubView() -> UIScrollView
    
    /// callback `scrollViewDidScroll`回调时调用的Closure
    func subScrollViewsisScrollClosure(callBack : @escaping ( _ scrollView: UIScrollView)->())
}

class ZL_PageListController: UIViewController {
    
    /// tableHeaderView
    var mainTableHeaderViewHeight: CGFloat = 200
    lazy var mainTableHeaderView: ZL_PagerListHeaderView = {
        let mainTableHeaderView = ZL_PagerListHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: mainTableHeaderViewHeight))
        mainTableHeaderView.backgroundColor = ZLRandomColor()
        return mainTableHeaderView
    }()
    
    /// sectionHeaderView
    var sectionHeaderTitles = [String]()
    var sectionHeaderHeight: CGFloat = 44
    var sectionHeaderView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
    var segmentView: SGPageTitleView?
    
    /// contentView (VCs)
    var subViewControllers = [ZL_PageListSubScrollVCDelegate]()
    var contentView: SGPageContentCollectionView?
    
    /// 当前正在滚动的子控制器滚动视图
    var currentScrollingListView: UIScrollView?
    
    lazy var mainTableView: ZL_GestureTableView = {
        let mainTableView = ZL_GestureTableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight), style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.estimatedSectionFooterHeight = 0
        mainTableView.estimatedSectionHeaderHeight = 0
        mainTableView.estimatedRowHeight = 0
        mainTableView.tableHeaderView = mainTableHeaderView
        mainTableView.tableFooterView = UIView()
        view.addSubview(mainTableView)
        
        if #available(iOS 11.0, *) {
            mainTableView.contentInsetAdjustmentBehavior = .never;
        }
        
        mainTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ZL_PageListControllerCell")
        return mainTableView
    }()
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZLBgColor()
        
        requestData()
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource,
extension ZL_PageListController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZL_PageListControllerCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        cell.contentView.addSubview(contentView!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ///给外部提供接口
        mainScrollViewDidScroll(scrollView)
        /// 处理滚动逻辑
        preferredMainTableViewDidScroll(scrollView)
    }
    
}

//MARK: - SGPageTitleViewDelegate SGPageContentCollectionViewDelegate
extension ZL_PageListController: SGPageTitleViewDelegate,SGPageContentCollectionViewDelegate{
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        contentView!.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        segmentView!.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }

    /// 以下方法可删除，减小耦合度
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, index: Int) {
        currentScrollingListView = subViewControllers[index].getScrollViewOfSubView()
    }
}

//MARK: - 处理滑动事件
extension ZL_PageListController {
    
    /// 子scrollView 滑动
    @objc func configListViewDidScrollCallback() {
        for obj in subViewControllers {
            obj.subScrollViewsisScrollClosure { (scrollView) in
                self.subScrollViewDidScroll(scrollView)
            }
        }
    }
    
    private func subScrollViewDidScroll(_ scrollView: UIScrollView) {
        currentScrollingListView = scrollView
        preferredSubScrollViewDidScroll(scrollView)
    }
    
    /// 子tableView 滑动子类可以重写
    @objc func preferredSubScrollViewDidScroll(_ scrollView: UIScrollView) {
        if mainTableView.contentOffset.y < mainTableHeaderViewHeight {
            //mainTableView的header还没有消失，让listScrollView一直为0
            scrollView.contentOffset = CGPoint.zero
            scrollView.showsVerticalScrollIndicator = false
        }else{
            //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
            mainTableView.contentOffset = CGPoint.init(x: 0, y: mainTableHeaderViewHeight)
            scrollView.showsVerticalScrollIndicator = true
        }
        
    }
    
    ///给子类重写，
    @objc func mainScrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    /// 主tableView 滑动(子类可以重写)
    @objc func preferredMainTableViewDidScroll(_ scrollView: UIScrollView) {
        if currentScrollingListView != nil && currentScrollingListView!.contentOffset.y > CGFloat(0) {
            //mainTableView的header已经滚动不见，开始滚动某一个listView，
            //那么固定mainTableView的contentOffset，让其不动
            mainTableView.contentOffset = CGPoint.init(x: 0, y: mainTableHeaderViewHeight)
        }
        
        if mainTableView.contentOffset.y < mainTableHeaderViewHeight {
            //mainTableView开始显示了tableHeaderView，所有的listView的contentOffset需要重置
            //重置后都可以下拉
            for obj in subViewControllers {
                obj.getScrollViewOfSubView().contentOffset = CGPoint.zero
            }
        }
        
        if mainTableView.contentOffset.y > mainTableHeaderViewHeight && currentScrollingListView!.contentOffset.y == 0 {
            //当往上滚动mainTableView的headerView时，滚动到底时，修复listView往上小幅度滚动
            mainTableView.contentOffset = CGPoint.init(x: 0, y: mainTableHeaderViewHeight)
        }
    }
}

//MARK: - Network
extension ZL_PageListController{
    @objc func requestData() {
        
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
        
        let vc1 = ZL_PageListSubScrollVC()
        let vc2 = ZL_PageListSubScrollVC()
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
