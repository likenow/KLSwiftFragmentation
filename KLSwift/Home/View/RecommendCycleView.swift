//
//  RecommendCycleView.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class RecommendCycleView: UIView {

    // MARK: - 常量
    fileprivate let kCycleViewCellID: String = "kCycleViewCellID"
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - 定义属性
    var cycleTimer: Timer?
    
    var cycleModels: [CycleModel]? {
        didSet {
            // 刷新collectionView
            collectionView.reloadData()
            
            // 点的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 默认滚动到中间某个值
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置不随父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册Cell
        collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleViewCellID)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置 CollectionView 的 layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }

}

// MARK: - 快速创建recommendCycleView 的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: - collectionView 遵守数据源协议
extension RecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - what
        return (self.cycleModels?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleViewCellID, for: indexPath) as! CollectionViewCycleCell
        // 获取数据
        // TODO: - what
        let cycleModel = self.cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        
        // 设置数据
        cell.cycleModel = cycleModel
        
        return cell
    }
}

// MARK: - collectionView 遵守协议
extension RecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取偏移量
        let offSetX = scrollView.contentOffset.x
        
        // 计算pageControl 的 currentindex
        pageControl.currentPage = Int((offSetX/scrollView.bounds.width) + 0.5) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: - 定时器
extension RecommendCycleView {
    // 添加定时器
    fileprivate func addCycleTimer() {
        cycleTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
    }
    // 移除定时器
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    // 滚动到下一个位置
    @objc fileprivate func scrollToNext() {
        // 获取滚动偏移量
        let currentOffSetX = collectionView.contentOffset.x
        let offSetX = currentOffSetX + collectionView.bounds.width
        
        // 滚动到该位置
        collectionView.setContentOffset(CGPoint.init(x: offSetX, y: 0), animated: true)
    }
}

