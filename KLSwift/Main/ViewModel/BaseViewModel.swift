//
//  BaseViewModel.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    lazy var comments: [[KLCommentModel]] = [[KLCommentModel]]()
    
}

// MARK: - 请求数据
extension BaseViewModel {
    func loadAnchorData(method: MethodType, URLString: String, parameters: [String:Any]? = nil, finishCallBack: @escaping () -> ()) {
        NetworkTool.requestData(method, URLString: URLString, finishedCallBack: { (result) in
            
            guard let resultDict = result as? [String: Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {
                return
            }
            
            // 遍历数组中的字典
            for dict in dataArray {
                let amuse = AnchorGroup(dict: dict)
                self.anchorGroups.append(amuse)
            }
            
            // 完成回调
            finishCallBack()
        })
    }
    func loadFunnyData(method: MethodType, URLString: String, parameters: [String:Any]? = nil, finishCallBack: @escaping () -> ()){
        NetworkTool.requestData(method, URLString: URLString, finishedCallBack: { (result) in
            
            guard let resultDict = result as? [String:Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {
                return
            }
            // 便利数组中的字典
            let anchorGroup = AnchorGroup()
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                anchorGroup.anchors.append(anchor)
            }
            
        
        })
    }
    
}

