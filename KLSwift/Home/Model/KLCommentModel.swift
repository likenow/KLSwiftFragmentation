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
    var isLong: Bool = false
    var isLike: Bool = false
    var isOpen: Bool = false
    
    var reply_to: [String:NSObject]? {
        didSet {
            guard let reply_to = reply_to else {
                return
            }
            reply = KLReplyCommentModel(dict: reply_to)
        }
    }
    
    var reply: KLReplyCommentModel?
    
    // 初始化
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    
}
