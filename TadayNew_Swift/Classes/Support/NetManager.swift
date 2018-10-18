//
//  NetManager.swift
//  TadayNew_Swift
//
//  Created by LiuLei on 2018/10/9.
//  Copyright © 2018年 LiuLei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON

protocol NetManagerProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    // MARK: 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitleModel]) -> ())

    // MARK: 点击首页加号按钮，获取频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitleModel]) -> ())
    
    // MARK: 获取首页、视频、小视频的新闻列表数据,加载更多
    static func loadApiNewsFeeds(apiFrom: APIFrom, category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ())

    // MARK: - --------------------------------- 视频直播 video  ---------------------------------
    // MARK: 视频顶部新闻标题的数据
    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitleModel]) -> ())
    
    // MARK: 获取视频直播列表数据
    static func loadApiLiveFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [LiveModel]) -> ())

    // MARK: - --------------------------------- 小视频  ---------------------------------
    // MARK: 小视频导航栏标题的数据
    static func loadSmallVideoCategories(completionHandler: @escaping (_ newsTitles: [HomeNewsTitleModel]) -> ())

    // MARK: 小视频活动列表数据
    static func loadVideoActivityData(ttFrom: TTFrom, listCount: Int, _ completionHandler: @escaping (_ activityModel: VideoActivityModel) -> ())
    
}

extension NetManagerProtocol {
    
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    
    /// 首页顶部新闻标题的数据
    /// - Parameter completionHandler: 返回标题数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitleModel]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v4/?"
        let params = ["version_code": version_code,
                      "device_id": device_id,
                      "device_platform": device_platform,
                      "aid":aid,
                      "ab_feature": ab_feature,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            
            if let value = response.result.value {
                print("JSON: \(value)")
                if let obj = BaseCommonNaviTitleModel.deserialize(from: value as? Dictionary){
                    guard obj.message == "success" else { return }
                    let titles = obj.data.data                    
                    completionHandler(titles)
                }
            }
        }
    }

    // MARK: 点击首页加号按钮，获取频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitleModel]) -> ()){
        let url = BASE_URL + "/article/category/get_extra/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid,
                      "device_platform": device_platform,
                      "aid":aid,
                      "ab_feature": ab_feature] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                print("JSON: \(value)")
                if let obj = BaseCommonNaviTitleModel.deserialize(from: value as? Dictionary){
                    guard obj.message == "success" else { return }
                    let titles = obj.data.data
                    completionHandler(titles)
                }
            }
        }
    }
    
    /// 获取首页、西瓜视频（除直播外）、小视频（推荐、游戏列表）新闻列表数据
    /// - parameter category: 新闻类别
    /// - parameter ttFrom: 那个界面
    /// - parameter listCount: 数据数量
    /// - parameter completionHandler: 返回新闻列表数据
    /// - parameter news: 首页新闻数据数组
    static func loadApiNewsFeeds(apiFrom: APIFrom, category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ()) {
        
        var url: String
        if apiFrom == .live {
            url = BASE_URL + "/api/news/feed/v64/?"
        }else{
            url = BASE_URL + "/api/news/feed/v88/?"
        }
        
        var params = ["version_code": version_code,
                      "device_platform": device_platform,
                      "aid":aid,
                      "device_id": device_id,
                      "count": 20,
                      "list_count": listCount,
                      "category": category.rawValue,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "min_behot_time": Date().timeIntervalSince1970,
                      "iid": iid] as [String: Any]
        
        //字典的增加
        if ttFrom == TTFrom.pull || ttFrom == TTFrom.enterAuto {
            params.updateValue(Date().timeIntervalSince1970, forKey: "pullTime")
        }else{
            if apiFrom == .live {
                params.updateValue(maxBehotTime, forKey: "last_refresh_sub_entrance_interval")
            }else{
                params.updateValue(maxBehotTime, forKey: "max_behot_time")
            }
        }
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                print("JSON: \(value)")
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                completionHandler(datas.compactMap({ NewsModel.deserialize(from: $0["content"].string) }))
            }
        }
    }
    
    // MARK: - --------------------------------- 西瓜视频 video  ---------------------------------
    /// 视频顶部新闻标题的数据（西瓜视频）
    /// - parameter completionHandler: 返回标题数据
    /// - parameter newsTitles: 视频标题数组
    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitleModel]) -> ()) {
        let url = BASE_URL + "/video_api/get_category/v3/?"
        let params = ["version_code": version_code,
                      "device_id": device_id,
                      "device_platform": device_platform,
                      "aid":aid,
                      "ab_feature": ab_feature,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                print("JSON: \(value)")
                if let obj = CommonNaviTitleModel.deserialize(from: value as? Dictionary){
                    guard obj.message == "success" else { return }
                    if obj.data.count > 0 {
                        
                        let titles : NSMutableArray = NSMutableArray.init()
                        titles.addObjects(from: obj.data)
                        
                        /// 插入一条
                        var recommandModel : HomeNewsTitleModel = HomeNewsTitleModel()
                        recommandModel.name = "推荐"
                        recommandModel.category = .video
                        titles.insert(recommandModel, at: 1)
                        
                        completionHandler(titles as! [HomeNewsTitleModel])
                    }
                }
            }
        }
    }
    
    
    /// 直播列表数据（西瓜视频）
    static func loadApiLiveFeeds(category: NewsTitleCategory, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [LiveModel]) -> ()){
        
        let url: String = BASE_URL + "/api/news/feed/v64/?"
        
        let randomNumber:Int = Int(arc4random() % 1000) + 10
        
        var params = ["version_code": version_code,
                      "device_platform": device_platform,
                      "aid":aid,
                      "device_id": device_id,
                      "count": listCount,
                      "category": category.rawValue,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "min_behot_time": Date().timeIntervalSince1970,
                      "last_refresh_sub_entrance_interval": randomNumber,
                      "iid": iid] as [String: Any]
        //字典的增加
        if ttFrom == TTFrom.pull || ttFrom == TTFrom.enterAuto {
            params.updateValue(Date().timeIntervalSince1970, forKey: "min_behot_time")
        }else{
            params.updateValue(maxBehotTime, forKey: "max_behot_time")
        }
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                print("JSON: \(value)")
                
                if let obj = BaseLiveModel.deserialize(from: value as? Dictionary){
                    guard obj.message == "success" else { return }
                   
                    let liveArr : NSMutableArray = NSMutableArray.init()
                    for liveContent: LiveContent in obj.data{
                        let jsonstring = liveContent.content
                        
                        print("liveContentDic = \(CommonFun().getDictionaryFromJSONString(jsonString: jsonstring))")
                        
                        if let live = JSONDeserializer<LiveModel>.deserializeFrom(json: jsonstring) {
                            liveArr.add(live)
                        }
                    }                    
                    completionHandler(liveArr as! [LiveModel])
                }
            }
        }
    }
 
    // MARK: - --------------------------------- 小视频 video  ---------------------------------
    /// 小视频导航栏标题的数据（小视频）
    /// - parameter completionHandler: 返回标题数据
    /// - parameter newsTitles: 小视频标题数组
    static func loadSmallVideoCategories(completionHandler: @escaping (_ newsTitles: [HomeNewsTitleModel]) -> ()) {
        
        let url = BASE_URL + "/category/get_ugc_video/3/?"
        let params = ["version_code": version_code,
                      "device_id": device_id,
                      "device_platform": device_platform,
                      "aid":aid,
                      "ab_feature": ab_feature,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                print("JSON: \(value)")
                if let obj = BaseCommonNaviTitleModel.deserialize(from: value as? Dictionary){
                    guard obj.message == "success" else { return }
                    let titles = obj.data.data
                    completionHandler(titles)
                }
            }
        }
    }
    
    
    /// 小视频（活动）
    ///
    /// - Parameter completionHandler:
    static func loadVideoActivityData(ttFrom: TTFrom, listCount: Int, _ completionHandler: @escaping (_ activityModel: VideoActivityModel) -> ()){
        
        let url = BASE_URL + "/ugc/video/activity/channel/v1/?"
        let params = ["version_code": version_code,
                      "device_platform": device_platform,
                      "aid":aid,
                      "off_set":listCount,
                      "device_id": device_id,
                      "count": 10,
                      "user_action": ttFrom,
                      "ts": NSString.init(format: "%.0f", Date().timeIntervalSince1970),
                      "iid": iid] as [String: Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                print("JSON: \(value)")
                
                if let obj = VideoActivityBaseModel.deserialize(from: value as? Dictionary){
                    guard obj.message == "success" else { return }
                    completionHandler(obj.data)
                }
            }
        }
    }
    
}

