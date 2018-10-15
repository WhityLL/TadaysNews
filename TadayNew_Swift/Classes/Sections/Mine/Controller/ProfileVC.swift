//
//  ProfileVC.swift
//  TodayNew_Swift
//
//  Created by LiuLei on 2016/12/22.
//  Copyright © 2016年 LiuLei. All rights reserved.
//

import UIKit
import SVProgressHUD
import FDFullscreenPopGesture

let initIdentifier = "Cell"

class ProfileVC: BaseViewController {
    
    let titles = [["我的关注","消息通知"],["我的钱包","京东特卖"],["用户反馈","系统设置"]]
    
    // MARK: - ========= 懒加载 ==========
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
        tableView.tableHeaderView = header
        
        return tableView
    }()
    
    lazy var header: ProfileHeaderView = {
        let header = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 300))
        header.delegate = self
        return header
    }()
    
    // MARK: - ========= LifeCycle ==========
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fd_prefersNavigationBarHidden = true
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        };
    
        setupUI()
    }
   
    // MARK: - ========= system Func ==========
    ///设置statusBar颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ProfileVC {
    
    func setupUI() {
        
        //  HeaderView Block 回掉
        header.bottomView.collectionButtonClosure = { (collectionButton) in
            self.togoCollectionOrHis(index: 0)
            SVProgressHUD.showInfo(withStatus: "收藏")
        }
        
        header.bottomView.nightButtonClosure = { (historyButton) in
            self.togoCollectionOrHis(index: 1)
            SVProgressHUD.showInfo(withStatus: "历史")
        }
        
        header.bottomView.settingButtonClosure = { (nightButton) in
            print(nightButton)
            SVProgressHUD.showInfo(withStatus: "夜间")
        }
    }
    
    // MARK: - ========= Private Func ==========
    func togoLoginVC() {
        let loginVC = LoginVC()
        loginVC.title = "登录"
        present(ZL_NaviVC.init(rootViewController: loginVC), animated: false, completion: nil)
    }
    
    func togoCollectionOrHis(index : Int) {
        
        let vc : CollectOrHistoryBaseVC = CollectOrHistoryBaseVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension ProfileVC : ProfileHeaderViewDelegate{
    // MARK: ProHeaderViewDelegate
    func noLoginHeaderView(headerView: ProfileHeaderView, mobileLoginButtonClick: UIButton) {
        print(#function)
        SVProgressHUD.showInfo(withStatus: "Mobile登陆")
    }
    
    func noLoginHeaderView(headerView: ProfileHeaderView, wechatLoginButtonClick: UIButton) {
        print(#function)
        SVProgressHUD.showInfo(withStatus: "WeChat登陆")
    }
    
    func noLoginHeaderView(headerView: ProfileHeaderView, qqLoginButtonClick: UIButton) {
        print(#function)
        SVProgressHUD.showInfo(withStatus: "QQ登陆")
    }
    
    func noLoginHeaderView(headerView: ProfileHeaderView, weiboLoginButtonClick: UIButton) {
        print(#function)
        SVProgressHUD.showInfo(withStatus: "Weibo登陆")
    }
    
    func noLoginHeaderView(headerView: ProfileHeaderView, moreLoginButtonClick: UIButton) {
        print(#function)
        togoLoginVC()
    }
    
}


extension ProfileVC: UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: initIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: initIdentifier)
        }
        cell?.accessoryType = .disclosureIndicator
        let arr = titles[indexPath.section]
        cell?.textLabel?.text = arr[indexPath.row]
        return cell!
    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.textLabel?.text == "系统设置" {
            let settingVC = ZLSettingVC()
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
        
    }
    
    // MARK: - UIScrollViewDelagate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kZLMineHeaderImageHeight + abs(offsetY)
            let f = totalOffset / kZLMineHeaderImageHeight
            header.bgImageView.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
            
//            var tempFrame = header.bgImageView.frame
//            tempFrame.origin.y = offsetY
//            tempFrame.size.height = kZLMineHeaderImageHeight - offsetY
//            header.bgImageView.frame = tempFrame
        }
    }
}
