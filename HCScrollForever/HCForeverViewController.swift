//
//  HCForeverViewController.swift
//  HCScrollForever
//
//  Created by UltraPower on 2017/4/1.
//  Copyright © 2017年 侯聪. All rights reserved.
//

import UIKit

class HCForeverViewController: UIViewController {
   
    
    var scollV:HCScrollForeverView?
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        // HCScrollForeverView需要主动调用start方法，开始轮播
        // 由于有定时器的存在，HCScrollForeverView不会调用析构方法
        // 所以需要程序员在合适的时候手动调用stop方法
        let scollView:HCScrollForeverView = HCScrollForeverView(frame: CGRect(x: 10, y: 84, width: UIScreen.main.bounds.width - 20, height: 200), images: nil)
        view.addSubview(scollView)
        scollView.start()
        scollV = scollView
    
        view.backgroundColor = UIColor.white

    }

    
    deinit {
       
        if scollV != nil {
            scollV?.stop()
            scollV = nil
        }
    }
}

