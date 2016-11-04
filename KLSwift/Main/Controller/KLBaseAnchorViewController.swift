//
//  KLBaseAnchorViewController.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

// MARK: - 常量
let kItemMargin: CGFloat = 10
let kNormalItemW = (kScreenW - 3*kItemMargin)/2
let kNormalItemH = kNormalItemW*3/4
let kPrettyItemH = kNormalItemW*4/3
let kHeaderViewH: CGFloat = 50

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kHeaderViewID = "kHeaderViewID"

class KLBaseAnchorViewController: BaseViewController {

    // MARK: - 懒加载属性
    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forCellWithReuseIdentifier: kHeaderViewID)
        
        
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - 设置UI
extension KLBaseAnchorViewController {
    override func setupUI() {
        self.baseContentView = collectionView
        self.view.addSubview(collectionView)
        super.setupUI()
    }
}
// MARK: - 请求数据由子类实现
extension KLBaseAnchorViewController {
    func loadData() {
        
    }
}

// MARK: - 遵守 CollectionView 数据源协议
extension KLBaseAnchorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = self.baseVM.anchorGroups[section]
        
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! KLCollectionViewNormalCell
        // 取出模型
        let anchor = self.baseVM.anchorGroups[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item]
        // cell 赋值
        cell.anchor = anchor
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 取出section 的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        let group = self.baseVM.anchorGroups[(indexPath as NSIndexPath).section]
        headerView.group = group
        
        return headerView
    }
}

extension KLBaseAnchorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 取出选中item的信息
        let anchor = self.baseVM.anchorGroups[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item] 
        
        // 判断房间类型
        anchor.isVertical == 0 ? pushNormalRoomVc(anchor) : pushShowRoomVc(anchor)
        
    }
    func pushNormalRoomVc(_ anchor: AnchorModel) {
        print("跳转 pushNormalRoomVc \(anchor)")
    }
    
    func pushShowRoomVc(_ anchor: AnchorModel) {
        print("跳转 pushShowRoomVc \(anchor)")
    }
}

