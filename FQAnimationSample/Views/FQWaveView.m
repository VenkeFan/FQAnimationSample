//
//  FQWaveView.m
//  FQLoopScrollView
//
//  Created by fanqi on 17/6/21.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQWaveView.h"

@interface FQWaveView ()

@property (nonatomic, weak) CAShapeLayer *shapeLayer;
@property (nonatomic, weak) UIView *iconView;

@property (nonatomic, assign) CGFloat waveA;
@property (nonatomic, assign) CGFloat waveW;
@property (nonatomic, assign) CGFloat waveU;
@property (nonatomic, assign) CGFloat waveK;
@property (nonatomic, assign) CGFloat offset;       ///< 波浪曲线的初始偏移量
@property (nonatomic, assign) CGFloat offsetX;      ///< 波浪曲线每次刷新偏移量

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation FQWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        
        [self layoutUI];
    }
    return self;
}


/**
 初始化默认参数
 */
- (void)initialize {
    /*
     正弦曲线公式: y=Asin(ωx+u)+k
     
     A——振幅，当物体作轨迹符合正弦曲线的直线往复运动时，其值为行程的1/2。
     (ωx+u)——相位，反映变量y所处的状态。
     u——初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
     k——偏距，反映在坐标系上则为图像的上移或下移。
     ω——角速度， 控制正弦周期(单位角度内震动的次数)。
     */
    
    _waveA = 8;
    _waveW = M_PI / 180;
    _waveU = M_PI * 3 / 8;
    _waveK = 80;
    _offset = 0;
    _offsetX = 0.03;
}

- (void)layoutUI {
    [self drawWave:self.offset];
    
    CGFloat centerY = [self calculateWaveY:self.bounds.size.width / 2.0 offset:self.offset];
    self.iconView.center = CGPointMake(self.bounds.size.width / 2.0, centerY - self.iconView.bounds.size.height / 2.0 - self.shapeLayer.lineWidth);
    
    
    // 头像的偏移角度
    CGFloat angel = atan(self.waveA * (M_PI / 60) * cos(self.waveW * (self.bounds.size.width / 2.0) + self.offset + self.waveU));
    self.iconView.transform = CGAffineTransformMakeRotation(angel / M_PI);
}

/**
 绘制正弦曲线

 @param offset 曲线的偏移量
 */
- (void)drawWave:(CGFloat)offset {
    CGFloat y = 0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (int x = 0; x <= self.bounds.size.width; x++) {
        y = [self calculateWaveY:x offset:offset];
        if (x == 0) {
            [path moveToPoint:CGPointMake(x, y)];
        } else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    self.shapeLayer.path = path.CGPath;
}

/**
 计算波浪曲线的y值
 
 @param x 波浪曲线的x值
 @param offset 曲线的偏移量
 */
- (CGFloat)calculateWaveY:(CGFloat)x offset:(CGFloat)offset{
    return self.waveA * sin(self.waveW * x + offset + self.waveU) + self.waveK;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    } else {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimate)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)waveAnimate {
    self.offset += self.offsetX;
    
    [self layoutUI];
}

#pragma mark - Getter

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 2;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:shapeLayer];
        
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

- (UIView *)iconView {
    if (!_iconView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        view.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:view];
        
        _iconView = view;
    }
    return _iconView;
}

@end
