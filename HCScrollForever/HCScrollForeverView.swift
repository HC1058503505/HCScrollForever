//
//  HCScrollForeverView.swift
//  HCScrollForever
//
//  Created by UltraPower on 2017/4/1.
//  Copyright © 2017年 侯聪. All rights reserved.
//

import UIKit

class HCScrollForeverView: UIView {
    fileprivate let scrollV:UIScrollView = UIScrollView()
    var imagev1:UIImageView = UIImageView()
    var imagev2:UIImageView = UIImageView()
    var currentPage:Int = 1
    var timer:Timer?
    var imageNames:[String] = ["1","2","3","4","5","6","7"]
    let pageLabel:UILabel = UILabel()

    init(frame: CGRect, images:[String]) {
        super.init(frame: frame)
        imageNames = images
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(){
        timer = Timer(fireAt: Date(timeInterval: 1.5, since: Date()), interval: 1.5, target: self, selector: #selector(HCScrollForeverView.timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    func stop(){
        timer?.invalidate()
        timer = nil
    }
    
    
    fileprivate func setup() {
        scrollV.frame = bounds
        scrollV.contentSize = CGSize(width: bounds.width * 3.0, height:bounds.height)
        scrollV.isPagingEnabled = true
        scrollV.delegate = self
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.setContentOffset(CGPoint(x: bounds.width, y: 0), animated: false)
        addSubview(scrollV)
        
        imagev1.frame = CGRect(x: bounds.width, y: 0, width: bounds.width, height: 200)
        imagev1.image = UIImage(named: imageNames[0])
        imagev1.tag = 0
        scrollV.addSubview(imagev1)
        
        imagev2.frame = CGRect(x: bounds.width * 2.0, y: 0, width: bounds.width, height: 200)
        scrollV.addSubview(imagev2)
        
        pageLabel.frame = CGRect(x: bounds.width - 50, y: bounds.height - 50, width: 40, height: 40)
        pageLabel.text = "\(imagev1.tag + 1)/\(imageNames.count)"
        pageLabel.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        pageLabel.textAlignment = .center
        addSubview(pageLabel)
        start()

    }
    
    @objc fileprivate func timerAction() {
        
        currentPage += 1
        
        if currentPage == 3 {
            currentPage = 1
        }
        
        scrollV.setContentOffset(CGPoint(x: bounds.width * CGFloat(currentPage), y: 0), animated: currentPage != 0)
    }
    
    
}

extension HCScrollForeverView:UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stop()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        start()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetx = scrollView.contentOffset.x
        
        
        var index:Int = 0
        
        
        if offsetx > imagev1.frame.minX { // 右边
            imagev2.frame.origin.x = scrollView.contentSize.width - bounds.width
            
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
        if offsetx <= 0 || offsetx >= bounds.width * 2 {
            
            // 交换指针
            let temp = imagev1;
            imagev1 = imagev2;
            imagev2 = temp;
            
            // 交换frame
            imagev1.frame = imagev2.frame;
            pageLabel.text = "\(imagev1.tag + 1)/\(imageNames.count)"
            // 初始化scrollView的偏移量,让其回到最中间
            scrollView.setContentOffset(CGPoint(x: bounds.width, y: 0), animated: false);
        }
    }
}

