//
//  UIBarButtonItem+Extension.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // MARK: - 便利构造函数
    convenience init(imageName: String, highImageName: String, size: CGSize = CGSize.zero) {
        
        let btn = UIButton();
        
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == .zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
