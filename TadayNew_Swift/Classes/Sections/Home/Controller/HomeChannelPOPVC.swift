//
//  HomeChannelPOPVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/16.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class HomeChannelPOPVC: UIViewController {

    ///用户已选
    var userSectectedTitles = [HomeNewsTitleModel]()
    private var previousKeyWindow: UIWindow = UIWindow()
    private var showWindow: UIWindow? = UIWindow()
    
    lazy var contentView: HomeChannelView = {
        let contentView = HomeChannelView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarHeight))

        view.addSubview(contentView)
        contentView.backgroundColor = ZLRandomColor()
        return contentView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        
        // init window
        setupWindow()

        // init SubView (交给子类完成)
        setupSubView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension HomeChannelPOPVC {
    
    func setupSubView() {
        contentView.channelPopViewCloseClosure = {
            self.dismiss()
        }
        
    }
    
    func setupWindow() {
        previousKeyWindow = UIApplication.shared.keyWindow!
        
        let newWindow = UIWindow.init(frame: UIScreen.main.bounds)
        newWindow.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newWindow.isOpaque = false
        newWindow.windowLevel = .normal
        newWindow.makeKeyAndVisible()
        
        let navi: ZL_NaviVC = ZL_NaviVC.init(rootViewController:self)
        newWindow.rootViewController = navi;
        self.showWindow = newWindow;
    }
    
    public func show() {
        contentView.userSectectedTitles.append(contentsOf: userSectectedTitles)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.contentView.frame = CGRect.init(x: 0, y: kStatusBarHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarHeight)
        }) { (completion: Bool) in
            
        }
    }
    
    public func dismiss() {
    
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.contentView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarHeight)
            
        }) { (completion: Bool) in
            self.contentView.removeFromSuperview()
            self.cleanWindow()
        }
    }
    
    func cleanWindow() {
        self.showWindow?.rootViewController = nil
        self.showWindow?.resignKey()
        self.showWindow = nil
        self.previousKeyWindow.makeKeyAndVisible()
    }
}
