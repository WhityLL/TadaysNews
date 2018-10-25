//
//  ZL_PagerListMainView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/24.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

/// 子类视图必须实现的协议
protocol ZL_PagerListSubScrollViewDelegate: NSObjectProtocol {
    /// 返回SubView。如果是vc包裹的就是vc.view；如果是自定义view包裹的，就是自定义view自己。
    func getSubView() -> UIView
    
    /// 返回SubView内部持有的UIScrollView或UITableView或UICollectionView
    func getScrollViewOfSubView() -> UIScrollView
    
    /// callback `scrollViewDidScroll`回调时调用的Closure
    func subScrollViewsisScrollClosure(callBack : @escaping ( _ scrollView: UIScrollView)->())
}

/// ZL_PagerListMainView的数据源协议
protocol ZL_PagerListMainViewDelegate: NSObjectProtocol {
    
    func tableHeaderViewHeightInPagerListMainView() -> CGFloat
    
    func tableHeaderViewInPagerListMainView() -> UIView
    
    func heightForSectionHeaderViewInPagerListMainView() -> CGFloat
    
    func sectionHeaderViewInPagerListMainView() -> SGPageTitleView
    
    func listVCInPagerListMainView() -> [ZL_PagerListSubScrollViewDelegate]
    
}


class ZL_PagerListMainView: UIView {
    
    /// 主tscrollView 滚动了
    var mainTableViewDidScrollClosure:(() -> ())?
    /// 数据源代理
    weak var delegateOfMainView : ZL_PagerListMainViewDelegate?
    /// 父控制器
    var parentVC: UIViewController = UIViewController()
    /// segmentView 选项卡
    var segmentView: SGPageTitleView?
    
    /// 当前的滚动视图
    var currentScrollingListView: UIScrollView?
    
    lazy var mainTableView: ZL_PagerListGestureTableView = {
        let mainTableView = ZL_PagerListGestureTableView.init(frame: CGRect.zero, style: .plain)
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.separatorStyle = .none
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableHeaderView = self.delegateOfMainView?.tableHeaderViewInPagerListMainView()
        mainTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        
        if #available(iOS 11.0, *) {
            mainTableView.contentInsetAdjustmentBehavior = .never;
        }
        return mainTableView
    }()
    
    
    lazy var contentView: SGPageContentCollectionView = {
        /// 处理子控制器的大小
        let listVC: Array = self.delegateOfMainView!.listVCInPagerListMainView()
        for obj in listVC {
            obj.getSubView().height = frame.size.height - delegateOfMainView!.heightForSectionHeaderViewInPagerListMainView()
        }
        
        let contentView: SGPageContentCollectionView = SGPageContentCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height - delegateOfMainView!.heightForSectionHeaderViewInPagerListMainView()), parentVC: parentVC, childVCs: delegateOfMainView!.listVCInPagerListMainView() as! [UIViewController])
        contentView.delegateCollectionView = self
        contentView.mainTableView = self.mainTableView
        return contentView
    }()
    
    
    init(frame: CGRect, delegate: ZL_PagerListMainViewDelegate) {
        super.init(frame: frame)
        delegateOfMainView = delegate

        addSubview(mainTableView)
        
        configListViewDidScrollCallback()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainTableView.frame = bounds
    }
}

//MARK: -  UITableViewDelegate,UITableViewDataSource （主tableView 数据源方法）
extension ZL_PagerListMainView: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.selectionStyle = .none
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        cell.contentView.addSubview(contentView)
        contentView.layoutSubviews()
        contentView.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return bounds.size.height - delegateOfMainView!.heightForSectionHeaderViewInPagerListMainView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegateOfMainView?.heightForSectionHeaderViewInPagerListMainView() ?? 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        segmentView = delegateOfMainView?.sectionHeaderViewInPagerListMainView()
        return segmentView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: -  滚动事件处理
extension ZL_PagerListMainView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.mainTableViewDidScrollClosure?()
        
        preferredProcessMainTableViewDidScroll(scrollView)
    }
}

extension ZL_PagerListMainView{
    
    func configListViewDidScrollCallback() {
        let listVC: Array = self.delegateOfMainView!.listVCInPagerListMainView()
        
        for obj: ZL_PagerListSubScrollViewDelegate in listVC {
            obj.subScrollViewsisScrollClosure { (scrollView) in
                self.subScrollViewDidScroll(scrollView)
            }
        }
    }
    
    func subScrollViewDidScroll(_ scrollView: UIScrollView) {
        currentScrollingListView = scrollView
        
        preferredProcessSubScrollViewDidScroll(scrollView)
    }
    
    func preferredProcessSubScrollViewDidScroll(_ scrollView: UIScrollView) {
        if mainTableView.contentOffset.y < delegateOfMainView!.tableHeaderViewHeightInPagerListMainView() {
            //mainTableView的header还没有消失，让listScrollView一直为0
            scrollView.contentOffset = CGPoint.zero
            scrollView.showsVerticalScrollIndicator = false
        }else{
            //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
            mainTableView.contentOffset = CGPoint.init(x: 0, y: delegateOfMainView!.tableHeaderViewHeightInPagerListMainView())
            scrollView.showsVerticalScrollIndicator = true
        }
        
    }
    
    func preferredProcessMainTableViewDidScroll(_ scrollView: UIScrollView) {
        if currentScrollingListView != nil && currentScrollingListView!.contentOffset.y > CGFloat(0) {
            //mainTableView的header已经滚动不见，开始滚动某一个listView，
            //那么固定mainTableView的contentOffset，让其不动
            mainTableView.contentOffset = CGPoint.init(x: 0, y: delegateOfMainView!.tableHeaderViewHeightInPagerListMainView())
        }
        
        
        if mainTableView.contentOffset.y < delegateOfMainView!.tableHeaderViewHeightInPagerListMainView() {
            //mainTableView开始显示了tableHeaderView，所有的listView的contentOffset需要重置
            //重置后都可以下拉
            let currentVCArr = delegateOfMainView!.listVCInPagerListMainView()
            for vc in currentVCArr {
                vc.getScrollViewOfSubView().contentOffset = CGPoint.zero
            }
        }
        
        if mainTableView.contentOffset.y > delegateOfMainView!.tableHeaderViewHeightInPagerListMainView() && currentScrollingListView!.contentOffset.y == 0 {
            //当往上滚动mainTableView的headerView时，滚动到底时，修复listView往上小幅度滚动
            mainTableView.contentOffset = CGPoint.init(x: 0, y: delegateOfMainView!.tableHeaderViewHeightInPagerListMainView())
        }
    }
}

 //MARK: -  SGPageTitleViewDelegate,SGPageContentCollectionViewDelegate
extension ZL_PagerListMainView: SGPageTitleViewDelegate,SGPageContentCollectionViewDelegate{
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        contentView.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {

        segmentView!.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, willDisplayIndexPath: IndexPath) {
        let currentVCArr = delegateOfMainView!.listVCInPagerListMainView()
        
        currentScrollingListView = currentVCArr[willDisplayIndexPath.item].getScrollViewOfSubView()
        
    }
}
