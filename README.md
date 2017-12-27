# 图片浏览器
> 1. 层级结构
> 2. 缩放后居中
> 3. 滑动结束之前的恢复原来的大小

<!--more-->
## 1. 层级结构

![screenshot](media/screenshot-4.png)

* 一个大的 UIScrollView
* 多个小的 UIScrollView
* 每个小的 UIScrollView 里有一个 UIImageView
* 假设图片之间的间隙为 10
* 大的 UIScrollView 的宽度是屏幕宽度加上 10 乘以 2
* 小的 UIScrollView 的宽度是屏幕宽度
* UIImageView 的高度和屏幕高度相同

## 2. 缩放后居中
### 2.1 缩放

```objc
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        return nil;
    }
    
    for (UIView *view in scrollView.subviews) {
        if ([view  isKindOfClass:[UIImageView class]]) {
            return view;
        }
    }
    return nil;
}
```

### 2.2 缩放后重新设置中心点
缩放后 UIScrollView 的 中心点需要更新，若不更新会感觉图片会向左上角偏.
计算逻辑：
    (当前的宽度 - contentSize.width)/2 就是 x 方向需要移动的大小

```objc
- (void)scrollViewDidZoom:(UIScrollView *)scrollView //这里是缩放进行时调整
{
    for (UIView *view in scrollView.subviews) {
        if ([view  isKindOfClass:[UIImageView class]]) {
            view.center = [self centerOfScrollViewContent:scrollView];
        }
    }
}

#pragma mark - 缩放之后获取 scrollView center
- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    
    return actualCenter;
}

```

## 3. 滑动结束恢复之前缩放的图片
```objc
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        
        NSInteger autualIndex = scrollView.contentOffset.x  / _scrollView.bounds.size.width;
        for (NSInteger i = 0; i < _scrollView.subviews.count; i++) {
            if (i != autualIndex) {
                UIScrollView *scrollView = _scrollView.subviews[i];
                scrollView.zoomScale = 1.0;
            }
        }
    }
}
```


