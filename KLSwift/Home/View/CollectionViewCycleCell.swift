//
//  CollectionViewCycleCell.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class CollectionViewCycleCell: UICollectionViewCell {

    // MARK: - 控件
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - 定义模型属性
    var cycleModel: CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            if let iconURL = URL(string: cycleModel?.pic_url ?? "") {
                iconImage.kf.setImage(with: iconURL)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
