//
//  KLCollectionViewPrettyCell.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class KLCollectionViewPrettyCell: KLCollectionBaseCell {

    // MARK: - 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK: - 定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
