//
//  ZL_UserCareDetailVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/31.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

// MARK: - 自定义一个可以接受上层 tableView 手势的 tableView
class UserDetailTableView: UITableView, UIGestureRecognizerDelegate {
    // 底层 tableView 实现这个 UIGestureRecognizerDelegate 代理方法，就可以响应上层 tableView 的滑动手势，
    // otherGestureRecognizer 就是它上层的 view 持有的手势，这里的话，上层应该是 scrollView 和 顶层 tabelview
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        // 保证其他手势的存在
//        guard let otherView = otherGestureRecognizer.view else { return false }
//        // 如果其他手势的 view 是 UIScrollView，就不能让 UserDetailTableView 响应
//        if otherView.isMember(of: UIScrollView.self) { return false }
//        // 其他手势是 tableView 的 pan 手势，就让他响应
//        let isPan = gestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
//        if isPan && otherView.isKind(of: UIScrollView.self) { return true }
//        return false
//    }
    
    ///是否同时支持多种手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder())
    }
}

class ZL_UserCareDetailVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_clear"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.subviews.first?.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZLBgColor()
        
        // 设置 UI
        setupUI()
      
    }
    
    private lazy var headerView = ZL_UserCareDetail_HeaderView.loadViewFromNib()
    
    private lazy var navi = ZL_UserCareDetail_Navi.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kStatusBarAndNavigationBarHeight))
    
    let segmentView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: heightForHeaderInSection))
    
    @IBOutlet weak var tableView: UITableView!

}

extension ZL_UserCareDetailVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return segmentView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - heightForHeaderInSection
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
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let navigationBarHeight: CGFloat = -kStatusBarAndNavigationBarHeight
        
        if offsetY < navigationBarHeight {
            //// 放大
            let totalOffset = 146 + abs(offsetY)
            let f = totalOffset / 146
            headerView.bgImageView.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
            navi.naviBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
 
            
//            tableView.contentOffset = CGPoint.init(x: 0, y: 0)
            
        } else {
            var alpha: CGFloat = (offsetY + 44) / 58
            alpha = min(alpha, 1.0)
            navi.naviBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                navigationController?.navigationBar.barStyle = .default
//                navigationBar.returnButton.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
//                navigationBar.moreButton.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            } else {
                navigationController?.navigationBar.barStyle = .black
//                navigationBar.returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
//                navigationBar.moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
            // 14 + 15 + 14
            var alpha1: CGFloat = offsetY / 57
            if offsetY >= 43 {
                alpha1 = min(alpha1, 1.0)
//                navigationBar.nameLabel.isHidden = false
//                navigationBar.concernButton.isHidden = false
//                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
//                navigationBar.concernButton.alpha = alpha1
            } else {
                alpha1 = min(0.0, alpha1)
//                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
//                navigationBar.concernButton.alpha = alpha1
            }
        }
    }
    
}

extension ZL_UserCareDetailVC{
    func setupUI() {
        
        edgesForExtendedLayout = .top
        
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = navi
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        let sectionHeaderView: SGPageTitleView = SGPageTitleView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: heightForHeaderInSection), delegate: self, titleNames: ["A","B","C"], configure: SGPageTitleViewConfigure())
        segmentView.addSubview(sectionHeaderView)
        tableView.tableHeaderView = headerView
        
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        let listVC: Array = [ZL_UsrCareDetail_SubVC(),ZL_UsrCareDetail_SubVC(),ZL_UsrCareDetail_SubVC()]

        let contentView: SGPageContentScrollView = SGPageContentScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - heightForHeaderInSection), parentVC: self, childVCs: listVC)
        contentView.delegateScrollView = self
        
        cell?.addSubview(contentView)
        
    }
}

extension ZL_UserCareDetailVC: SGPageTitleViewDelegate,SGPageContentScrollViewDelegate{
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        
    }
    
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        
    }
}
