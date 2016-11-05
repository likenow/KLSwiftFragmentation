//
//  CycleModel.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var title: String = ""
    var pic_url: String = ""
    
    var room: [String:NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型
    var anchor : AnchorModel?
    
    // 自定义构造函数
    init(dict: [String:NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
