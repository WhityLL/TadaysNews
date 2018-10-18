//
//  Video_ActivityList_Cell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/18.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class Video_ActivityList_Cell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img_pic.contentMode = .scaleAspectFill
    }

    var activityVideoModel = VideoActivity_Album_VideoModel() {
        didSet {
           
            if let largeImage = activityVideoModel.raw_data.large_image_list.first {
                img_pic.kf.setImage(with: URL(string: largeImage.urlString)!)
            } else if let firstImage = activityVideoModel.raw_data.first_frame_image_list.first {
                img_pic.kf.setImage(with: URL(string: firstImage.urlString)!)
            }
        }
    }
    
    @IBOutlet weak var img_pic: UIImageView!
}
