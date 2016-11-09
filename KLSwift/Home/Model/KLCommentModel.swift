//
//  KLCommentModel.swift
//  KLSwift
//
//  Created by kai lee on 16/11/7.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import Foundation

class KLCommentModel: NSObject {
    var author: String = ""
    var content: String = ""
    var avatar: String = ""
    var time: IntMax = 0
    var id: IntMax = 0
    var likes: IntMax = 0
    var isLong: Bool?
    var isLike: Bool?
    var isOpen: Bool?
    
    var reply_to: KLReplyCommentModel?
    
    // 初始化
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    
}
