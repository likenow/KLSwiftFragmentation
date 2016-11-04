//
//  KLCollectionViewNormalCell.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class KLCollectionViewNormalCell: KLCollectionBaseCell {

    // MARK: - 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK: - 定义属性模型
    override var anchor: AnchorModel? {
        didSet {
            // 将模型传递给父类
            super.anchor = anchor
            
            // 设置房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
