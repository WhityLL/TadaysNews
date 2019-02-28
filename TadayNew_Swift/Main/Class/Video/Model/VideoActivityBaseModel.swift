//
//  VideoActivityBaseModel.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/17.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import HandyJSON

struct VideoActivityBaseModel: HandyJSON {
    var message: String = ""
    var data = VideoActivityModel()
}

struct VideoActivityModel: HandyJSON {
    var message: String = ""
    var album_list = [VideoActivity_AlbumModel]()
    var banner_list = [VideoActivity_BannerModel]()
    var has_more = false
}

struct VideoActivity_BannerModel: HandyJSON {
    var banner_image_url: String = ""
    var banner_name: String = ""
    var banner_id: Int = 0
    var banner_type: Int = 0
    var relative_id: Int = 0
}

struct VideoActivity_AlbumModel: HandyJSON {
    var album_info = VideoActivity_Album_InfoModel()
    var video_list = [VideoActivity_Album_VideoModel]()
}

struct VideoActivity_Album_InfoModel: HandyJSON {
    var album_icon_url: String = ""
    var album_detail_schema: String = ""
    var album_name: String = ""
    var album_label: String = ""
    var album_participate_info: String = ""
    var album_id: Int = 0
    var album_type: Int = 0
    var album_extra = VideoActivity_Album_ExtraModel()
}

struct VideoActivity_Album_ExtraModel: HandyJSON {
    var forum_id: String = ""
}

struct VideoActivity_Album_VideoModel: HandyJSON {
    var sort_type: Int = 0
    var seq: Int = 0
    var cursor: Int = 0
    var top_cursor: Int = 0
    var log_pb = VideoActivity_Album_Video_Log_pbModel()
    var raw_data = VideoActivity_Album_Video_Raw_dataModel()
}

struct VideoActivity_Album_Video_Log_pbModel: HandyJSON {
    var impr_id: String = ""
}

struct VideoActivity_Album_Video_Raw_dataModel: HandyJSON {
    var group_id: Int = 0
    var group_source: Int = 0
    var create_time: Int = 0
    var item_id: Int = 0
    var title: String = ""
    var recommand_reason: String = ""
    var detail_schema: String = ""
    var app_schema: String = ""
    var label: String = ""
    var distance: String = ""
    var label_for_list: String = ""
    var title_rich_span: String = ""
    var rich_title: String = ""
    var from_type: Int = 0
    var extra: String = ""
    
    var large_image_list = [LargeImage]()
    var thumb_image_list = [ThumbImage]()
    
    var first_frame_image_list = [FirstFrameImage]()
    
    var action = SmallVideoAction()
    var app_download = AppDownload()
    var share = Share()
    var status = Status()
    var publish_reason = PublishReason()
    var music = Music()
    var user = User()
    var video = Video()
    var activity = Activity()

}

struct Activity: HandyJSON {
    var from_type: Int = 0
    var extra: String = ""
    var name: String = ""
    var open_url: String = ""
    var activity_info: String = ""
    var forum_id: Int = 0
    var show_on_list: Int = 0
    var concern_id: Int = 0
    var rank: Int = 0
    var forum_type: Int = 0
}
