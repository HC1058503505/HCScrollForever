//
//  HCForeverViewController.swift
//  HCScrollForever
//
//  Created by UltraPower on 2017/4/1.
//  Copyright © 2017年 侯聪. All rights reserved.
//

import UIKit

class HCForeverViewController: UIViewController {
   
    let imageNames:[String] = ["1","2","3","4","5","6","7"]
    let scrollV:UIScrollView = UIScrollView(frame: CGRect(x: 10, y: 84, width: UIScreen.main.bounds.width - 20, height: 200))
    let scrollWidth:CGFloat = UIScreen.main.bounds.width - 20
    var imagev1:UIImageView = UIImageView()
    var imagev2:UIImageView = UIImageView()
    var currentPage:Int = 1
    var timer:Timer?
    let scollView:HCScrollForeverView = HCScrollForeverView(frame: CGRect(x: 10, y: 84, width: UIScreen.main.bounds.width - 20, height: 200), images: ["7","4","3","2","6","5","1"])
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(scollView)
        
        
        view.backgroundColor = UIColor.white
//        scrollV.backgroundColor = UIColor.red
        
//        let sizeWidth:CGFloat = scrollWidth * 3.0
//        
//        scrollV.contentSize = CGSize(width: sizeWidth, height: 200)
//        scrollV.isPagingEnabled = true
//        scrollV.setContentOffset(CGPoint(x: scrollWidth, y: 0), animated: true)
//        scrollV.showsHorizontalScrollIndicator = false
//        scrollV.delegate = self
//        view.addSubview(scrollV)
        
//        imagev1.frame = CGRect(x: scrollWidth, y: 0, width: scrollWidth, height: 200)
//        imagev1.image = UIImage(named: imageNames[0])
//        imagev1.tag = 0
//        scrollV.addSubview(imagev1)
//        
//        imagev2.frame = CGRect(x: scrollWidth * 2.0, y: 0, width: scrollWidth, height: 200)
//        scrollV.addSubview(imagev2)
        
//        timer = Timer(fireAt: Date(timeInterval: 1.5, since: Date()), interval: 1.5, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    func timerAction() {
    
        currentPage += 1
        
        if currentPage == 3 {
            currentPage = 1
        }
        
        scrollV.setContentOffset(CGPoint(x: scrollWidth * CGFloat(currentPage), y: 0), animated: currentPage != 0)
    }

}

extension HCForeverViewController:UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        timer = Timer(fireAt: Date(timeInterval: 1.5, since: Date()), interval: 1.5, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetx = scrollView.contentOffset.x

        
        var index:Int = 0
        
        
        if offsetx > imagev1.frame.minX { // 右边
            imagev2.frame.origin.x = scrollView.contentSize.width - scrollWidth
            
            index = imagev1.tag + 1
            
            if index == imageNames.count {
                index = 0
            }
            
        } else {    // 左边
            imagev2.frame.origin.x = 0
            
            index = imagev1.tag - 1
            
            if index < 0 {
                index = imageNames.count - 1
            }
        }
        
        imagev2.tag = index
        
        imagev2.image = UIImage(named: imageNames[index])

     
        
        // 2.5 向左滚或者向右滚
        if offsetx <= 0 || offsetx >= scrollWidth * 2 {
            
            // 交换指针
            let temp = imagev1;
            imagev1 = imagev2;
            imagev2 = temp;
            
            // 交换frame
            imagev1.frame = imagev2.frame;
            
            // 初始化scrollView的偏移量,让其回到最中间
            scrollView.setContentOffset(CGPoint(x: scrollWidth, y: 0), animated: false);
        }
    }
}
