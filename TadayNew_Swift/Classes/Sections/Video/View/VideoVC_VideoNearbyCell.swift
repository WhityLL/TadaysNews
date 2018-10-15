//
//  VideoVC_VideoNearbyCell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/11.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class VideoVC_VideoNearbyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgv_pic.backgroundColor = .white
        imgv_pic.contentMode = .scaleAspectFill
        imgv_pic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - ========= Setter ==========
    var video = NewsModel() {
        didSet {
            // 视频信息
            if let largeImage = video.raw_data.large_image_list.first {
                imgv_pic.kf.setImage(with: URL(string: largeImage.urlString)!)
            } else if let firstImage = video.raw_data.first_frame_image_list.first {
                imgv_pic.kf.setImage(with: URL(string: firstImage.urlString)!)
            }
            
            if video.raw_data.action.forward_count > 0 {
                btn_transport.setTitle("\(video.raw_data.action.forwardCount)", for: .normal)
            }
            
            if video.raw_data.action.comment_count > 0 {
                btn_comment.setTitle("\(video.raw_data.action.commentCount)", for: .normal)
            }
            if video.raw_data.action.digg_count > 0 {
                btn_lick.setTitle("\(video.raw_data.action.diggCount)", for: .normal)
            }
        }
    }
    
    
    @IBOutlet weak var imgv_pic: UIImageView!
    
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var btn_transport: UIButton!
    @IBOutlet weak var btn_comment: UIButton!
    
    @IBOutlet weak var btn_lick: UIButton!
    
    @IBAction func btnTransportClick(_ sender: Any) {
    }
    @IBAction func btnCommentClick(_ sender: Any) {
    }
    @IBAction func btnLikeClick(_ sender: Any) {
    }
    @IBAction func btnPlayClick(_ sender: Any) {
    }
    
}
