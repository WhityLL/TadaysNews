//
//  HomeVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/8.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import SGPagingView

class HomeVC: BaseViewController {
    
    let pageViewH : CGFloat = 36
    
    var channelTitleModels = [HomeNewsTitleModel]()
    
    /// 自定义导航栏
    private lazy var naviBar = ZL_NaviBarView()
    
    /// 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentScrollView?
    
    /// 添加频道按钮
    private lazy var addChannelButton: UIButton = {
        let addChannelButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - pageViewH, y: 0, width: pageViewH, height: pageViewH))
        addChannelButton.setImage(UIImage.init(named: "add_channel_titlbar_thin_new_16x16_"), for: .normal)
        addChannelButton.addTarget(self, action: #selector(addChannelButtonClick), for: .touchUpInside)
        
        let separatorView = UIView(frame: CGRect(x: 0, y: pageViewH - 1, width: pageViewH, height: 1))
        separatorView.backgroundColor = ZLSeperateColor()
        addChannelButton.addSubview(separatorView)
        return addChannelButton
    }()
    
    // MARK: - ========= LifeCycle ==========
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "navigation_background"), for: .default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        navigationItem.titleView = naviBar // 自定义导航栏
        view.addSubview(addChannelButton) // 添加频道
        
        //点击事件
        clickAction()
        
        //请求数据
        requstData()
    }
}

extension HomeVC {
    
    private func requstData() {
        NetManager.loadHomeNewsTitleData { (titleModelsArr : [HomeNewsTitleModel]) in
            
            self.channelTitleModels.append(contentsOf: titleModelsArr)
            
            //数据处理
            let titleNames : NSMutableArray = NSMutableArray.init()
            let vcs : NSMutableArray = NSMutableArray.init()
            
            for obj : HomeNewsTitleModel in titleModelsArr {
                titleNames.add(obj.name)
                
                switch obj.category {
                case .care:
                    let careVC = UserCareVC()
                    vcs.add(careVC)
                case .video:            // 视频
                    let videoTableVC = UIViewController()
                    videoTableVC.view.backgroundColor = ZLRandomColor()
                    vcs.add(videoTableVC)
                case .essayJoke:        // 段子
                    let essayJokeVC = UIViewController()
                    essayJokeVC.view.backgroundColor = ZLRandomColor()
                    vcs.add(essayJokeVC)
                case .imagePPMM:        // 街拍
                    let imagePPMMVC = UIViewController()
                    imagePPMMVC.view.backgroundColor = ZLRandomColor()
                    vcs.add(imagePPMMVC)
                case .imageFunny:        // 趣图
                    let imagePPMMVC = UIViewController()
                    imagePPMMVC.view.backgroundColor = ZLRandomColor()
                    vcs.add(imagePPMMVC)
                case .photos:           // 图片,组图
                    let homeImageVC = UIViewController()
                    homeImageVC.view.backgroundColor = ZLRandomColor()
                    vcs.add(homeImageVC)
                case .jinritemai:       // 特卖
                    let temaiVC = UIViewController()
                    temaiVC.view.backgroundColor = ZLRandomColor()
                    vcs.add(temaiVC)
                default :
                    let homeTableVC = UIViewController()
                    homeTableVC.view.backgroundColor = ZLRandomColor()
                    vcs.add(homeTableVC)
                }
            }
            
            // pageView
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = ZLBlackTextColor()
            configuration.titleSelectedColor = ZLGlobalRedColor()
            configuration.indicatorColor = .clear
            configuration.bottomSeparatorColor = ZLSeperateColor()
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - self.pageViewH, height: self.pageViewH), delegate: self , titleNames: titleNames as? [Any], configure: configuration)
            self.pageTitleView!.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            
            // 内容视图
            self.pageContentView = SGPageContentScrollView.init(frame: CGRect(x: 0, y: self.pageViewH, width: SCREEN_WIDTH, height: self.view.height - self.pageViewH), parentVC: self, childVCs: vcs as? [Any])
            self.pageContentView!.delegatePageContentScrollView = self
            self.view.addSubview(self.pageContentView!)
        }
        
    }
    
    private func clickAction() {

        naviBar.didClickCameraBtn = { (sender)  in
            self.showRelyOn(view: sender)
        }
        
        naviBar.didClickSearchBtn = {
            
        }
    
    }
    
    @objc private func addChannelButtonClick(){
        
//        let vc = HomeChannelVC()
//        vc.userSectectedTitles = channelTitleModels
//        present(vc, animated: true, completion: nil)
        
        let vc = HomeChannelPOPVC()
        vc.userSectectedTitles = channelTitleModels
        vc.show()
        
    }
}


// MARK: - SGPageTitleViewDelegate
extension HomeVC : SGPageTitleViewDelegate,SGPageContentScrollViewDelegate{
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView!.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
