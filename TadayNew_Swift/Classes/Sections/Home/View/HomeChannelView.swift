//
//  HomeChannelView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/14.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class HomeChannelView: UIView {
    
    var channelPopViewCloseClosure: (() -> ())?
    
    /// 是否编辑
    var isEdit = false {
        didSet {
            collectionView.reloadData()
        }
    }
    ///用户已选
    var userSectectedTitles = [HomeNewsTitleModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    ///推荐
    var categories = [HomeNewsTitleModel]()
    
    let identify_ChannelRecomendCell = "ChannelRecomendCell"
    let identify_UserSelectedCell = "UserChannelCell"
    
    let identify_UserSelectedChannelHeaderView = "UserSelectedChannelHeaderView"
    let identify_RecommendChannelHeaderView = "RecommendChannelHeaderView"
    
    
    private lazy var headerView: UIView = {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        headerView.backgroundColor = .white
        addSubview(headerView)
        
        let btn_close: UIButton = UIButton.init(type: .custom)
        headerView.addSubview(btn_close)
        btn_close.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        btn_close.setImage(UIImage.init(named: "small_video_close_night"), for: .normal)
        btn_close.addTarget(self, action: #selector(btn_closeClick), for: .touchUpInside)
        return headerView
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let itemWidth = (SCREEN_WIDTH - 1) * 0.5
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 50) * 0.25, height: 44)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let collectionView: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: headerView.bottom, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - headerView.bottom), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = ZLBgColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.register(UINib.init(nibName: "UserChannelCell", bundle: nil), forCellWithReuseIdentifier:identify_UserSelectedCell)
        collectionView.register(UINib.init(nibName: "ChannelRecomendCell", bundle: nil), forCellWithReuseIdentifier:identify_ChannelRecomendCell)
        
        collectionView.register(UserSelectedChannelHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_UserSelectedChannelHeaderView)
        collectionView.register(RecommendChannelHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_RecommendChannelHeaderView)
        
        addSubview(collectionView)
        return collectionView
    }()
    
    
    /// 长按移动手势
    private lazy var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTarget))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        // 点击首页加号按钮，获取频道推荐数据
        NetManager.loadHomeCategoryRecommend { recommendTitles in
            self.categories.append(contentsOf: recommendTitles)
            self.collectionView.reloadData()
        }
        
        longPressRecognizer.minimumPressDuration = 0.3; //时间长短
        collectionView.addGestureRecognizer(longPressRecognizer)
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? userSectectedTitles.count : categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify_UserSelectedCell, for: indexPath) as! UserChannelCell
            
            let selectedModel: HomeNewsTitleModel = userSectectedTitles[indexPath.item]
            
            cell.btn_title.setTitle(selectedModel.name, for: .normal)
            
            cell.isEdit = isEdit
            
            cell.isFixed = (selectedModel.name == "推荐" || selectedModel.name == "关注") ? true : false
            
            cell.delegate = self
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify_ChannelRecomendCell, for: indexPath) as! ChannelRecomendCell
            
            let selectedModel: HomeNewsTitleModel = categories[indexPath.item]
            
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
                if !sender.isSelected { collectionView.endInteractiveMovement() }
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
        
        // 上部添加，下部删除
        userSectectedTitles.append(categories[indexPath.item]) //添加
        categories.remove(at: indexPath.item)
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section == 0 else { return false}
        if indexPath.item > 1 {
            return true
        }
        return false
    }
    
    /// 移动 cell
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 取出需要移动的Model
        let title = userSectectedTitles[sourceIndexPath.item]
        userSectectedTitles.remove(at: sourceIndexPath.item)
        
        // 说明移动前后都在 第一组
        if destinationIndexPath.section == 0 {
            userSectectedTitles.insert(title, at: destinationIndexPath.item)
        } else { // 说明移动后在 第二组
            categories.insert(title, at: 0)
        }
    }
}

extension HomeChannelView: UserSelctedChannelCellDelegate {
    /// 删除按钮点击
    func deleteChannelButtonClicked(of cell: UserChannelCell) {
        // 上部删除，下部添加
        let indexPath = collectionView.indexPath(for: cell)
        
        categories.insert(userSectectedTitles[indexPath!.item], at: 0)
        userSectectedTitles.remove(at: indexPath!.item)
        
        collectionView.reloadData()
    }
}

extension HomeChannelView {

    @objc private func longPressTarget(longPress: UILongPressGestureRecognizer) {
        
        // 选中的点
        let selectedPoint = longPress.location(in: collectionView)
        // 以下代码如果抽取（guard let selectedIndexPath = self.collectionView.indexPathForItem(at: selectedPoint) else {break}）
        // 会引起拖动的item位置，导致crash
        
        switch longPress.state {
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: selectedPoint) else {break}
            if isEdit {
                self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            }else{
                isEdit = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                }
            }
            
            if selectedIndexPath.section == 0 {
                let cell = self.collectionView.cellForItem(at: selectedIndexPath)
                cell?.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            }
            
        case .changed:
            guard let targetIndexPath = self.collectionView.indexPathForItem(at: selectedPoint) else {break}
            // 固定第一、二个不能移动
            if targetIndexPath.item <= 1 || targetIndexPath.section > 0 {
                collectionView.endInteractiveMovement()
                break
            }
            collectionView.updateInteractiveMovementTargetPosition(longPress.location(in: longPressRecognizer.view))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
}

