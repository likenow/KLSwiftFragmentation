//
//  KLCommentView.swift
//  KLSwift
//
//  Created by kai lee on 16/11/8.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class KLCommentView: UIView {
    // MARK: - 模型
    var group: [[KLCommentModel]]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - 懒加载
    fileprivate lazy var tableView: UITableView = { [weak self] in
        // 创建tableView
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    // MARK: - 自定义构造函数
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
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
        //(group?.first?.count ?? 0) + (group?.last?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return group?.first?.count ?? 0
        }
        return group?.last?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "2条长评论"
        }
        
        return "20条短评论"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - 创建cell
        let cell = CommentCell.cell(withTableView: tableView)
        
        // TODO: - 赋值
        // && (group?.first?.count != 0)
        if (indexPath.section == 0) {
            cell.commentModel = group?[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
            return cell;
        }
        cell.commentModel = group?.last?[(indexPath as NSIndexPath).row];
        
        return cell
    }
}
extension KLCommentView: UITableViewDelegate {
    
}








