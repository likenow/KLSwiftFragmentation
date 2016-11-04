//
//  MainViewController.swift
//  KLSwift
//
//  Created by kai lee on 16/10/31.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        //        addChildVc("Live")
        //        addChildVc("Fellow")
        //        addChildVc("Profile")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 添加自控制器
    fileprivate func addChildVc(_ storyName : String) {
        // 1.通过storyboard获取控制器
        
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        // 2.将childVc作为子控制器
        addChildViewController(childVc)
    }

}
