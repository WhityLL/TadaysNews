//
//  VideoVC_VideoListVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/10.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class VideoVC_VideoListVC: BaseViewController {
    
    var categary : NewsTitleCategory = .recommend

    /// 数据
    var dataArr = [NewsModel]()
    /// 刷新时间
    var maxBehotTime: TimeInterval = Date().timeIntervalSince1970
    /// TTFrom
    var ttfrom: TTFrom = .enterAuto
    /// listCount
    var listCount : Int = 6
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let itemWidth = (SCREEN_WIDTH - 1) * 0.5
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 1, right: 0)
        
        let collectionView: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - kTabbarHeight), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib.init(nibName: "Video_VideoCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresh()
    }

}

extension VideoVC_VideoListVC : UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : Video_VideoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Video_VideoCell
        
        cell.smallVideo = self.dataArr[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击=\(indexPath.item)")
        self.togoIJKLiveVC(indexPath: indexPath);
    }
}

extension VideoVC_VideoListVC {
    
    private func setupRefresh() {
        collectionView.addHeaderGifRefresh {
            self.ttfrom = .pull
            self.maxBehotTime = Date().timeIntervalSince1970
            self.requestData()
        }
        
        collectionView.addFooterGifRefresh {
            self.ttfrom = .loadMore
            self.requestData()
        }
        
        collectionView.beginHeaderRefresh()
    }
    
    private func requestData() {
  
        NetManager.loadApiNewsFeeds(apiFrom: .smallVideo, category: self.categary, ttFrom: self.ttfrom, maxBehotTime: self.maxBehotTime, listCount: self.listCount) { (aNewsModelList) in
            
            if self.collectionView.mj_header.isRefreshing {self.collectionView.endHeaderRefresh()}
            if self.collectionView.mj_footer.isRefreshing {self.collectionView.endFooterRefresh()}
            
            if (self.ttfrom == TTFrom.pull || self.ttfrom == TTFrom.enterAuto) { self.dataArr.removeAll() }
            
            self.dataArr.append(contentsOf: aNewsModelList)
            
            self.listCount = self.dataArr.count > 0 ? self.dataArr.count : 6
            
            self.collectionView.reloadData()
            
        }
    }
    
    /// 跳转到直播
    private func togoIJKLiveVC(indexPath: IndexPath) {
        let liveData = self.dataArr[indexPath.item] as NewsModel
        print(liveData)
        
        let ijkVideoPlayVC = IJKVideo_PlayVC()
        ijkVideoPlayVC.liveData = liveData
        self.present(ZL_NaviVC.init(rootViewController: ijkVideoPlayVC), animated: true, completion: nil)
    }
}
