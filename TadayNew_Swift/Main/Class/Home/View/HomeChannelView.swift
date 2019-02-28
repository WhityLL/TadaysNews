//
//  HomeChannelView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/14.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class HomeChannelView: HomeChannelBaseView {
    
    var channelPopViewCloseClosure: (() -> ())?
    
    /// 是否编辑
    var isEdit = false {
        didSet {
            collectionView.reloadData()
        }
    }
    // 正在移动时候 不能同时响应滚动事件
    var isEditting = false 
    
    ///用户已选
    var userSectectedTitles = [HomeNewsTitleModel]() {
        didSet {
            collectionView.reloadData()
            // + 5 为弹簧的时候冗余
            self.contentSize = CGSize.init(width: 0, height: self.height + 5)
        }
    }
    ///推荐
    var categories = [HomeNewsTitleModel]()
    
    /// 私有数据源
    var _dataSource = [[HomeNewsTitleModel]]()
    
    let identify_ChannelRecomendCell = "ChannelRecomendCell"
    let identify_UserSelectedCell = "UserChannelCell"
    
    let identify_UserSelectedChannelHeaderView = "UserSelectedChannelHeaderView"
    let identify_RecommendChannelHeaderView = "RecommendChannelHeaderView"
    
    
    private lazy var headerView: UIView = {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        headerView.backgroundColor = .white
        addSubview(headerView)
        
        headerView.addSubview(headerSepLine)
        headerSepLine.frame = CGRect.init(x: 0, y: 39, width: SCREEN_WIDTH, height: 1)
        headerSepLine.isHidden = true
        
        let btn_close: UIButton = UIButton.init(type: .custom)
        headerView.addSubview(btn_close)
        btn_close.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        btn_close.setImage(UIImage.init(named: "small_video_close_night"), for: .normal)
        btn_close.addTarget(self, action: #selector(btn_closeClick), for: .touchUpInside)
        return headerView
    }()
    
    private var headerSepLine: UIView = {
        let headerSepLine = UIView()
        headerSepLine.backgroundColor = ZLSeperateColor()
        return headerSepLine
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let itemWidth = (SCREEN_WIDTH - 1) * 0.5
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 50) * 0.25, height: 44)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let collectionView: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: headerView.bottom, width: SCREEN_WIDTH, height: self.height - headerView.bottom), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = ZLBgColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib.init(nibName: "UserChannelCell", bundle: nil), forCellWithReuseIdentifier:identify_UserSelectedCell)
        collectionView.register(UINib.init(nibName: "ChannelRecomendCell", bundle: nil), forCellWithReuseIdentifier:identify_ChannelRecomendCell)
        
        collectionView.register(UserSelectedChannelHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_UserSelectedChannelHeaderView)
        collectionView.register(RecommendChannelHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_RecommendChannelHeaderView)
        collectionView.tag = 2222
    
        addSubview(collectionView)
        
        var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTarget))
        collectionView.addGestureRecognizer(longPressRecognizer)
        
        return collectionView
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        // 点击首页加号按钮，获取频道推荐数据
        NetManager.loadHomeCategoryRecommend { recommendTitles in
            self.categories.append(contentsOf: recommendTitles)
            
            self._dataSource.append(self.userSectectedTitles)
            self._dataSource.append(self.categories)
            self.collectionView.reloadData()
        }
        
        collectionView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.tag = 1111
        self.delegate = self
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func btn_closeClick() {
        channelPopViewCloseClosure?()
    }
    
}

