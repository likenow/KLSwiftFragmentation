//
//  KLCommentViewController.swift
//  KLSwift
//
//  Created by kai lee on 16/11/7.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

private let commentCellID = "commentCellID"

class KLCommentViewController: BaseViewController {

    // MARK: - 模型属性
    fileprivate lazy var commentVM: KLCommentViewModel = KLCommentViewModel()
    
    // MARK: - 懒加载
    fileprivate lazy var tableView: UITableView = { [weak self] in
        // 创建tableView
        let tableView = UITableView(frame: CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kScreenH), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(UINib(nibName:"CommentCell", bundle:nil), forCellReuseIdentifier: commentCellID)
        return tableView
    }()
    
//    // MARK: - 懒加载属性
//    fileprivate lazy var commentView: KLCommentView = { [weak self] in
//        // 确定 pagecontentView 的frame
//        let commentViewH = kScreenH - kStatusBarH
//        let commentViewY = kStatusBarH+kNavigationBarH
//        let frame = CGRect(x: 0, y:commentViewY , width: kScreenW, height: kScreenH)
//        let commentView = KLCommentView(frame: frame)
//        
//        return commentView
//    }()
    
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
//            self.commentView.group = self.commentVM.comments
            self.tableView.reloadData()
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
        view.addSubview(tableView)
    }
    
    fileprivate func setupNavigationBar() {
        // 设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "logo")))
        
        // 设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let histroyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size, target: self, action: #selector(self.btnClick(_:)))
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [histroyItem, searchItem, qrcodeItem]
    }
    @objc fileprivate func btnClick(_ btn: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
}
extension KLCommentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        //(group?.first?.count ?? 0) + (group?.last?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.commentVM.comments.first?.count ?? 0
        }
        return self.commentVM.comments.last?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "2条长评论"
        }
        
        return "20条短评论"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - 创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellID, for: indexPath) as! CommentCell
        
        // TODO: - 赋值
        // && (group?.first?.count != 0)
        if (indexPath.section == 0) {
            cell.commentModel = self.commentVM.comments[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
            return cell;
        }
        cell.commentModel = self.commentVM.comments.last?[(indexPath as NSIndexPath).row];
        
        return cell
    }
}
extension KLCommentViewController: UITableViewDelegate {
    
}
