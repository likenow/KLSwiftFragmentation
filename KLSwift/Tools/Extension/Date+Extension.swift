//
//  Date+Extension.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import Foundation

// MARK: - 当前时间
extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    static func stringWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        let formatStr = formatter.date(from: getCurrentTime())
        
        return "\(formatStr)"
    }
}

