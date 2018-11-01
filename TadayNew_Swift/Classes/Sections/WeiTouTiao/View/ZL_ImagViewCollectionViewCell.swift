//
//  ZL_ImagViewCollectionViewCell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/29.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import SVProgressHUD

class ZL_ImagViewCollectionViewCell: UICollectionViewCell,RegisterCellFromNib {

    var isPostSmallVideo = false {
        didSet {
            btn_icon.setImage(isPostSmallVideo ? UIImage(named: "smallvideo_all_32x32_") : nil, for: .normal)
        }
    }
    
    var thumbImage = ThumbImage() {
        didSet {
            thumbImagView.kf.setImage(with: URL(string: thumbImage.urlString)!)
            lb_gif.isHidden = !(thumbImage.type == .gif)
        }
    }
    
    var largeImage = LargeImage() {
        didSet {
            thumbImagView.kf.setImage(with: URL(string: largeImage.urlString), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                let progress = Float(receivedSize) / Float(totalSize)
                SVProgressHUD.showProgress(progress)
                SVProgressHUD.setBackgroundColor(.clear)
                SVProgressHUD.setForegroundColor(UIColor.white)
            }) { (image, error, cacheType, url) in
                SVProgressHUD.dismiss()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var thumbImagView: UIImageView!
    
    @IBOutlet weak var btn_icon: UIButton!
    
    @IBOutlet weak var lb_gif: UILabel!
}
