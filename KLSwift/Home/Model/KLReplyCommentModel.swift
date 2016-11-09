//
//  KLReplyCommentModel.swift
//  KLSwift
//
//  Created by kai lee on 16/11/7.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import Foundation

class KLReplyCommentModel: NSObject {
    var content: String = ""
    
    var status: Int = 0
    
    var id: IntMax = 0
    
    var author: String = ""
    
    
    // 初始化
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
