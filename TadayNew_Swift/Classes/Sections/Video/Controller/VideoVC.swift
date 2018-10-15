//
//  VideoVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import SGPagingView

class VideoVC: BaseViewController {

    /// 自定义导航栏
    private lazy var naviBar = ZL_NaviBarView_Video()
    
    /// 内容
    private var pageContentView: SGPageContentScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = naviBar
        
        setClickAction()
        
        requestData()
    }

}

extension VideoVC {
    
    private func requestData() {
        // 小视频导航栏标题的数据
        NetManager.loadSmallVideoCategories {(titleModelsArr : [HomeNewsTitleModel]) in
            
            if titleModelsArr.count == 0 { return }
            
            let titleNames : NSMutableArray = NSMutableArray.init()
            let vcs : NSMutableArray = NSMutableArray.init()
            
            for obj : HomeNewsTitleModel in titleModelsArr {
                titleNames.add(obj.name)
                
                switch obj.category {
                case .care:      //关注
                    let careVC = UserCareVC()
                    vcs.add(careVC)
                case .hotsoonVideo:        //推荐
                    let vc = VideoVC_VideoListVC()
                    vc.categary = .hotsoonVideo
                    vcs.add(vc)
                case .ugcVideoLocal:       //附近
                    let vc = VideoVC_VideoNearbyVC()
                    vc.categary = .ugcVideoLocal
                    vcs.add(vc)
                case .ugcVideoActivity:    //活动
                    let vc = UIViewController()
                    vcs.add(vc)
                case .smallgameSmallvideo:  //游戏
                    let vc = VideoVC_VideoListVC()
                    vc.categary = .smallgameSmallvideo
                    vcs.add(vc)
                default :
                    let vc = VideoVC_VideoListVC()
                    vcs.add(vc)
                }
            }
            
            // 内容视图
            self.pageContentView = SGPageContentScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - kTabbarHeight), parentVC: self, childVCs: vcs as? [Any])
            self.pageContentView!.delegatePageContentScrollView = self
            self.view.addSubview(self.pageContentView!)
            
            // 设置导航栏数据数组
            self.naviBar.titleNames = titleNames as! [String]
            
            // 点击了 标题
            self.naviBar.pageTitleViewSelected = { [weak self] index in
                self!.pageContentView!.setPageContentScrollViewCurrentIndex(index)
            }
        }
    }
    
    private func setClickAction() {
        naviBar.didClickCameraBtn = {
            let vc : PulishVideoVC = PulishVideoVC()
            self.present(ZL_NaviVC.init(rootViewController:vc), animated: true, completion: nil)
        }
    }
}

// MARK: - SGPageTitleViewDelegate
extension VideoVC : SGPageContentScrollViewDelegate{
    /// 联动 SGPageTitleView 的方法
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.naviBar.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
