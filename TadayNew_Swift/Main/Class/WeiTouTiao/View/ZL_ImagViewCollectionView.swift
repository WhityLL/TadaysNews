//
//  ZL_ImagViewCollectionView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/29.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class ZL_ImagViewCollectionView: UICollectionView{

    var didSelectItemClosure: ((_ selectedIndex: Int)->())?
    /// 是否发布了小视频
    var isPostSmallVideo = false
    /// 是否是动态详情
    var isDongtaiDetail = false
    
    var isWeitoutiao = false
    
    var thumbImages = [ThumbImage]() {
        didSet {
            reloadData()
        }
    }
    
    var largeImages = [LargeImage]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: ZL_ImageViewCollectionViewFlowLayout())
        
        delegate = self
        dataSource = self
        backgroundColor = .clear
        collectionViewLayout = ZL_ImageViewCollectionViewFlowLayout()
        self.register(UINib.init(nibName: "ZL_ImagViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ZL_ImagViewCollectionViewCell")
        isScrollEnabled = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ZL_ImagViewCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZL_ImagViewCollectionViewCell", for: indexPath) as! ZL_ImagViewCollectionViewCell
        cell.thumbImage = thumbImages[indexPath.item]
        cell.isPostSmallVideo = isPostSmallVideo
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = isDongtaiDetail ? Calculate.detailCollectionViewCellSize(thumbImages) : Calculate.collectionViewCellSize(thumbImages.count)
    
        return fixedCollectionCellSize(size: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isWeitoutiao { didSelectItemClosure?(indexPath.item); return }
    }
    
}

class ZL_ImageViewCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 2
        minimumInteritemSpacing = 2
    }
}
