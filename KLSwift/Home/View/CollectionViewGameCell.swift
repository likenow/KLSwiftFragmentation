//
//  CollectionViewGameCell.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {

    // MARK: - 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - 模型属性
    var baseGame: BaseGameModel? {
        didSet {
            guard let game = baseGame else {
                return
            }
            titleLabel.text = game.tag_name
            if let iconUrl = URL(string: game.icon_url) {
                iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "home_more_btn"))
            }else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
