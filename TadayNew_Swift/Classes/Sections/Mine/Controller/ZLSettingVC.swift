//
//  ZLSettingVC.swift
//  TodayNew_Swift
//
//  Created by LiuLei on 2016/12/30.
//  Copyright © 2016年 LiuLei. All rights reserved.
//

import UIKit
import Kingfisher

let settingCellID = "settingCellID"

class ZLSettingVC: BaseViewController {

    var tableView: UITableView?
    var settings: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        // 从沙盒读取缓存数据的大小
        calcuateCacheSizeFromSandBox()
        loadSettingFromPlist()
        /// 设置 UI
        setupUI()
    }
    
    /// 从沙盒读取缓存数据的大小
    private func calcuateCacheSizeFromSandBox() {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            // 转换成 M
            let sizeM = Double(size) / 1024.0 / 1024.0
            let sizeString = String(format: "%.2fM", sizeM)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSizeM"), object: self, userInfo: ["cacheSize": sizeString])
        }
    }
    
    private func setupUI() {
    
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        let nib = UINib(nibName:String("ZLSettingCell"), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: settingCellID)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0.1 // 默认是0
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        self.tableView = tableView
    }
    
    // 从 plist 加载数据
    private func loadSettingFromPlist() {
        let path = Bundle.main.path(forResource: "YMSettingPlist", ofType: "plist")
        let cellPlist = NSArray.init(contentsOfFile: path!)
        for arrayDict in cellPlist! {
            let array = arrayDict as! NSArray
            var sections = [AnyObject]()
            for dict in array {
                let cell = ZLSettingModel(dict: dict as! [String: AnyObject])
                sections.append(cell)
            }
            settings.append(sections as AnyObject)
        }
    }
    
    /// 设置字体大小
     func setupFontAlertController() {
        let alertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue:"fontSize"), object: self, userInfo: ["fontSize": "小"])
        })
        let middleAction = UIAlertAction(title: "中", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "中"])
        })
        let bigAction = UIAlertAction(title: "大", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "大"])
        })
        let largeAction = UIAlertAction(title: "特大", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "特大"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(smallAction)
        alertController.addAction(middleAction)
        alertController.addAction(bigAction)
        alertController.addAction(largeAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // 非 wifi 网络流量
    func setupNetworkAlertController() {
        let alertController = UIAlertController(title: "非Wifi网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestFlowAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "最佳效果（下载大图）"])
        })
        let betterFlowAction = UIAlertAction(title: "较省流量（智能下图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "较省流量（智能下图）"])
        })
        let leastFlowAction = UIAlertAction(title: "极省流量（不下载图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "极省流量（不下载图）"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(bestFlowAction)
        alertController.addAction(betterFlowAction)
        alertController.addAction(leastFlowAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// 清除缓存
    func clearCacheAlertController() {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线内容及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            let sizeString = "0.00M"
            NotificationCenter.default.post(name: Notification.Name(rawValue: "cacheSizeM"), object: self, userInfo: ["cacheSize": sizeString])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// 头部 view
//    private lazy var headerView: YMSettingHeaderView = {
//        let headerView = YMSettingHeaderView.settingHeaderView()
//        headerView.delegate = self
//        return headerView
//    }()
}

extension ZLSettingVC: UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Count===\(settings.count)")
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = settings[section] as! [ZLSettingModel]
        return setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCellID) as! ZLSettingCell
        let cellArray = settings[indexPath.section] as! [ZLSettingModel]
        cell.setting = cellArray[indexPath.row]
        
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                NotificationCenter.default.addObserver(self, selector: #selector(changeFontSize), name: NSNotification.Name(rawValue: "fontSize"), object: self)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                NotificationCenter.default.addObserver(self, selector: #selector(changeNeworkMode), name: NSNotification.Name(rawValue: "networkMode"), object: self)
            } else if indexPath.row == 1 {
                NotificationCenter.default.addObserver(self, selector: #selector(loadCacheSize), name: NSNotification.Name(rawValue: "cacheSizeM"), object: self)
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 1 {
                cell.selectionStyle = .none
            }
        }
        return cell

    }
    

    
    @objc func changeFontSize(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = NSIndexPath(row: 1, section: 0)
        let cell = tableView?.cellForRow(at: indexPath as IndexPath) as! ZLSettingCell
        cell.lb_rightTitle.text = userInfo["fontSize"] as? String
        
        //全局变量处理
    }
    
    /// 改变网络模式
    @objc func changeNeworkMode(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = NSIndexPath(row: 0, section: 1)
        let cell = tableView?.cellForRow(at: indexPath as IndexPath) as! ZLSettingCell
        cell.lb_rightTitle.text = userInfo["networkMode"] as? String
        
        //全局变量处理
        
    }
    
    /// 获取缓存大小
    @objc func loadCacheSize(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = NSIndexPath(row: 1, section: 1)
        let cell = tableView?.cellForRow(at: indexPath as IndexPath) as! ZLSettingCell
        cell.lb_rightTitle.text = userInfo["cacheSize"] as? String
        //全局变量处理
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                // 设置字体大小
                setupFontAlertController()
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                // 网络流量
                setupNetworkAlertController()
            } else if indexPath.row == 1 {
                // 清除缓存
                clearCacheAlertController()
            }
        }
        
        if indexPath.section == 2 {
            if indexPath.row == 0 { // 推送通知
                let settingUrl = URL(string: UIApplication.openSettingsURLString)!
                if UIApplication.shared.canOpenURL(settingUrl){
                    UIApplication.shared.openURL(settingUrl)
                }
            } else if indexPath.row == 2 {
//                let autoPlayVideoVC = YMAutoPlayVideoController()
//                autoPlayVideoVC.title = "自动播放视频"
//                navigationController?.pushViewController(autoPlayVideoVC, animated: true)
            }
        }
        
        if indexPath.section == 3 {
            
        }
    }
    
}
