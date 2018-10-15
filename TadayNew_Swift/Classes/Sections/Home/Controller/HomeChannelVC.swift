//
//  HomeChannelVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/14.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class HomeChannelVC: BaseViewController {

    /// 是否编辑
    var isEdit = false {
        didSet {
            collectionView.reloadData()
        }
    }
    ///用户已选
    var userSectectedTitles = [HomeNewsTitleModel]()
    ///推荐
    var categories = [HomeNewsTitleModel]()
    
    let identify_ChannelRecomendCell = "ChannelRecomendCell"
    let identify_UserSelectedCell = "UserChannelCell"
    
    let identify_UserSelectedChannelHeaderView = "UserSelectedChannelHeaderView"
    let identify_RecommendChannelHeaderView = "RecommendChannelHeaderView"
    
    private lazy var headerView: UIView = {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: kStatusBarHeight, width: SCREEN_WIDTH, height: 40))
        headerView.backgroundColor = .white
        view.addSubview(headerView)
        
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true // 允许用户多选
        collectionView.addGestureRecognizer(longPressRecognizer)
        
        collectionView.register(UINib.init(nibName: "UserChannelCell", bundle: nil), forCellWithReuseIdentifier:identify_UserSelectedCell)
        collectionView.register(UINib.init(nibName: "ChannelRecomendCell", bundle: nil), forCellWithReuseIdentifier:identify_ChannelRecomendCell)
        
        collectionView.register(UserSelectedChannelHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_UserSelectedChannelHeaderView)
        collectionView.register(RecommendChannelHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_RecommendChannelHeaderView)

        view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        collectionView.reloadData()
        
    }
    
    @objc func btn_closeClick() {
        dismiss(animated: true, completion: nil)
    }

    /// 长按手势
    private lazy var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTarget))
    
    @objc private func longPressTarget(longPress: UILongPressGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "longPressTarget"), object: nil)
        // 选中的 点
        let selectedPoint = longPress.location(in: collectionView)
        // 转换成索引
        if let selectedIndexPath = collectionView.indexPathForItem(at: selectedPoint) {
            switch longPress.state {
            case .began:
                if isEdit && selectedIndexPath.section == 0 { // 选中的是上部的 cell,并且是可编辑状态
                    collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                } else {
                    isEdit = true
                    collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                }
            case .changed:
                // 固定第一、二个不能移动
                if selectedIndexPath.item <= 1 { collectionView.endInteractiveMovement(); break }
                collectionView.updateInteractiveMovementTargetPosition(longPress.location(in: longPressRecognizer.view))
            case .ended:
                collectionView.endInteractiveMovement()
            default:
                collectionView.cancelInteractiveMovement()
            }
        } else {
            // 判断点是否在 collectionView 上
            if selectedPoint.x < collectionView.bounds.minX || selectedPoint.x > collectionView.bounds.maxX || selectedPoint.y < collectionView.bounds.minY || selectedPoint.y > collectionView.bounds.maxY  {
                collectionView.endInteractiveMovement()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension HomeChannelVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let userSelectedHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identify_UserSelectedChannelHeaderView, for: indexPath) as! UserSelectedChannelHeaderView
            
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
    
    /// headerView 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 50)
    }
    
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
            
            cell.delegate = self
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify_ChannelRecomendCell, for: indexPath) as! ChannelRecomendCell
            
            let selectedModel: HomeNewsTitleModel = categories[indexPath.item]
            
            cell.btn_recommendTitle.setTitle(selectedModel.name, for: .normal)
            
            return cell
        }
    }
    
    /// 点击了某一个 cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 点击上面一组，不做任何操作，点击下面一组的cell 会添加到上面的组里
        guard indexPath.section == 1 else { return }
        userSectectedTitles.append(categories[indexPath.item]) // 添加
        collectionView.insertItems(at: [IndexPath(item: userSectectedTitles.count - 1, section: 0)])
        categories.remove(at: indexPath.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath.item, section: 1)])
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// 移动 cell
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 固定第一、二个不能移动
        if destinationIndexPath.item <= 1 {
            collectionView.endInteractiveMovement()
            collectionView.reloadData()
            return
        }
        // 取出需要移动的 cell
        let title = userSectectedTitles[sourceIndexPath.item]
        userSectectedTitles.remove(at: sourceIndexPath.item)
        // 移动 cell
        if isEdit && sourceIndexPath.section == 0 {
            // 说明移动前后都在 第一组
            if destinationIndexPath.section == 0 {
                userSectectedTitles.insert(title, at: destinationIndexPath.item)
            } else { // 说明移动后在 第二组
                categories.insert(title, at: destinationIndexPath.item)
            }
        }
    }
    
    /// 每个 cell 之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
}

extension HomeChannelVC: UserSelctedChannelCellDelegate {
    /// 删除按钮点击
    func deleteChannelButtonClicked(of cell: UserChannelCell) {
        
        // 上部删除，下部添加
        let indexPath = collectionView.indexPath(for: cell)
        
        categories.insert(userSectectedTitles[indexPath!.item], at: 0)
        
        collectionView.insertItems(at: [IndexPath(item: 0, section: 1)])
        
        userSectectedTitles.remove(at: indexPath!.item)
        
        collectionView.deleteItems(at: [IndexPath(item: indexPath!.item, section: 0)])
        
    }
}
