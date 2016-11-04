//
//  BaseViewController.swift
//  KLSwift
//
//  Created by kai lee on 16/11/1.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - 自定义属性
    var baseContentView: UIView?
    
    fileprivate lazy var animaImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "home_header_normal"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "home_header_normal")!, UIImage(named: "home_header_hot")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - 添加UIjiemian
extension BaseViewController {
    func setupUI() {
        self.baseContentView?.isHidden = true
        
        self.view.addSubview(animaImageView)
        
        self.animaImageView.startAnimating()
        
        view.backgroundColor = UIColor(250, 250, 250)
    }
    
    // MARK: - 请求数据完成
    func loadDataFinished() {
        self.animaImageView.stopAnimating()
        
        self.animaImageView.isHidden = true
        
        self.baseContentView?.isHidden = false
    }
}
