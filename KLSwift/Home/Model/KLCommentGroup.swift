//
//  KLCommentGroup.swift
//  KLSwift
//
//  Created by kai lee on 16/11/8.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class KLCommentGroup: NSObject {
    // 该组中对应的评论信息
    var comment_list: [[String:NSObject]]? {
        didSet {
            guard let comment_list = comment_list else {
                return
            }
            for dict in comment_list {
                comments.append(KLCommentModel(dict: dict))
            }
        }
    }
    lazy var comments: [KLCommentModel] = [KLCommentModel]()
    
    // MARK: - 构造函数
    override init() {
        super.init()
    }
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
