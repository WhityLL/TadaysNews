//
//  Live_VideoCell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/11.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import Kingfisher

class Live_VideoCell: UITableViewCell {

    var playBtnClickClosure: (() -> ())?
    
    static let cellHeight: CGFloat = (SCREEN_HEIGHT - kNavigationBarHeight - kTabbarHeight)/2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        controlView.backgroundColor = UIColor.clear
        
        imgv_video.contentMode = .scaleAspectFill
        btn_play.showsTouchWhenHighlighted = false
        
        lb_title.font = AdaptedSystomBlodFont(size: 16)
        lb_playCount.font = AdaptedSystomFont(size: 13)
        
        lb_timeLimit.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        lb_timeLimit.layer.cornerRadius = 12
        lb_timeLimit.layer.masksToBounds = true
        
        btn_avatar.layer.cornerRadius = 16
        btn_avatar.layer.masksToBounds = true
        btn_avatar.showsTouchWhenHighlighted = false
        
        btn_auther.titleLabel?.font = AdaptedSystomBlodFont(size: 13)
        btn_auther.setTitleColor(ZLBlackTextColor(), for: .normal)
        
        btn_care.layer.borderColor = ZLSeperateColor().cgColor
        btn_care.layer.borderWidth = 1
        btn_care.layer.cornerRadius = 4
        btn_care.layer.masksToBounds = true
        btn_care.setTitleColor(ZLGlobalRedColor(), for: .normal)
        
        addGradientLayer()
    }
    
    func addGradientLayer() {
        
        let topColor = UIColor.init(white: 0, alpha: 0.5)
        let buttomColor = UIColor.init(white: 0, alpha: 0.1)
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, buttomColor.cgColor] //定义渐变的颜色（从黄色渐变到橙色）
        gradientLayer.locations = [0.0, 1.0]   //定义每种颜色所在的位置
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 0.71 - 55)
        controlView.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - ========= Setter ==========
    var video = NewsModel() {
        didSet {
            // 视频信息
            lb_title.text = video.title
            lb_playCount.text = video.video_detail_info.videoWatchCount + "次播放"
            lb_timeLimit.text = video.videoDuration
            btn_comment.setTitle("\(video.diggCount)", for: .normal)
            if video.video_detail_info.detail_video_large_image.urlString.count > 0 {
               imgv_video.kf.setImage(with: URL(string: video.video_detail_info.detail_video_large_image.urlString)!)
            } else if let largeImage = video.raw_data.large_image_list.first {
                imgv_video.kf.setImage(with: URL(string: largeImage.urlString)!)
            } else if let firstImage = video.raw_data.first_frame_image_list.first {
                imgv_video.kf.setImage(with: URL(string: firstImage.urlString)!)
            }
            
            // 作者信息
            btn_avatar.kf.setImage(with: URL(string: video.user_info.avatar_url), for: .normal)
            btn_auther.setTitle("\(video.user_info.name)", for: .normal)
        }
    }
    
    var liveData = LiveModel() {
        didSet {
            // 视频信息
            lb_title.text = liveData.raw_data.title
            lb_playCount.text = liveData.raw_data.live_info.watching_count_str
            lb_timeLimit.isHidden = true
            btn_comment.isHidden = true
            
            if liveData.raw_data.large_image.urlString.count > 0 {
                imgv_video.kf.setImage(with: URL(string: liveData.raw_data.large_image.urlString)!)
            }

            // 作者信息
            btn_avatar.kf.setImage(with: URL(string: liveData.raw_data.user_info.avatar_url), for: .normal)
            btn_auther.setTitle("\(liveData.raw_data.user_info.name)", for: .normal)
        }
    }
    
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var imgv_video: UIImageView!
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_playCount: UILabel!
    @IBOutlet weak var lb_timeLimit: UILabel!
    @IBOutlet weak var btn_avatar: UIButton!
    @IBOutlet weak var btn_auther: UIButton!
    @IBOutlet weak var btn_comment: UIButton!
    @IBOutlet weak var btn_care: UIButton!
    @IBOutlet weak var btn_share: UIButton!
    
    @IBAction func playClick(_ sender: Any) {
        playBtnClickClosure?()
    }
    
    @IBAction func clickAvatar(_ sender: Any) {
    }
    
    @IBAction func clickAuther(_ sender: Any) {
    }
    
    @IBAction func clickCare(_ sender: Any) {
    }
    
    @IBAction func clickComment(_ sender: Any) {
    }
    
    @IBAction func clickShare(_ sender: Any) {
        
    }
    
    
}
