//
//  PageTitleView.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}

// MARK: - 定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: UIColor = UIColor.init(85, 85, 85)
private let kSelectedColor: UIColor = UIColor.init(255, 128, 0)


class PageTitleView: UIView {

    // MARK: - 定义属性
    fileprivate var currentIndex: Int = 0
    var titles: [String]
    weak var delegate: PageTitleViewDelegate?
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleLables: [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        // MARK: - 设置UI
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension PageTitleView {
    fileprivate func setupUI() {
        // 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加titles 对应的labels()
        setupTitleLabels()
        
        // 设置底线和滚动的滑块
        setupBottomLineScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        let labelW: CGFloat = frame.width/CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = kNormalColor
            label.textAlignment = .center
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLables.append(label)
            
            // 给label 添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(titleClick(_ :)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    fileprivate func setupBottomLineScrollLine() {
        // 添加底线
        let lineH: CGFloat = 0.5
        let lineY: CGFloat = frame.height - lineH
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        bottomLine.frame = CGRect(x: 0, y: lineY, width: frame.width, height: lineH)
        
        addSubview(bottomLine)
        
        // 滑块
        guard let firstLabel = titleLables.first else {
            return
        }
        firstLabel.textColor = kSelectedColor
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
    
}
// MARK: - label点击事件
extension PageTitleView {
    @objc fileprivate func titleClick(_ tapGes: UITapGestureRecognizer) {
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        // 判断重复点击
        if currentLabel.tag == currentIndex {
            return
        }
        // 取出上一个label
        let oldLabel = titleLables[currentIndex]
        
        // 切换文字颜色
        currentLabel.textColor = kSelectedColor
        oldLabel.textColor = kNormalColor
        
        // 保存更新的下标值
        currentIndex = currentLabel.tag
        
        // 滚动线条x
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        
        // 动画
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        // 通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}


