//
//  WeiTouTiaoCell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/29.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class WeiTouTiaoCell: UITableViewCell,RegisterCellFromNib {

    
    var didSelectSubImageViewCellClasure: ((_ selectedIndex: Int)->())?
    
    var aNews = NewsModel() {
        didSet {
            imgv_avatar.kf.setImage(with: URL(string: aNews.user.avatar_url))
            imgv_vip.isHidden = !aNews.user.user_verified
            lb_name.text = aNews.user.name
            lb_timeAndDesc.text = aNews.createTime + (aNews.user.verified_content != "" ? (" · \(aNews.user.user_verified)") : "")
            
            btn_concern.isSelected = aNews.user.is_following
            btn_like.setTitle(aNews.digg_count == 0 ? "赞" : aNews.diggCount, for: .normal)
            btn_like.isSelected = aNews.user_digg
            btn_comment.setTitle(aNews.commentCount, for: .normal)
            btn_forward.setTitle(aNews.forward_info.forwardCount, for: .normal)
            

            // 显示 emoji
            lb_content.attributedText = aNews.attributedContent
            lb_content_height.constant = aNews.contentH
            
            midView_height.constant = aNews.collectionViewH
            layoutIfNeeded()
            
            if #available(iOS 11.0, *) {
                if midView.contains(collectionView) { collectionView.removeFromSuperview() }
            } else {
                // Fallback on earlier versions
            }
            
            if aNews.thumb_image_list.count != 0 {
                midView.addSubview(collectionView)
                collectionView.frame = CGRect(x: 0, y: 0, width: aNews.collectionViewW, height: aNews.collectionViewH)
                collectionView.thumbImages = aNews.thumb_image_list
                collectionView.largeImages = aNews.large_image_list
                collectionView.isWeitoutiao = true
                collectionView.didSelectItemClosure = { [weak self] (selectedIndex) in
                    self!.didSelectSubImageViewCellClasure?(selectedIndex)
                }
            }
            
            self.height = bottomView.bottom
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        topView.backgroundColor = .white
        lb_content.backgroundColor = .white
        midView.backgroundColor = .white
        bottomView.backgroundColor = .white
        
        lb_name.font = UIFont.boldSystemFont(ofSize: 13)
        lb_name.textColor = ZLBlackTextColor()
        
        lb_timeAndDesc.font = UIFont.systemFont(ofSize: 13)
        lb_timeAndDesc.textColor = ZLGrayTextColor()
        
        btn_concern.setTitle("关注", for: .normal)
        btn_concern.setTitle("已关注", for: .selected)
        btn_concern.setTitleColor(ZLGlobalRedColor(), for: .normal)
        btn_concern.setTitleColor(ZLGrayTextColor(), for: .selected)
        
        sepView_Bottom.backgroundColor = ZLSeperateColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private lazy var  collectionView = ZL_ImagViewCollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    
    /// Top
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imgv_avatar: UIImageView!
    
    @IBOutlet weak var imgv_vip: UIImageView!
    
    @IBOutlet weak var lb_name: UILabel!
    
    @IBOutlet weak var lb_timeAndDesc: UILabel!
    
    @IBOutlet weak var btn_concern: UIButton!
    
    @IBOutlet weak var btn_close: UIButton!
    
    @IBOutlet weak var btn_corver: UIButton!
    
    @IBOutlet weak var lb_content: UILabel!
    
    @IBOutlet weak var lb_content_height: NSLayoutConstraint!
    
    ///Mid
    
    @IBOutlet weak var midView: UIView!
    
    @IBOutlet weak var midView_height: NSLayoutConstraint!
    
   /// Foot
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var sepView_Bottom: UIView!
    
    @IBOutlet weak var btn_forward: UIButton!
    
    @IBOutlet weak var btn_comment: UIButton!
    
    @IBOutlet weak var btn_like: UIButton!
    
}
