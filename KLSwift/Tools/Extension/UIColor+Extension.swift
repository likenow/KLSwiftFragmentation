//
//  UIColor+Extension.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: - 颜色便捷构造器
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
    // MARK: - 随机颜色
    class func radomColor() -> UIColor {
        return UIColor(CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)))
    }
    
}
