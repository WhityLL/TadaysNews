//
//  LiveModel.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/11.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import HandyJSON

struct BaseLiveModel : HandyJSON {
    var message: String = ""
    var total_number: Int = 0
    var has_more: Bool = false
    var login_status: Int = 0
    var show_et_status: Int = 0
    var post_content_hint: String = ""
    var has_more_to_refresh: Bool = false
    var action_to_last_stick: Int = 0
    var feed_flag: Int = 0
    var tips = Tips()
    var data = [LiveContent]()
}

struct Tips : HandyJSON {
    var type: String = ""
    var display_duration: Int = 0
    var display_info: String = ""
    var display_template: String = ""
    var open_url: String = ""
    var web_url: String = ""
    var download_url: String = ""
    var app_name: String = ""
    var package_name: String = ""
}

struct LiveContent : HandyJSON {
    var code : String = ""
    var content: String = ""
}

/// LiveModel 是 LiveContent["content"]解析后的结果
struct LiveModel: HandyJSON {
    
    var abstract: String = ""
    var allow_download: Int = 0
    var article_sub_type: Int = 0
    var article_type: Int = 0
    var ban_comment: Int = 0
    var behot_time: Int = 0
    var bury_count: Int = 0
    var cell_ctrls = CellFLag()
    var cell_type: Int = 0
    var comment_count: Int = 0
    var content_decoration: String = ""
    var cursor: Int = 0
    var data_type: Int = 0
    var digg_count: Int = 0
    var has_m3u8_video: Int = 0
    var has_mp4_video: Int = 0
    var has_video: Int = 0
    var hot = 0
    var id = 6610943842881391363
    var ignore_web_transform: Int = 0
    var interaction_data: String = ""
    var is_subject: Int = 0
    var item_version: Int = 0
    var level = 0
    var log_pb = LogPB()
    var read_count: Int = 0
    var req_id: String = ""
    var rid: String = ""
    var share_count: Int = 0
    var share_info: String = ""
    var show_dislike: Int = 0
    var show_portrait: Int = 0
    var show_portrait_article: Int = 0
    var tip = 0
    var ugc_recommend = UGCRecommend()
    var user_repin: Int = 0
    var user_verified: Int = 0
    var verified_content: String = ""
    var video_style: Int = 0
    
    var raw_data = RawData()
}

struct CellFLag : HandyJSON{
    var cell_height: Int = 0
    var cell_layout_style: String = ""
    var content_decoration: String = ""
    var need_client_impr_recycle: String = ""
}

struct RawData : HandyJSON {
    
    var group_id: Int = 0
    var group_source: Int = 0
    var impression_extra: String = ""
    var lottery_info: String = ""
    var share_url: String = ""
    var short_id: Int = 0
    var title: String = ""
    
    var activity_tag = ActivityTag()
    var large_image = LargeImage()
    var user_info = LiveUserinfo()
    var filter_words = [FilterWords]()
    var live_info = Liveinfo()
}

struct ActivityTag: HandyJSON {
    var ActivityType: Int = 0
    var Extra: String = ""
    var Name: String = ""
    var Url: String = ""
}

struct FilterWords: HandyJSON {
    var id: String = "" // "9:1"
    var is_selected: Int = 0
    var name: String = ""
}


struct Liveinfo: HandyJSON{
    
    var create_time: Int = 0
    var orientation: Int = 0 // 0: 直播、 1:秀场
    var room_id: String = ""
    var schema: String = ""
    var watching_count: Int = 0
    var watching_count_str: String = ""
    var stream_url = LiveStreamURL()
}

struct LiveStreamURL:  HandyJSON{
    var alternate_pull_url: String = ""
    var create_time: Int = 0
    var flv_pull_url: String = ""
    var stream_id: Int = 0
    var PullURL = PullURLModel()
    var PullURLList = [PullURLListModel]()
}

struct PullURLModel : HandyJSON {
    var FULL_HD1 = PullURLListModel()
    var HD1 = PullURLListModel()
    var SD1 = PullURLListModel()
    var SD2 = PullURLListModel()
}

struct PullURLListModel : HandyJSON {
    var Flv: String = ""
    var Hls: String = ""
    var Name: String = ""
    var Rtmp: String = ""
}

struct LiveUserinfo: HandyJSON{
    
    var all_live_info: String = ""
    var author_desc: String = ""
    var author_info: String = ""
    var avatar_url: String = ""
    var description: String = ""
    var extend_info: String = ""
    var follow = 0;
    var followers_count: Int = 0
    var following_count: Int = 0
    var is_living: Int = 0
    var live_info: String = ""
    var live_orientation: String = ""
    var media_id: Int = 0
    var media_live_info: String = ""
    var name: String = ""
    var ugc_publish_media_id: Int = 0
    var user_auth_info: String = ""
    var user_id: Int = 0
    var user_verified: Int = 0
    var verified_content: String = ""
    var video_live_auth: Int = 0
    
}
