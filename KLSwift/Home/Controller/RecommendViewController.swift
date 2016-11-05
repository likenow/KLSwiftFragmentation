//
//  RecommendViewController.swift
//  KLSwift
//
//  Created by kai lee on 16/11/2.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

// MARK: - 常量
private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: KLBaseAnchorViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    fileprivate lazy var recommendCycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        // kStatusBarH+kNavigationBarH+kHeaderViewH
        cycleView.frame = CGRect(x:0, y:-(kCycleViewH + kGameViewH), width:kScreenW, height:kCycleViewH)
        
        return cycleView
    }()
    fileprivate lazy var recommendGameView: RecommendGameView = {
       let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x:0, y:-(kGameViewH), width:kScreenW, height:kGameViewH)
        
        return gameView
    }()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setupUI()
//        // Do any additional setup after loading the view.
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

}

// MARK: - UI
extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        
        // 将recommendCycleView添加到UICollectionView中
        collectionView.addSubview(recommendCycleView)
        
        // 将gameView添加到UICollectionView中
        collectionView.addSubview(recommendGameView)
        
        // 设置 collectionView 的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
}
// MARK: - 请求数据
extension RecommendViewController {
    override func loadData() {
        // 给父类的ViewModel赋值
        self.baseVM = self.recommendVM
        
        // 1.请求推荐数据
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给gameView
            var groups = self.recommendVM.anchorGroups
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.recommendGameView.groups = groups
            
            // 3.数据请求完成
            self.loadDataFinished()
        }
        
        // 加载轮播图数据
        self.recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK: - 遵守 UICollectionViewDelegateFlowLayout 协议
extension RecommendViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath as NSIndexPath).section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
}
