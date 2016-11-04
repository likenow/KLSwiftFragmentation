//
//  BaseGameModel.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK: - 定义属性
    var tag_name: String = ""
    var icon_url: String = ""
    
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
