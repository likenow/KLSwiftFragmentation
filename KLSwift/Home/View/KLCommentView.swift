//
//  KLCommentView.swift
//  KLSwift
//
//  Created by kai lee on 16/11/8.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

private let commentCellID = "commentCellID"

class KLCommentView: UIView {
    // MARK: - 模型
    var group: [[KLCommentModel]]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - 懒加载
    fileprivate lazy var tableView: UITableView = { [weak self] in
        // 创建tableView
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:"KLCommentCell", bundle:nil), forCellReuseIdentifier: commentCellID)
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    // MARK: - 自定义构造函数
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // 设置UI
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension KLCommentView {
    fileprivate func setupUI() {
        // 添加collection
        addSubview(tableView)
    }
}
extension KLCommentView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
//        return (self.group?.first?.count)! + (self.group?.last?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if ((section == 0) && (self.group?.first?.count != 0)) {
//            return self.group!.first!.count
//        }
//        return self.group!.last!.count;
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if ((section == 0) && (self.group?.first?.count != 0)) {
            return "2条长评论"
        }
        
        return "20条短评论"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = KLCommentCell(style: UITableViewCellStyle.default, reuseIdentifier: commentCellID) as KLCommentCell
        // TODO: - 赋值
//        // 取出模型
//        if (!indexPath.section && self.allComments.firstObject.count) {
//            cell.comment = self.allComments[indexPath.section][indexPath.row];
//            return cell;
//        }
//        cell.comment = self.allComments.lastObject[indexPath.row];
//        let comment = group?.first[(indexPath as NSIndexPath).section].comment[(indexPath as NSIndexPath).item]
//        // cell 赋值
//        cell.comment = comment
        
        return cell
    }
}
extension KLCommentView: UITableViewDelegate {
    
}








