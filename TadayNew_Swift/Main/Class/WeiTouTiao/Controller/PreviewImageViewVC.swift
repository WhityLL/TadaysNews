//
//  PreviewImageViewVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/30.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

/// 图片预览VC

import UIKit

class PreviewImageViewVC: UIViewController {

    var images = [LargeImage]()
    
    var selectedIndex: Int = 0
    
    private lazy var lb_num: UILabel = {
        let lb_num = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 18))
        lb_num.textAlignment = .center
        lb_num.textColor = ZLGrayTextColor()
        lb_num.font = AdaptedCustomFont(size: 14)

        return lb_num
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = view.bounds.size
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.register(UINib.init(nibName: "ZL_ImagViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ZL_ImagViewCollectionViewCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(collectionView)
        
        view.addSubview(lb_num)
        lb_num.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(10)
            make.size.equalTo(CGSize.init(width: 40, height: 18))
            make.bottom.equalTo(-10)
        }
        lb_num.text = "\(selectedIndex + 1)/\(images.count)"
        
        // 如果调用scrollToItemAtIndexPath不起作用, 需要先调用layoutIfNeeded方法
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
       
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension PreviewImageViewVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZL_ImagViewCollectionViewCell", for: indexPath) as! ZL_ImagViewCollectionViewCell
        
        cell.largeImage = images[indexPath.item]
        cell.thumbImagView.contentMode = .scaleAspectFit
        cell.thumbImagView.layer.borderWidth = 0
        cell.backgroundColor = .black
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: false, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        selectedIndex = Int(scrollView.contentOffset.x / SCREEN_WIDTH + 0.5)
        lb_num.text = "\(selectedIndex + 1)/\(images.count)"
    }
    
}
