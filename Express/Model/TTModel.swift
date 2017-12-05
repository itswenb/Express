//
//  TTModel.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Foundation
/*
 "success": true,
 "ico": "/data/upload/201407/htky_logo.gif",
 "phone": "95320",
 "url": "http://www.800bestex.com/",
 "status": 3,
 "companytype": "huitongkuaidi",
 "nu": "50620122003428",
 "company": "百世快递",
 "reason": "",
 "data": [
 {
 "time": "2017-09-23 19:30:21",
 "context": "成都市【成都高新西区分部】，正发往【成都转运中心】"
 },
 {
 "time": "2017-09-23 17:48:59",
 "context": "成都市【成都高新西区分部】，【罗强/13684046351】已揽收"
 }
 ],
 "time": "",
 "rank": "2.0",
 "exceed": "",
 "timeused": "--"
 }*/
class TTModel :NSObject {
    let success: Bool?
    let ico: String?
    let phone: String?
    let url: String?
    let status: Int?
    let companytype: String?
    let nu: String?
    let company: String?
    let reason: String?
    let data: Array<Any>?
    let time: String?
    let rank: String?
    let exceed: String?
    let timeused: String?
    init(dict : NSDictionary) {
            success = dict["success"] as? Bool
            ico = dict["ico"] as? String
            phone = dict["phone"] as? String
            url = dict["url"] as? String
            status = dict["status"] as? Int
            companytype = dict["companytype"] as? String
            nu = dict["nu"] as? String
            company = dict["company"] as? String
            reason = dict["reason"] as? String
            let a : NSMutableArray = NSMutableArray()
            let o = dict["data"]
            if (o as? Array<Any>)?.count != 0 && dict["success"] as? Bool == true {
                for m in (o as? Array<Any>)!{
                    a.add(TTInfoModel(dict: (m as? NSDictionary)!))
                }
            }
            data = Array(a)
            time = dict["time"] as? String
            rank = dict["rank"] as? String
            exceed = dict["exceed"] as? String
            timeused = dict["timeused"] as? String
    }
}




