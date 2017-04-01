//
//  ViewController.swift
//  HCScrollForever
//
//  Created by UltraPower on 2017/4/1.
//  Copyright © 2017年 侯聪. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageNames:[String] = ["1","2","3","4","5","6","7"]
    let scrollWidth:CGFloat = UIScreen.main.bounds.width - 20
    let scrollV:UIScrollView = UIScrollView(frame: CGRect(x: 10, y: 84, width: UIScreen.main.bounds.width - 20, height: 200))
    var currentPage:Int = 0
    var scrollDictor:Bool = false
    
    
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        automaticallyAdjustsScrollViewInsets = false
        scrollV.backgroundColor = UIColor.red
        
        let sizeWidth:CGFloat = scrollWidth * CGFloat(imageNames.count)
    
        scrollV.contentSize = CGSize(width: sizeWidth, height: 200)
        scrollV.isPagingEnabled = true
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.delegate = self
        view.addSubview(scrollV)
        
        for i in 0 ..< imageNames.count {
            let imageV:UIImageView = UIImageView()
            imageV.image = UIImage(named: imageNames[i])
            imageV.frame = CGRect(x: scrollWidth * CGFloat(i), y: 0, width: scrollWidth, height: 200)
            scrollV.addSubview(imageV)
        }
        
        
        timer = Timer(fireAt: Date(timeInterval: 1.5, since: Date()), interval: 1.5, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        
        let btn:UIButton = UIButton(type: .custom)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.setTitle("无限轮播", for: .normal)
        btn.sizeToFit()
        btn.center = view.center
        btn.addTarget(self, action: #selector(ViewController.goAction), for: .touchUpInside)
        view.addSubview(btn)
        
        
    }
    
    
    func goAction() {
        let vc = HCForeverViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func timerAction() {
        if scrollV.contentOffset.x < scrollWidth * CGFloat(imageNames.count - 1){
            currentPage += 1
        } else {
            currentPage = 0
        }
        scrollV.setContentOffset(CGPoint(x: scrollWidth * CGFloat(currentPage), y: 0), animated: currentPage != 0)
    }

}

extension ViewController : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 暂停定时器
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 开启定时器
        timer = Timer(fireAt: Date(timeInterval: 1.5, since: Date()), interval: 1.5, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        
        // 修改currentPage
        currentPage = Int(scrollView.contentOffset.x / scrollWidth)
    }

    
    
}

