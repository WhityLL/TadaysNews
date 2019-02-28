//
//  UIViewController+CameraExtension.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/9.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    
    func showRelyOn(view : UIView) {
        YBPopupMenu.showRely(on: view, titles: ["发图文","拍小视频","上传视频","提问"], icons: ["barrage_fill","live_fill","video_fill","feedback_fill"], menuWidth: 130) { (popupMenu) in
            popupMenu?.type = .dark
            popupMenu?.fontSize = 13
            popupMenu?.textColor = UIColor.white
            popupMenu?.tableView.layer.cornerRadius = 5
            popupMenu?.tableView.layer.masksToBounds = true
            popupMenu?.tableView.separatorStyle = .singleLine
            popupMenu?.delegate = self;
        }
    }
}

extension UIViewController : YBPopupMenuDelegate{
    public func ybPopupMenu(_ ybPopupMenu: YBPopupMenu!, didSelectedAt index: Int) {
        switch index {
        case 0:
            SVProgressHUD.showInfo(withStatus: "图文")
            break
        case 1:
            let vc : PulishVideoVC = PulishVideoVC()
            self.present(ZL_NaviVC.init(rootViewController:vc), animated: true, completion: nil)
            break
        case 2:
            SVProgressHUD.showInfo(withStatus:"上传视频")
            break
        case 3:
            SVProgressHUD.showInfo(withStatus:"提问")
            break
            
        default:
            break
        }
    }
}