extension HomeChannelView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let selectedModel = _dataSource[indexPath.section][indexPath.row]
        
        if indexPath.section == 0  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify_UserSelectedCell, for: indexPath) as! UserChannelCell
        
            cell.btn_title.setTitle(selectedModel.name, for: .normal)
            cell.isEdit = isEdit
            cell.isFixed = false
            cell.delegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify_ChannelRecomendCell, for: indexPath) as! ChannelRecomendCell
            cell.btn_recommendTitle.setTitle(selectedModel.name, for: .normal)
            return cell
        }
    }
    
    /// 每个 cell 之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    /// headerView 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 50)
    }
    
    /// 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let userSelectedHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_UserSelectedChannelHeaderView, for: indexPath) as! UserSelectedChannelHeaderView
            
            userSelectedHeaderView.isEdit = isEdit
            
            userSelectedHeaderView.editBtnClickClosure = { (sender: UIButton) in
                self.isEdit = sender.isSelected
            }
            
            return userSelectedHeaderView
        } else {
            let recommendheaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_RecommendChannelHeaderView, for: indexPath) as! RecommendChannelHeaderView
            
            return recommendheaderView
        }
    }
    
    /// 点击了某一个 cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 点击上面一组，不做任何操作
        guard indexPath.section == 1 else { return }
        
        // 更多栏目 -> 我的栏目
        let destinationIndexPath = IndexPath(item: _dataSource[0].count, section: 0)
        
        
        handleDataSource(sourceIndexPath: indexPath, destinationIndexPath: destinationIndexPath)
        
        collectionView.moveItem(at: indexPath, to: destinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        let item = _dataSource[indexPath.section][indexPath.row]
        if indexPath.section > 0 { // 不是我的栏目 或者是固定栏目
            return false
        } else {
            return true
        }
    }
    
    /// 移动 cell
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        handleDataSource(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
    }
    
    /// 这个方法里面控制需要移动和最后移动到的IndexPath(开始移动时)
    /// - Returns: 当前期望移动到的位置
    public func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.section > 0 || proposedIndexPath.item == 0 { // 不是我的栏目 或者是固定栏目
            return originalIndexPath // 操作还原
        } else {
            return proposedIndexPath // 操作完成
        }
    }
}

extension HomeChannelView: UserSelctedChannelCellDelegate {
    /// 删除按钮点击
    func deleteChannelButtonClicked(of cell: UserChannelCell) {
        
//        let indexPath = collectionView.indexPath(for: cell)
//        let destinationIndexPath = IndexPath(item: 0, section: 1)
//
//        handleDataSource(sourceIndexPath: indexPath!, destinationIndexPath: destinationIndexPath)
//        collectionView.moveItem(at: indexPath!, to: destinationIndexPath)


        // 上部删除，下部添加（ 和上面注释部分功能一样）
        let indexPath = collectionView.indexPath(for: cell)
        let selectedModel = _dataSource[indexPath!.section][indexPath!.row]

        _dataSource[1].insert(selectedModel, at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 1)])

        _dataSource[0].remove(at: indexPath!.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath!.item, section: 0)])

    }
}

extension HomeChannelView {

    @objc private func longPressTarget(longPress: UILongPressGestureRecognizer) {
        
        // 选中的点
        let selectedPoint = longPress.location(in: collectionView)
        
        switch longPress.state {
        case .began:
            isEditting = true
            //判断手势落点位置是否在路径上
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: selectedPoint) else {  break }
            if isEdit && selectedIndexPath.section == 0 { // 选中的是上部的 cell,并且是可编辑状态
                collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            } else {
                isEdit = true
                collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            }
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(longPress.location(in: longPress.view))
        case .ended:
            collectionView.endInteractiveMovement()
            isEditting = false
        default:
            collectionView.cancelInteractiveMovement()
            isEditting = false
        }
    }
    
    
    // 删除源  添加到目标数组
    private func handleDataSource(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        let sourceStr = _dataSource[sourceIndexPath.section][sourceIndexPath.row]
        
        _dataSource[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        _dataSource[destinationIndexPath.section].insert(sourceStr, at: destinationIndexPath.row)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let offsetY = collectionView.contentOffset.y
            headerSepLine.isHidden = offsetY > 0 ? false : true
        }
    }
}

extension HomeChannelView: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1111 {
            print("主视图===== + \(scrollView.contentOffset.y)")
            preferredMainTableViewDidScroll(scrollView)
        }else{
            print("子视图----= + \(scrollView.contentOffset.y)")
            preferredSubScrollViewDidScroll(scrollView)
        }
    }
    
    @objc func preferredSubScrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.contentOffset.y < 0 {
            collectionView.contentOffset = CGPoint.zero
        }else{
            self.contentOffset = CGPoint.zero
        }
    }
    
    /// 主tableView 滑动(子类可以重写)
    @objc func preferredMainTableViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y > 0 {
            self.contentOffset = CGPoint.zero
        }
        
        if self.contentOffset.y < 0 {
            collectionView.contentOffset = CGPoint.zero
        }
        
        if self.contentOffset.y > 0 && collectionView.contentOffset.y == 0{
            self.contentOffset = CGPoint.zero
        }
    }
    
}
