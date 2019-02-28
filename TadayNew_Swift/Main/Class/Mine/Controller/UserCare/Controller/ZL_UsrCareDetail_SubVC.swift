//
//  ZL_UsrCareDetail_SubVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/31.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_UsrCareDetail_SubVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupRefresh()
        
    }
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - heightForHeaderInSection), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.bouncesZoom = false
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        return tableView
    }()


}

extension ZL_UsrCareDetail_SubVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = ZLRandomColor()
        return cell
    }
    
}

extension ZL_UsrCareDetail_SubVC{
    private func setupRefresh() {
        tableView.addHeaderGifRefresh {

            self.requestData()
        }
        
        tableView.addFooterGifRefresh {
            self.requestData()
        }
        
        tableView.beginHeaderRefresh()
    }
    
    func requestData() {
        tableView.endHeaderRefresh()
        tableView.endFooterRefresh()
        
        tableView.reloadData()
    }
}
