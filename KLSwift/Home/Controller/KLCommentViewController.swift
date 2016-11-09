//
//  KLCommentViewController.swift
//  KLSwift
//
//  Created by kai lee on 16/11/7.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class KLCommentViewController: BaseViewController {

    // MARK: - 模型属性
    fileprivate lazy var commentVM: KLCommentViewModel = KLCommentViewModel()
    
    // MARK: - 懒加载属性
    fileprivate lazy var commentView: KLCommentView = { [weak self] in
        // 确定 pagecontentView 的frame
        let commentViewH = kScreenH - kStatusBarH
        let commentViewY = kStatusBarH+kNavigationBarH
        let frame = CGRect(x: 0, y:commentViewY , width: kScreenW, height: kScreenH)
        let commentView = KLCommentView(frame: frame)
        
        return commentView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - 设置UI界面
        setupUI()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
// MARK: - 请求数据
extension KLCommentViewController {
    func loadData() {
        // 1.请求推荐数据
        commentVM.requestData {
            let groups = self.commentVM.comments
            self.commentView.group = groups
            // 2.数据请求完成
            self.loadDataFinished()
        }
    }
}

// MARK: - 设置UI界面
extension KLCommentViewController {
    override func setupUI() {
        
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置导航栏
        setupNavigationBar()
        
        // 添加 CommentView
        view.addSubview(commentView)
    }
    
    fileprivate func setupNavigationBar() {
        // 设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "logo")))
        
        // 设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let histroyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [histroyItem, searchItem, qrcodeItem]
    }
}
