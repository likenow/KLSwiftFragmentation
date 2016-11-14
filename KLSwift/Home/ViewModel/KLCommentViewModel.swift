//
//  KLCommentViewModel.swift
//  KLSwift
//
//  Created by kai lee on 16/11/8.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import Foundation

class KLCommentViewModel: BaseViewModel {
//    lazy var commentGruops: [KLCommentGroup] = [KLCommentGroup]()
    
    lazy var longComments: [KLCommentModel] = [KLCommentModel]()
    lazy var shortComments: [KLCommentModel] = [KLCommentModel]()
}

// MARK:- 发送网络请求
extension KLCommentViewModel {
    
    // 请求推荐数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        // 1.定义参数
        let paramters: [String: Any]? = nil
        // 2.创建Group
        let dGroup = DispatchGroup()
        
        // 3.请求第一部请求长评论
        dGroup.enter()
        NetworkTool.requestData(.get, URLString: "http://news-at.zhihu.com/api/4/story/8951714/short-comments", parameters: paramters) { (result) in
            guard let resultDict = result as? [String: Any] else {
                return
            }
            guard let dataArray = resultDict["comments"] as? [[String: Any]] else {
                return
            }
            // 遍历数组中的字典
            for dict in dataArray {
                let comment = KLCommentModel(dict: dict)
                self.longComments.append(comment)
            }
            
            // 3.3离开组
            dGroup.leave()
            
        }
        
        // 4.请求第二部分请求短评论
        dGroup.enter()
        NetworkTool.requestData(.get, URLString: "http://news-at.zhihu.com/api/4/story/8951714/short-comments", parameters: paramters) { (result) in
            guard let resultDict = result as? [String: Any] else {
                return
            }
            guard let dataArray = resultDict["comments"] as? [[String: Any]] else {
                return
            }
            // 遍历数组中的字典
            for dict in dataArray {
                let comment = KLCommentModel(dict: dict)
                self.shortComments.append(comment)
            }
            
            // 3.3离开组
            dGroup.leave()
        }
        
        // 6.所有的数据都请求道, 对所有的数据进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.comments.insert(self.longComments, at: 0)
            self.comments.insert(self.shortComments, at: 1)
            
            // 完成回调
            finishCallback()
        }
    }
}



//// MARK: - 请求长评论数据
//func getLongCommentData(method: MethodType, URLString: String, parameters: [String:Any]? = nil, finishCallBack: @escaping () -> ()) {
//    NetworkTool.requestData(method, URLString: URLString, finishedCallBack: { (result) in
//        guard let resultDict = result as? [String: Any] else {
//            return
//        }
//        guard let dataArray = resultDict["comments"] as? [[String: Any]] else {
//            return
//        }
//        // 遍历数组中的字典
//        for dict in dataArray {
//            let comment = KLCommentModel(dict: dict)
//            self.comments.append(comment)
//        }
//        
//        // 完成回调
//        finishCallBack()
//        
//    })
//}
//// MARK: - 请求短评论数据
//func getShortCommentData(method: MethodType, URLString: String, parameters: [String:Any]? = nil, finishCallBack: @escaping () -> ()) {
//    NetworkTool.requestData(method, URLString: URLString, finishedCallBack: { (result) in
//        guard let resultDict = result as? [String: Any] else {
//            return
//        }
//        guard let dataArray = resultDict["comments"] as? [[String: Any]] else {
//            return
//        }
//        // 遍历数组中的字典
//        for dict in dataArray {
//            let comment = KLCommentModel(dict: dict)
//            self.comments.append(comment)
//        }
//        
//        // 完成回调
//        finishCallBack()
//        
//    })
//}
