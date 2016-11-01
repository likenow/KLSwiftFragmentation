//
//  HomeViewController.swift
//  KLSwift
//
//  Created by kai lee on 16/10/31.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit
// MARK: - 定义常量
private let kTitleViewH: CGFloat = 40


class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView: PageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        
        return titleView
    }()
    
    fileprivate lazy var pageContentView: PageContentView = { [weak self] in
        // 确定 pagecontentView 的frame
        let pageContentViewH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let frame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: pageContentViewH)
        
        // 确定所有自控制器
        var childVcs = [UIViewController]()
//        childVcs.append(<#T##newElement: Element##Element#>)
        
        let pageContentView = PageContentView(frame: frame, childVcs: childVcs, parentVc: self)
        pageContentView.delegate = self
        
        return pageContentView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - 设置UI界面
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置导航栏
        setupNavigationBar()
        
        // 添加title
        view.addSubview(pageTitleView)
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

// MARK: - 遵守协议
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        print("什么时候执行？？")
    }
}

// MARK: - 遵守协议
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        print("啥时候执行！！")
    }
}

