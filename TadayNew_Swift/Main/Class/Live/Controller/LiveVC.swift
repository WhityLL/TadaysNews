//
//  LiveVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class LiveVC: BaseViewController {

    let pageViewH : CGFloat = 36
    
    /// 自定义导航栏
    private lazy var naviBar = ZL_NaviBarView()
    
    /// 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentScrollView?
    
    
    // MARK: - ========= LifeCycle ==========
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "navigation_background"), for: .default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 自定义导航栏
        navigationItem.titleView = naviBar
        
        //点击事件
        clickAction()
        
        requestData()
    }
}


extension LiveVC {
    
    private func requestData() {
        
        NetManager.loadVideoApiCategoies { (titleModelsArr : [HomeNewsTitleModel]) in

            let titleNames : NSMutableArray = NSMutableArray.init()
            let vcs : NSMutableArray = NSMutableArray.init()
            
            for obj : HomeNewsTitleModel in titleModelsArr {
                titleNames.add(obj.name)
                
                switch obj.category {
                case .care:
                    let careVC = UserCareVC()
                    vcs.add(careVC)
                default :
                    let videoVC: LiveVC_VideoListVC = LiveVC_VideoListVC()
                    videoVC.categary = obj.category
                    vcs.add(videoVC)
                }
            }
            
            // pageView
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = ZLBlackTextColor()
            configuration.titleSelectedColor = ZLGlobalRedColor()
            configuration.bottomSeparatorColor = ZLSeperateColor()
            configuration.indicatorColor = .clear
            configuration.showIndicator = false
            configuration.titleTextZoom = true
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.pageViewH), delegate: self , titleNames: titleNames.mutableCopy() as! [String], configure: configuration)
            self.pageTitleView!.backgroundColor = .white
            self.pageTitleView?.index = 1
            self.view.addSubview(self.pageTitleView!)
            
            // 内容视图
            self.pageContentView = SGPageContentScrollView.init(frame: CGRect(x: 0, y: self.pageViewH, width: SCREEN_WIDTH, height: self.view.height - self.pageViewH), parentVC: self, childVCs: vcs as! [UIViewController])
            self.pageContentView!.delegateScrollView = self
            self.view.addSubview(self.pageContentView!)
        }
    }
    
    private func clickAction() {
        
        naviBar.didClickCameraBtn = { (sender) in
            self.showRelyOn(view: sender)
        }
        
        naviBar.didClickSearchBtn = {
            
        }
        
    }
}

// MARK: - SGPageTitleViewDelegate
extension LiveVC : SGPageTitleViewDelegate,SGPageContentScrollViewDelegate{
    /// 联动 pageContent 的方法
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        self.pageContentView!.setPageContentScrollView(index: index)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }

}
