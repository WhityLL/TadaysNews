//
//  Video_ActivityListVC.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/17.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import MJRefresh
import SDCycleScrollView

class Video_ActivityListVC: BaseViewController {

    let bannerHeight: CGFloat = 180
    
    /// 数据
    var dataArr = [Any]()
    /// TTFrom
    var ttfrom: TTFrom = .refresh
    /// listCount
    var listCount : Int = 0
    
    private lazy var bannerView: SDCycleScrollView = {
        let bannerView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: bannerHeight), delegate: self, placeholderImage: PlaceHolder_270_90)!
        bannerView.autoScrollTimeInterval = 4
        return bannerView
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let itemWidth = (SCREEN_WIDTH - 4) / 3
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 2, right: 0)
        
        let collectionView: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - kTabbarHeight), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.register(UINib.init(nibName: "Video_ActivityList_HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Video_ActivityList_HeaderView")
        collectionView.register(UINib.init(nibName: "Video_ActivityList_Cell", bundle: nil), forCellWithReuseIdentifier: "Video_ActivityList_Cell")
        
        view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestData()

    }

}

extension Video_ActivityListVC: SDCycleScrollViewDelegate{
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("选择了\(index)")
    }
    
    func togoMoreVideoVC() {
        
        let vc = ZL_PagerListController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension Video_ActivityListVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let albumModel: VideoActivity_AlbumModel = self.dataArr[section] as! VideoActivity_AlbumModel
        return albumModel.video_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : Video_ActivityList_Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Video_ActivityList_Cell", for: indexPath) as! Video_ActivityList_Cell
        
        let albumModel: VideoActivity_AlbumModel = self.dataArr[indexPath.section] as! VideoActivity_AlbumModel
        
        let albumModel_video = albumModel.video_list[indexPath.item]
        
        cell.activityVideoModel = albumModel_video
        
        return cell
    }
    
    /// headerView 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 62)
    }
    
    /// 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Video_ActivityList_HeaderView", for: indexPath) as! Video_ActivityList_HeaderView
        
        let albumModel: VideoActivity_AlbumModel = self.dataArr[indexPath.section] as! VideoActivity_AlbumModel
        
        let album_info = albumModel.album_info
        
        headerView.album_info = album_info
        
        headerView.clickCheckMoreClosure = {
            
            self.togoMoreVideoVC()
            
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击=\(indexPath.item)")
    }
}

extension Video_ActivityListVC {
    
    private func setupRefresh() {
        collectionView.addHeaderGifRefresh {
            self.ttfrom = .refresh
            self.collectionView.resetNoMoreData()
            self.listCount = 0
            self.requestData()
        }
        collectionView.mj_header.ignoredScrollViewContentInsetTop = self.collectionView.contentInset.top
        collectionView.mj_header.ignoredScrollViewContentInsetTop = bannerHeight
        
        collectionView.addFooterGifRefresh {
            self.ttfrom = .loadmore
            self.listCount = 10
            self.requestData()
        }
    }
    
    private func requestData() {
        
        NetManager.loadVideoActivityData(ttFrom: self.ttfrom, listCount: self.listCount) { (activityData: VideoActivityModel) in
            
            if self.collectionView.mj_header != nil {
                if self.collectionView.mj_header.isRefreshing {self.collectionView.endHeaderRefresh()}
            }
            if self.collectionView.mj_footer != nil {
                if self.collectionView.mj_footer.isRefreshing {self.collectionView.endFooterRefresh()}
            }
            if (self.ttfrom == TTFrom.pull || self.ttfrom == TTFrom.refresh) { self.dataArr.removeAll() }
            
            self.dataArr.append(contentsOf: activityData.album_list)
            
            self.listCount = self.dataArr.count
            
            if activityData.banner_list.count == 0 {
                self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                self.bannerView.isHidden = true
                
            }else{
                self.collectionView.contentInset = UIEdgeInsets.init(top: self.bannerHeight, left: 0, bottom: 0, right: 0)
                self.bannerView.frame = CGRect.init(x: 0, y: -self.bannerHeight, width: SCREEN_WIDTH, height: self.bannerHeight)
                self.bannerView.isHidden = false
                self.collectionView.addSubview(self.bannerView)

                var imgGrounp = [String]()
                for bannerModel in activityData.banner_list{
                    imgGrounp.append(bannerModel.banner_image_url)
                }
                self.bannerView.imageURLStringsGroup = imgGrounp
            }
            
            self.collectionView.reloadData()
            
            if !activityData.has_more {
                self.collectionView.noticeNoMoreData()
            }
                
            self.setupRefresh()
        }
    }
    
}
