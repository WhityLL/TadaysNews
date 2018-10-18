//
//  Video_ActivityList_HeaderView.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/18.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit

class Video_ActivityList_HeaderView: UICollectionReusableView {

    var clickCheckMoreClosure: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .white
        
        lb_count.edgeInsets = UIEdgeInsets.init(top: 0, left: 6, bottom: 0, right: 6)
        lb_count.layer.cornerRadius = 10
        lb_count.layer.masksToBounds = true
        
    }
    
    var album_info = VideoActivity_Album_InfoModel() {
        didSet {
            avatar.kf.setImage(with: URL.init(string: album_info.album_icon_url))
            lb_title.text = album_info.album_name
            lb_desc.text = album_info.album_label
            lb_count.text = album_info.album_participate_info
        }
    }
    @IBAction func btn_checkMoreClick(_ sender: Any) {
        clickCheckMoreClosure?()
    }
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_desc: UILabel!
    @IBOutlet weak var lb_count: ZL_EdgeInsetsLabel!
    
}
