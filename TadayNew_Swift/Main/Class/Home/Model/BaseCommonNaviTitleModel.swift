//
//  BaseCommonNaviTitleModel.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/9.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import HandyJSON

struct BaseCommonNaviTitleModel: HandyJSON {

    var message: String = ""
    var data : CommonNaviTitleModel = CommonNaviTitleModel()
    
}

struct CommonNaviTitleModel: HandyJSON {
    var message: String = ""
    var version: String = ""
    var data: Array<HomeNewsTitleModel> = [HomeNewsTitleModel]()
}

struct HomeNewsTitleModel: HandyJSON {
    // news_hot(热点),news_local（地区），video（视频），news_society（社会），组图（图片）
    // news_entertainment（娱乐），news_tech（科技），news_car（汽车），news_finance（财经）
    // news_military（军事），news_sports（体育），essay_joke（段子），image_ppmm（街拍），
    // news_world（国际），image_funny（趣图），news_health（健康），jinritemai（特卖，有链接）
    // news_house（房产），news_fashion（时尚），news_history（历史），news_baby（育儿）
    // funny（搞笑），digital（数码），news_food（美食），news_regimen（养生），
    // movie（电影），cellphone（手机），news_travel（旅游），宠物（宠物），emotion（情感）
    // news_home（家居），news_edu（教育），news_agriculture（三农），pregnancy（孕产），
    // news_culture（文化），news_game（游戏），stock（股票），science_all（科学），news_comic（动漫）
    // news_story（故事），news_collect（收藏），boutique（精选），essay_saying（语录）
    // news_astrology（星座），image_wonderful（美图），rumor（辟谣），positive（正能量）
    var category: NewsTitleCategory = .recommend
    var tip_new: Int = 0
    var default_add: Int = 0
    var web_url: String = ""
    var concern_id: String = ""
    var icon_url: String = ""
    var flags: Int = 0
    var type: Int = 0
    var name: String = ""
    var stick: Int? = 1
    
    var selected: Bool = true
}

/// 新闻标题的分类
enum NewsTitleCategory: String, HandyJSONEnum {
    ///关注
    case care = "关注"
    /// 图片,组图
    case photos = "组图"
    /// 视频
    case video = "video"
    /// 推荐
    case recommend = "__all__"
    /// 直播
    case live_talk = "live_talk"
    /// 直播
    case live = "live"
    /// 热点
    case hot = "news_hot"
    /// 地区
    case local = "news_local"
    /// 社会
    case society = "news_society"
    /// 娱乐
    case entertainment = "news_entertainment"
    /// 科技
    case newsTech = "news_tech"
    /// 科技
    case car = "news_car"
    /// 财经
    case finance = "news_finance"
    /// 军事
    case military = "news_military"
    /// 体育
    case sports = "news_sports"
    /// 段子
    case essayJoke = "essay_joke"
    /// 街拍
    case imagePPMM = "image_ppmm"
    /// 趣图
    case imageFunny = "image_funny"
    /// 美图
    case imageWonderful = "image_wonderful"
    /// 国际
    case world = "news_world"
    /// 搞笑
    case funny = "funny"
    /// 健康
    case health = "news_health"
    /// 特卖
    case jinritemai = "jinritemai"
    /// 房产
    case house = "news_house"
    /// 时尚
    case fashion = "news_fashion"
    /// 历史
    case history = "news_history"
    /// 育儿
    case baby = "news_baby"
    /// 数码
    case digital = "digital"
    /// 语录
    case essaySaying = "essay_saying"
    /// 星座
    case astrology = "news_astrology"
    /// 辟谣
    case rumor = "rumor"
    /// 正能量
    case positive = "positive"
    /// 动漫
    case comic = "news_comic"
    /// 故事
    case story = "news_story"
    /// 收藏
    case collect = "news_collect"
    /// 精选
    case boutique = "boutique"
    /// 孕产
    case pregnancy = "pregnancy"
    /// 文化
    case culture = "news_culture"
    /// 游戏
    case game = "news_game"
    /// 股票
    case stock = "stock"
    /// 科学
    case science = "science_all"
    /// 宠物
    case pet = "宠物"
    /// 情感
    case emotion = "emotion"
    /// 家居
    case home = "news_home"
    /// 教育
    case education = "news_edu"
    /// 三农
    case agriculture = "news_agriculture"
    /// 美食
    case food = "news_food"
    /// 养生
    case regimen = "news_regimen"
    /// 电影
    case movie = "movie"
    /// 手机
    case cellphone = "cellphone"
    /// 旅行
    case travel = "news_travel"
    /// 问答
    case questionAndAnswer = "question_and_answer"
    /// 小说
    case novelChannel = "novel_channel"
    /// 中国新唱将
    case chinaSinger = "中国新唱将"
    /// 火山直播
    case hotsoon = "hotsoon"
    /// 互联网法院
    case highCourt = "high_court"
    /// 快乐男声
    case happyBoy = "快乐男声"
    /// 传媒
    case media = "media"
    /// 百万英雄
    case millionHero = "million_hero"
    /// 彩票
    case lottery = "彩票"
    /// 中国好表演
    case chinaAct = "中国好表演"
    /// 精品课
    case learning = "Learning"
    /// 春节
    case springFestival = "spring_festival"
    /// 微头条
    case weitoutiao = "weitoutiao"
    
    // MARK: - ========= 小视频页面（火山视频） ==========
    /// 小视频 推荐
    case hotsoonVideo = "hotsoon_video"
    /// 小视频 附近
    case ugcVideoLocal = "ugc_video_local"
    /// 小视频 活动
    case ugcVideoActivity = "ugc_video_activity"
    /// 小视频 游戏
    case smallgameSmallvideo = "smallgame_smallvideo"
    /// 小视频 颜值/美女
    case ugcVideoBeauty = "ugc_video_beauty"
    /// 小视频 随拍
    case ugcVideoCasual = "ugc_video_casual"
    /// 小视频 美食
    case ugcVideoFood = "ugc_video_food"
    /// 小视频 户外
    case ugcVideoLife = "ugc_video_life"
    
    // MARK: - ========= 视频页面（西瓜视频） ==========
    /// 直播
    case subv_video_live_toutiao = "subv_video_live_toutiao"
    /// 音乐
    case subv_voice = "subv_voice"
    /// 影视
    case subv_movie = "subv_movie"
    /// 综艺
    case subv_tt_video_variety = "subv_tt_video_variety"
    /// 社会
    case subv_society = "subv_society"
    /// 农人
    case subv_tt_video_agriculture = "subv_tt_video_agriculture"
    /// 游戏
    case subv_game = "subv_game"
    /// 美食
    case subv_tt_video_food = "subv_tt_video_food"
    /// 宠物
    case subv_tt_video_pet = "subv_tt_video_pet"
    /// 儿童
    case subv_tt_video_child = "subv_tt_video_child"
    /// 生活
    case subv_life = "subv_life"
    /// 体育
    case subv_tt_video_sports = "subv_tt_video_sports"
    /// 懂车帝
    case subv_tt_video_car = "subv_tt_video_car"
    /// 文化
    case subv_tt_video_culture = "subv_tt_video_culture"
    /// 时尚
    case subv_tt_video_fashion = "subv_tt_video_fashion"
    /// 金秒奖
    case subv_jmj = "subv_jmj"
    /// 科技
    case subv_tt_video_tech = "subv_tt_video_tech"
    /// 广场舞
    case subv_tt_video_squaredance = "subv_tt_video_squaredance"
    /// 亲子
    case subv_tt_video_motherbaby = "subv_tt_video_motherbaby"

}
