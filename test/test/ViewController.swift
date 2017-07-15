//
//  ViewController.swift
//  test
//
//  Created by liwei on 2017/7/15.
//  Copyright © 2017年 liwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var leftLabel:YGHorizontalView! = {
    
        let view = YGHorizontalView()
        view.beforeHalfAlign = .left
        view.behindHalfAlign = .right
        view.padding = 10
        self.view.addSubview(view);
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftLabel.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.midY)
        leftLabel.bounds = CGRect(x: 0, y: 0, width: 300, height: 40)
        
        leftLabel.layoutDirection = .center
        leftLabel.backgroundColor = UIColor.orange
        leftLabel.beforeHalfText = "测试: "
        leftLabel.behindHalfText = "后面的  "
        leftLabel.imageName = "timeLine_icon"

    }

  


}

