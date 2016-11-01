//
//  PageContentView.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let contentCellID = "contentCellID"


class PageContentView: UIView {
    // MARK: - 定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentVc: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    
    // MARK: - 懒加载
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        // 设置UI
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageContentView {
    fileprivate func setupUI() {
        
        // 将自控制器添加到父控制器
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        // 添加collection
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
// MARK: - 遵循数据源协议
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        for view in collectionView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        
        return cell
    }
}
// MARK: - 遵循代理协议
extension PageContentView: UICollectionViewDelegate {
    
}