struct NetManager: NetManagerProtocol {}


/**
 活动
 http://is.snssdk.com/ugc/video/activity/channel/v1/?fp=i2TqLzFOJzmIFlwSPlU1FYFeL2ce&version_code=6.9.0&tma_jssdk_version=1.2.2.4&app_name=news_article&vid=14F1CCA7-E4B5-48A5-9F50-9808B48DF9A5&device_id=46849852544&channel=App%20Store&resolution=1242*2208&aid=13&ab_feature=201617,z2&ab_version=425531,537722,512528,539246,486950,536106,537122,521868,239096,500088,467915,170988,493249,405357,523529,374116,495947,517715,489311,501961,276205,537596,533844,537155,538036,536020,385747,416055,378450,471407,522904,519795,523156,509307,512917,468954,271178,424178,536458,326524,326532,536770,496389,533172,537702,539697,540382,537553,493304,424177,214069,31210,442255,539819,280449,523499,281297,535501,478595,325611,526720,539080,539320,539044,431139,498375,539504,467516,515673,252782,444464,539832,540049,457481,538429,304489,261581&ab_group=z2&openudid=7c75048cb36d5bee97e7d311a269468b41e3b62c&update_version_code=69023&idfv=14F1CCA7-E4B5-48A5-9F50-9808B48DF9A5&ac=WIFI&os_version=12.0&ssmix=a&device_platform=iphone&iid=45513839627&ab_client=a1,f2,f7,e1&device_type=iPhone%206S%20Plus&idfa=5842C1B6-A6BC-4916-A9B1-26C5DEBBC4B9&off_set=0&count=10&user_action=refresh&as=a2f5d39bbb51dbc47f9559&ts=1539257371
 
 */
