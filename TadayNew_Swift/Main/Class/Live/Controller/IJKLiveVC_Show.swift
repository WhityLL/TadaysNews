//
//  IJKLiveVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/12.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class IJKLiveVC_Show: IJKLiveBaseVC {
    
    private var isBeginSlid: Bool = false
    
    private lazy var naviView = IJKLive_Show_Navi.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kStatusBarAndNavigationBarHeight))
    
    private lazy var controlView = IJKLive_Show_ControlView.init(frame: UIScreen.main.bounds)
    
    private lazy var userInfoView = IJKLive_Show_UserInfoView.init(frame: CGRect.init(x: 15, y: kStatusBarHeight, width: (SCREEN_WIDTH - 30)/3, height: 44))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubView()
        
        action()
        
    }

}

extension IJKLiveVC_Show {
    
    func setupSubView() {
        
        firstFrameImageView.frame = UIScreen.main.bounds
        
        player.view.frame = firstFrameImageView.bounds
        view.insertSubview(player.view, aboveSubview: firstFrameImageView)
        player.scalingMode = .aspectFill
        
        player.view.addSubview(controlView)
        controlView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    
        view.addSubview(naviView)
        
        view.addSubview(userInfoView)
        
        userInfoView.liveData = liveData
    }
    
    func action() {
        
        naviView.closeClosure = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - ========= 手势处理控制页 ==========
extension IJKLiveVC_Show {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isBeginSlid = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch =  (touches as NSSet).anyObject() as! UITouch
        
        var lastPoint: CGPoint = CGPoint.init()
        var currentPoint: CGPoint = CGPoint.init()   //当前位置
        var tempCenter: CGPoint = CGPoint()         //获取偏移位置
        
        if isBeginSlid {//首次触摸进入
            lastPoint = touch.previousLocation(in: player.view)
            currentPoint = touch.location(in: player.view)
            
            if abs(currentPoint.x - lastPoint.x) > abs(currentPoint.y - lastPoint.y){//左右滑动
                tempCenter = controlView.center
                tempCenter.x += currentPoint.x - lastPoint.x //左右滑动
                if (controlView.frame.origin.x == 0 && currentPoint.x - lastPoint.x > 0) {
                    //滑动开始是从0点开始的，并且是向右滑动
                    controlView.center = tempCenter;
                }
            }else{//上下滑动
                //上下获取偏移位置
//                tempCenter = player.view.center;
//                tempCenter.y += currentPoint.y - lastPoint.y;//上下滑动
//                player.view.center = tempCenter;
            }
            
        }else{//滑动开始后进入，滑动方向要么水平要么垂直
            
            //上下滑动 （垂直的优先级高于左右滑）
            if (player.view.frame.origin.y != 0){
                
//                lastPoint = touch.previousLocation(in: player.view)
//                currentPoint = touch.location(in: player.view)
//                tempCenter = player.view.center;
//
//                tempCenter.y += currentPoint.y - lastPoint.y;
//                player.view.center = tempCenter;
                
            }else if (controlView.frame.origin.x != 0) {//左右滑
                
                lastPoint = touch.previousLocation(in: controlView)
                currentPoint = touch.location(in: controlView)
                tempCenter = controlView.center;
 
                tempCenter.x += currentPoint.x - lastPoint.x;
                
                //禁止向左划
                if (controlView.frame.origin.x == 0 && currentPoint.x - lastPoint.x > 0) {//滑动开始是从0点开始的，并且是向右滑动
                    controlView.center = tempCenter;
                    
                }else if(controlView.frame.origin.x > 0){
                    controlView.center = tempCenter;
                }
            }

        }
        isBeginSlid = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 水平滑动判断
        //在控制器这边滑动判断如果滑动范围没有超过屏幕的十分之四livingInfoView还是离开屏幕
        if (controlView.frame.origin.x > SCREEN_WIDTH * 0.4) {
            UIView.animate(withDuration: 0.12) {
                self.controlView.left = SCREEN_WIDTH
            }
        }else{//否则则回到屏幕0点
            UIView.animate(withDuration: 0.2) {
                self.controlView.left = 0
            }
        }
        
        /*
        //上下滑动判断
        if (player.view.frame.origin.y > SCREEN_HEIGHT * 0.6) {
            //切换到下一频道
        }else if (player.view.frame.origin.y < -SCREEN_HEIGHT * 0.6){
            //切换到上一频道
        }
        //回到原始位置等待界面重新加载
        player.view.y = 0
        */
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 水平滑动判断
        //在控制器这边滑动判断如果滑动范围没有超过屏幕的十分之四livingInfoView还是离开屏幕
        if (controlView.frame.origin.x > SCREEN_WIDTH * 0.4) {
            UIView.animate(withDuration: 0.12) {
                self.controlView.left = SCREEN_WIDTH
            }
        }else{//否则则回到屏幕0点
            UIView.animate(withDuration: 0.2) {
                self.controlView.left = 0
            }
        }
        
        /*
         //上下滑动判断
         if (player.view.frame.origin.y > SCREEN_HEIGHT * 0.6) {
         //切换到下一频道
         }else if (player.view.frame.origin.y < -SCREEN_HEIGHT * 0.6){
         //切换到上一频道
         }
         //回到原始位置等待界面重新加载
         player.view.y = 0
         */
    }
}
