//
//  NetworkTool.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - 请求方式枚举
enum MethodType {
    case get
    case post
}

// MARK: - 网络请求

class NetworkTool {
    class func requestData(_ type: MethodType, URLString: String, parameters: [String:Any]? = nil, finishedCallBack: @escaping (_ result: Any) -> ()) {
        // 获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        
        // 发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            // 将结果回调出去
            finishedCallBack(result)
        }
    }
}
