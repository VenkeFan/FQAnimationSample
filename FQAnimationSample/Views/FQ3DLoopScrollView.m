//
//  FQ3DLoopScrollView.m
//  FQLoopScrollView
//
//  Created by fanqi on 17/6/15.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQ3DLoopScrollView.h"

#define kMaxCount       3
#define kOriginX        30
#define kOriginY        60
#define kWidth          (self.bounds.size.width - kOriginX * 2)
#define kHeight         (kWidth * 375 / 667.0)
#define kPaddingX       15

@interface FQ3DLoopScrollView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSMutableArray<UIView *> *visibleViews;

@end

@implementation FQ3DLoopScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    self.scrollView.frame = CGRectMake(kOriginX, 10, kWidth, self.bounds.size.height - 20);
    self.scrollView.contentSize = CGSizeMake(kWidth * kMaxCount, 0);
    
    for (int i = 0; i < kMaxCount; i++) {
        UIView *bgView = [self subViewWithFrame:CGRectMake(i * kWidth, kOriginY, kWidth, kHeight)
                                          color:self.colors[i]
                                          index:i];
        [self.scrollView addSubview:bgView];
        
        [self.visibleViews addObject:bgView];
    }
}

- (UIView *)subViewWithFrame:(CGRect)frame color:(UIColor *)color index:(int)index{
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = color;
    bgView.layer.speed = 0;
    
    bgView.frame = UIEdgeInsetsInsetRect(bgView.frame, UIEdgeInsetsMake(0, kPaddingX, 0, kPaddingX));
    
    if (index == 0) {
        bgView.layer.zPosition = 0;
        bgView.layer.opacity = 1.0;
    } else {
        bgView.layer.zPosition = -30;
        bgView.layer.opacity = 0.3;
    }

    [bgView.layer addAnimation:[self animation3DWithIndex:index] forKey:nil];
    
    return bgView;
}

- (CAAnimation *)animation3DWithIndex:(int)index {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *zAni = [CABasicAnimation animation];
    zAni.keyPath = @"zPosition";
    zAni.toValue = index == 0 ? @(-30) : @(0);
    
    CABasicAnimation *opacityAni = [CABasicAnimation animation];
    opacityAni.keyPath = @"opacity";
    opacityAni.toValue = index == 0 ? @(0.3) : @(1.0);
    
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = 1.0;
    group.animations = @[zAni, opacityAni];
    
    return group;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSInteger currentIndex = ceil(offset);
    NSInteger preIndex = currentIndex - 1;
    
    if (currentIndex >= self.visibleViews.count) {
        return;
    }
    
//    // transform3D
    if (preIndex > 0) {
        self.visibleViews[preIndex].layer.timeOffset = currentIndex - offset;
        self.visibleViews[currentIndex].layer.timeOffset = offset > preIndex ? offset - preIndex : offset;
        
    } else if (preIndex == 0) {
        CFTimeInterval timeOffset = offset > preIndex ? offset - preIndex : offset;
        
        self.visibleViews[preIndex].layer.timeOffset = timeOffset;
        self.visibleViews[currentIndex].layer.timeOffset = timeOffset;
    }
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat offset = scrollView.contentOffset.x / self.scrollView.bounds.size.width;
//    NSInteger currentIndex = ceil(offset);
//    
//    // loop
//    if (currentIndex == self.visibleViews.count - 1) {
//        
//        CGRect lastFrame = self.visibleViews.lastObject.frame;
//        
//        for (NSInteger i = self.visibleViews.count - 1; i >= 0 ; i--) {
//            UIView *view = self.visibleViews[i];
//            if (i == 0) {
//                view.frame = lastFrame;
//            } else {
//                view.frame = self.visibleViews[i - 1].frame;
//            }
//        }
//        
//        [scrollView setContentOffset:CGPointMake((currentIndex - 1) * kWidth, 0)];
//        
//    } else if (currentIndex == 0) {
//        
//        CGRect firstFrame = self.visibleViews.firstObject.frame;
//        
//        for (NSInteger i = 0; i < self.visibleViews.count; i++) {
//            UIView *view = self.visibleViews[i];
//            if (i == self.visibleViews.count - 1) {
//                view.frame = firstFrame;
//            } else {
//                view.frame = self.visibleViews[i + 1].frame;
//            }
//        }
//        
//        [scrollView setContentOffset:CGPointMake((currentIndex + 1) * kWidth, 0)];
//    }
//}

#pragma mark - Getter & Setter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.clipsToBounds = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500.0;
        scrollView.layer.sublayerTransform = transform;
    }
    return _scrollView;
}

- (NSArray *)colors {
    if (!_colors) {
        _colors = @[[UIColor redColor], [UIColor cyanColor], [UIColor magentaColor]];
    }
    return _colors;
}

- (NSMutableArray<UIView *> *)visibleViews {
    if (!_visibleViews) {
        _visibleViews = [NSMutableArray array];
    }
    return _visibleViews;
}

@end
