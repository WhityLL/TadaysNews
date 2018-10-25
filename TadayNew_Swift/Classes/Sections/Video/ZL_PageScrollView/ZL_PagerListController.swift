//
//  ZL_PagerListController.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/24.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_PagerListController: UIViewController {

    lazy var pageListMainView: ZL_PagerListMainView = {
        let pageListMainView = preferredPagingView()
        
        return pageListMainView
    }()
    
    lazy var headerView: ZL_PagerListHeaderView = {
        let headerView = ZL_PagerListHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: scrollTableHeaderViewHeight))
        return headerView
    }()
    
    private lazy var sectionHeaderView: SGPageTitleView = {
        let config: SGPageTitleViewConfigure = SGPageTitleViewConfigure()
        
        let sectionHeaderView: SGPageTitleView = SGPageTitleView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: heightForHeaderInSection), delegate: self.pageListMainView, titleNames: ["AAAAA","BBBBB","CCCC"], configure: config)
        
        sectionHeaderView.backgroundColor = .yellow
        
        return sectionHeaderView
    }()
    
    /// 遵循ZL_PagerListSubScrollViewDelegate的子类s滚动视图数组
    var subVCList = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZLBgColor()
        self.title = "更多"
        
        let vc1 = Video_Activity_MoreVC_LeftView()
        let vc2 = Video_Activity_MoreVC_LeftView()
        let vc3 = Video_Activity_MoreVC_LeftView()

        subVCList.append(vc1)
        subVCList.append(vc2)
        subVCList.append(vc3)
        
        view.addSubview(pageListMainView)
    }

    func preferredPagingView() -> ZL_PagerListMainView {
        let mainView =  ZL_PagerListMainView.init(frame: CGRect.zero, delegate: self)
        mainView.parentVC = self
        return mainView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageListMainView.frame = view.bounds;
    }
}

extension ZL_PagerListController: ZL_PagerListMainViewDelegate {

    func tableHeaderViewHeightInPagerListMainView() -> CGFloat {
        return scrollTableHeaderViewHeight
    }
    
    func tableHeaderViewInPagerListMainView() -> UIView {
        return headerView
    }
    
    func heightForSectionHeaderViewInPagerListMainView() -> CGFloat {
        return heightForHeaderInSection
    }
    
    func sectionHeaderViewInPagerListMainView() -> SGPageTitleView {
        return self.sectionHeaderView
    }
    
    func listVCInPagerListMainView() -> [ZL_PagerListSubScrollViewDelegate] {
        return subVCList as! [ZL_PagerListSubScrollViewDelegate]
    }
    
}
