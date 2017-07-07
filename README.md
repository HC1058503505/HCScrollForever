# HCScrollForever
> 图片无限轮播

# 方法一
假设有7张图片，使用一个`UIScrollView`，设置它的`contentSize`为screenWidth * 7,然后在上面依次添加7个UIImageView并设置图片。开启定时器后，在定时器方法里进行处理，主要是确定当前页数的索引，然后就可以设置UIScrollView的contentOffSet，在当前页索引大于6时，设置contentOffSet的动画为false，在视觉上实现了无限循环
```swift
// 设置contentSize
let sizeWidth:CGFloat = scrollWidth * CGFloat(imageNames.count)    
scrollV.contentSize = CGSize(width: sizeWidth, height: 200)

// 确定索引
func timerAction() {
    if scrollV.contentOffset.x < scrollWidth * CGFloat(imageNames.count - 1){
        currentPage += 1
    } else {
        currentPage = 0
    }
    scrollV.setContentOffset(CGPoint(x: scrollWidth * CGFloat(currentPage), y: 0), animated: currentPage != 0)
}
```

# 方法二
假设有7张图片，使用一个`UIScrollView`,设置它的`contentSize`为screenWidth * 3，然后依次添加2个UIImageView并设置图片。开启定时器后，在定时器方法里进行处理，主要确定当前页的索引，但是控制在1~3，然后设置UIScrollView的contentOffSet以及动画，在UIScrollView滑动的时候，要调整UIImageView的图片以及位置
```swift
// 设置contentSize
scrollV.contentSize = CGSize(width: bounds.width * 3.0, height:bounds.height)

// 确定索引
@objc fileprivate func timerAction() {
    
    currentPage += 1
    
    if currentPage == 3 {
        currentPage = 1
    }
    
    scrollV.setContentOffset(CGPoint(x: bounds.width * CGFloat(currentPage), y: 0), animated: currentPage != 0)
}

// 调整UIImageView的图片与位置
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

// 应用
let scollView:HCScrollForeverView = HCScrollForeverView(frame: CGRect(x: x, y: y, width: width, height: height), images: imageNames)
view.addSubview(scollView)
```
