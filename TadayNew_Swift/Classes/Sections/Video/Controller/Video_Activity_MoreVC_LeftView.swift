//
//  Video_Activity_MoreVC_LeftView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/24.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class Video_Activity_MoreVC_LeftView: UIViewController {

    private var scrollDidScrollCallback: ((_ scrollView: UIScrollView) -> ())?
    
    private let dataSources: Array = ["橡胶火箭", "橡胶火箭炮", "橡胶机关枪", "橡胶子弹", "橡胶攻城炮", "橡胶象枪", "橡胶象枪乱打", "橡胶灰熊铳", "橡胶雷神象枪", "橡胶猿王枪", "橡胶犀·榴弹炮", "橡胶大蛇炮", "橡胶火箭", "橡胶火箭炮", "橡胶机关枪", "橡胶子弹", "橡胶攻城炮", "橡胶象枪", "橡胶象枪乱打", "橡胶灰熊铳", "橡胶雷神象枪", "橡胶猿王枪", "橡胶犀·榴弹炮", "橡胶大蛇炮"]
    
    private lazy var  tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        
        return tableView
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
         view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}


extension Video_Activity_MoreVC_LeftView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(arc4random()%3 + 20)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        
        cell.textLabel?.text = dataSources[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0.01}
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
        }
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.01))
    }
    
}

extension Video_Activity_MoreVC_LeftView: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollDidScrollCallback != nil {
            self.scrollDidScrollCallback!(scrollView)
        }
    }
    
}

extension Video_Activity_MoreVC_LeftView: ZL_PagerListSubScrollViewDelegate{

    func getSubView() -> UIView {
        return self.view
    }
    
    func getScrollViewOfSubView() -> UIScrollView {
        return self.tableView
    }
    
    func subScrollViewsisScrollClosure(callBack : @escaping ( _ scrollView: UIScrollView)->()) {
        self.scrollDidScrollCallback = callBack
    }

}
