//
//  ZLCustomMarco.swift
//  TodaysNews_Swift4
//
//  Created by LiuLei on 2017/12/19.
//  Copyright © 2017年 LiuLei. All rights reserved.
//

import Foundation
import UIKit


// MARK: ========= 第三方key secret ==========
///激光推送
let JpushAppKey = "e6d2ea215b8f903a122b8cb2"
let JpushChanel = "AppStore"

///友盟分享
let USHARE_APPKEY = "5982cf408f4a9d04f5000759"

//sina
let kSina_APPkey     = "1085320182"
let kSina_APPSecret  = "8c3c72a9c085cf511e7cc48d97800a04"

//QQ
let kTencent_APPkey   = "1106135294"
let kTencent_APPSecret = "jF5G4s6XVb9I2ArJ"

//Alipay
let kAliPay_APPID_PRODUCT  = "2017060507424036"

//WeChat
//生产环境
let kWX_APPID_PRODUCT      = "wx93d715b67d84be6a"
let kWX_AppSecret_PRODUCT  = "bd5412c8e7b979c9838ab32747bf6642"
//测试、开发、演示环境
let kWX_APPID              = "wxa1870e64e0e76ddd"
let kWX_AppSecret          = "87b7aef3e01230d42399c65e48bc50cd"


// MARK: ========= 占位图 ==========
let PlaceHolder_Media       = UIImage(named: "earnings_imag_media")
let PlaceHolder_StoreLog    = UIImage(named: "image_store_40")
let PlaceHolder_40          = UIImage(named: "image_40")
let PlaceHolder_50          = UIImage(named: "image_50")
let PlaceHolder_60          = UIImage(named: "image_60")
let PlaceHolder_80          = UIImage(named: "image_80")
let PlaceHolder_100         = UIImage(named: "image_100")
let PlaceHolder_173         = UIImage(named: "image_173")
let PlaceHolder_375         = UIImage(named: "image_375")
let PlaceHolder_130_100     = UIImage(named: "image_130x100")
let PlaceHolder_172_95      = UIImage(named: "image_172x95")
let PlaceHolder_172_200     = UIImage(named: "image_172x200")
let PlaceHolder_270_90      = UIImage(named: "image_270x90")
let PlaceHolder_355_146     = UIImage(named: "image_355x146")
let PlaceHolder_355_166     = UIImage(named: "image_355x166")
let PlaceHolder_Header      = UIImage(named: "profile_imag_default")



enum ZLTopicType: Int {
    /// 精选
    case Selection = 4
    /// 美食
    case Food = 14
    /// 家居
    case Household = 16
    /// 数码
    case Digital = 17
    /// 美物
    case GoodThing = 13
    /// 杂货
    case Grocery = 22
}

enum ZLShareButtonType: Int {
    /// 微信朋友圈
    case WeChatTimeline = 0
    /// 微信好友
    case WeChatSession = 1
    /// 微博
    case Weibo = 2
    /// QQ 空间
    case QZone = 3
    /// QQ 好友
    case QQFriends = 4
    /// 复制链接
    case CopyLink = 5
}

enum ZLOtherLoginButtonType: Int {
    /// 微博
    case weiboLogin = 100
    /// 微信
    case weChatLogin = 101
    /// QQ
    case QQLogin = 102
}


/// tabBar 被点击的通知
let YMTabBarDidSelectedNotification = "YMTabBarDidSelectedNotification"

/// 服务器地址
let BASE_URL = "http://lf.snssdk.com"
//let BASE_URL = "http://ib.snssdk.com"
//let BASE_URL = "https://is.snssdk.com"

/// iid 未登录用户 id，只要安装了今日头条就会生成一个 iid
/// 可以在自己的手机上安装一个今日头条，然后通过 charles 抓取一下这个 iid，
/// 替换成自己的，再进行测试
let version_code: String = "6.9.0"
let device_id: Int = 46849852544
let iid: Int = 45513839627
let device_platform: String = "iphone"
let aid: Int = 13
let ab_feature: String = "z1"



/// 第一次启动
let ZLFirstLaunch = "firstLaunch"
/// 是否登录
let isLogin = "isLogin"

/// code 码 200 操作成功
let RETURN_OK = 200
/// 间距
let kMargin: CGFloat = 10.0
/// 首页新闻间距
let kHomeMargin: CGFloat = 15.0
/// 圆角
let kCornerRadius: CGFloat = 5.0
/// 线宽
let klineWidth: CGFloat = 1.0
/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
/// 新特性界面图片数量
let kNewFeatureCount = 4
/// 顶部标题的高度
let kTitlesViewH: CGFloat = 35
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64
/// 动画时长
let kAnimationDuration = 0.25

/// 分类界面 顶部 item 的高
let kitemH: CGFloat = 75
/// 分类界面 顶部 item 的宽
let kitemW: CGFloat = 150
/// 我的界面头部图像的高度
let kZLMineHeaderImageHeight: CGFloat = 230
// 分享按钮背景高度
let kTopViewH: CGFloat = 230


// MARK: ========= 主要颜色 ==========
/// 背景颜色
func ZLBgColor() -> UIColor {
    return RGBAColor(r:245, g: 245, b: 245, a: 1)
}

/// 主色调
func ZLMainColor() -> UIColor {
    return RGBAColor(r:253, g: 50, b: 66, a: 1)
}

/// 主要字体黑色色
func ZLBlackTextColor() -> UIColor {
    return RGBAColor(r:51, g: 51, b: 51, a: 1)
}

/// 主要字体灰色
func ZLDarkGrayTextColor() -> UIColor {
    return RGBAColor(r:102, g: 102, b: 102, a: 1)
}

/// 主要字体灰色
func ZLGrayTextColor() -> UIColor {
    return RGBAColor(r:153, g: 153, b: 153, a: 1)
}

/// 主要字体颜色
func ZLSeperateColor() -> UIColor {
    return RGBAColor(r:240, g: 240, b: 240, a: 1)
}

func ZLGlobalRedColor() -> UIColor {
    return RGBAColor(r:196, g: 73, b: 67, a: 1)
}

func ZLBlueFontColor() -> UIColor {
    return RGBAColor(r: 72, g: 100, b: 149, a: 1)
}

/// 从哪里进入问答控制器
enum WendaEnterFrom: String {
    case dongtai = "dongtai"
    case clickHeadline = "click_headline"
    case clickCategory = "click_category"
}

/// 从哪里进入头条
enum TTFrom: String {
    case refresh = "refresh"
    case pull = "pull"
    case loadMore = "load_more"
    case loadmore = "loadmore"   //小视频活动，字符串小写
    case auto = "auto"
    case enterAuto = "enter_auto"
    case preLoadMoreDraw = "pre_load_more_draw"
}



/// 动态图片的宽高
// 图片的宽高
// 1        screenWidth * 0.5
// 2        (screenWidth - 35) / 2
// 3,4,5-9    (screenWidth - 40) / 3
let image1Width: CGFloat = SCREEN_WIDTH * 0.5
let image2Width: CGFloat = (SCREEN_WIDTH - 35) * 0.5
let image3Width: CGFloat = (SCREEN_WIDTH - 40) / 3

/// 从哪里调用API(获取首页、视频、小视频的新闻列表数据API)
enum APIFrom: String {
    case live = "live"
    case smallVideo = "smallVideo"
}
