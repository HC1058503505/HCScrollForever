//
//  HCForeverViewController.swift
//  HCScrollForever
//
//  Created by UltraPower on 2017/4/1.
//  Copyright © 2017年 侯聪. All rights reserved.
//

import UIKit

class HCForeverViewController: UIViewController {
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        let scollView:HCScrollForeverView = HCScrollForeverView(frame: CGRect(x: 10, y: 84, width: UIScreen.main.bounds.width - 20, height: 200), images: nil)
        view.addSubview(scollView)
    
        view.backgroundColor = UIColor.white

    }

    
   
}

