//
//  KLCollectionBaseCell.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit
import Kingfisher

class KLCollectionBaseCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    // MARK: - 定义模型属性
    var anchor: AnchorModel? {
        didSet {
            // 模型是否有值
            guard let anchor = anchor else {
                return
            }
            // 取出在线人数显示的文字
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online/10000)万人在线"
            } else {
                onlineStr = "\(anchor.online)人在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconUrl = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: iconUrl)
            
        }
    }
    
}
