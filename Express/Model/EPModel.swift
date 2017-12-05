//
//  EPModel.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Foundation

/*
 "name": "百世快递",
 "exname": "huitongkuaidi",
 "ico": "/data/upload/201407/htky_logo.gif",
 "url": "http://www.800bestex.com/",
 "phone": "95320"
 */
class EPModel : NSObject {
    let name : String
    let exname: String
    let ico: String
    let url: String
    let phone: String
    init(dict: NSDictionary) {
        name = dict["name"] as! String
        exname = dict["exname"] as! String
        ico = dict["ico"] as! String
        url = dict["url"] as! String
        phone = dict["phone"] as! String
    }
}
