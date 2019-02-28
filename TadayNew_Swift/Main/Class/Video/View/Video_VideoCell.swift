//
//  Video_VideoCell.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/10.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import SVProgressHUD

class Video_VideoCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        
        lb_title.font = AdaptedSystomBlodFont(size: 16)
        lb_title.textColor = .white
        
        lb_diggCount.textColor = .white
        lb_diggCount.font = AdaptedSystomFont(size: 10)
        
        lb_playCount.textColor = .white
        lb_playCount.font = AdaptedCustomFont(size: 10)
        
        addGradientLayer()
    }

    func addGradientLayer() {
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor.init(white: 0, alpha: 0.1)
        let buttomColor = UIColor.init(white: 0, alpha: 0.3)
    
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, buttomColor.cgColor]
        
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        gradientLayer.locations = gradientLocations
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: (SCREEN_WIDTH - 1)/2, height: (SCREEN_WIDTH - 1)/2*1.6)
        imageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    var smallVideo = NewsModel() {
        didSet {
            lb_title.attributedText = smallVideo.raw_data.attrbutedText
            
            if let largeImage = smallVideo.raw_data.large_image_list.first {
                imageView.kf.setImage(with: URL(string: largeImage.urlString)!)
            } else if let firstImage = smallVideo.raw_data.first_frame_image_list.first {
                imageView.kf.setImage(with: URL(string: firstImage.urlString)!)
            }
            
            lb_diggCount.text = smallVideo.raw_data.action.diggCount + "赞"
            lb_playCount.text = smallVideo.raw_data.action.playCount + "次播放"
        }
    }

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lb_title: UILabel!
    
    @IBOutlet weak var lb_playCount: UILabel!
    
    @IBOutlet weak var lb_diggCount: UILabel!
    
    @IBAction func btn_close(_ sender: Any) {
        SVProgressHUD.showInfo(withStatus: "不感兴趣？")
    }
}
