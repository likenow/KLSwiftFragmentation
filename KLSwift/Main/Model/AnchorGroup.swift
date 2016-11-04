//
//  AnchorGroup.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {

    // 该组中对应的房间信息
    var room_list: [[String:NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // 组显示的图标
    var icon_name: String = "home_header_normal"
    
    lazy var anchors: [AnchorModel] = [AnchorModel]()
}
