//
//  TTInfoModel.swift
//  Express
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Foundation
/* {
 "time": "2017-09-23 19:30:21",
 "context": "成都市【成都高新西区分部】，正发往【成都转运中心】"
 }*/
class TTInfoModel :NSObject {
    let time : String
    let context: String

    init(dict :NSDictionary) {
        time = dict["time"] as! String
        context = dict["context"] as! String
    }
}
