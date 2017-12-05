//
//  NetWorkFetcher.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa
import Alamofire

class NetWorkFetcher: NSObject {
    
//    let url = "http://www.kuaidi.com/index-ajaxselectinfo-"

    func getReleases(url: String, _ done: @escaping (_ model: Any?) -> ()) {
        Alamofire.request(url, method: .get )
            .responseJSON { response in
                guard let html = response.result.value else {
                    return done(nil)
                }
                print(html)
                print((html as AnyObject).className)
                done(html)
        }
    }
}
