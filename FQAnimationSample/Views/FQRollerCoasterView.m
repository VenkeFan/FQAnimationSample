//
//  FQRollerCoasterView.m
//  FQLoopScrollView
//
//  Created by fanqi on 17/6/21.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQRollerCoasterView.h"

@implementation FQRollerCoasterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    [self drawBackground];
    [self drawMountain:self.bounds.size];
    [self drawGrass:self.bounds.size];
    [self drawGround:self.bounds.size];
    [self drawTrees:self.bounds.size];
    [self drawCloud:self.bounds.size];
    [self drawYellowPath:self.bounds.size];
    [self drawGreenPath:self.bounds.size];
}

/**
 绘制背景颜色
 */
- (void)drawBackground {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)[self corlorWithRed:178 green:226 blue:248].CGColor,
                     (__bridge id)[self corlorWithRed:232 green:244 blue:193].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:gradientLayer];
}

/**
 绘制山峰
 */
- (void)drawMountain:(CGSize)size {
    
    // 第二座
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(size.width / 4, size.height - 90)];
        [path addLineToPoint:CGPointMake(size.width / 2.7, 200)];
        [path addLineToPoint:CGPointMake(size.width / 1.8, size.height - 85)];
        [path addLineToPoint:CGPointMake(size.width / 1.6, size.height - 125)];
        [path addLineToPoint:CGPointMake(size.width / 1.35, size.height - 70)];
        [path addLineToPoint:CGPointMake(0, size.height)];
        [self setShapeLayer:path.CGPath color:[UIColor whiteColor].CGColor];
        
        
        UIBezierPath *subPath = [UIBezierPath bezierPath];
        [subPath moveToPoint:CGPointMake(0, size.height)];
        [subPath addLineToPoint:CGPointMake(size.width / 4, size.height - 90)];
        
        CGFloat pointX1 = size.width / 4 + 50, pointX2 = size.width / 2.2;
        CGFloat height1 = [self calculatePointYWithPointX:pointX1
                                                   point1:CGPointMake(size.width / 4, size.height - 90)
                                                   point2:CGPointMake(size.width / 2.7, 200)];
        CGFloat height2 = [self calculatePointYWithPointX:pointX2
                                                   point1:CGPointMake(size.width / 2.7, 200)
                                                   point2:CGPointMake(size.width / 1.8, size.height - 85)];
        
        CGFloat pointX3 = size.width / 1.67, pointX4 = size.width / 1.50;
        CGFloat height3 = [self calculatePointYWithPointX:pointX3
                                                   point1:CGPointMake(size.width / 1.8, size.height - 85)
                                                   point2:CGPointMake(size.width / 1.6, size.height - 125)];
        CGFloat height4 = [self calculatePointYWithPointX:pointX4
                                                   point1:CGPointMake(size.width / 1.6, size.height - 125)
                                                   point2:CGPointMake(size.width / 1.35, size.height - 70)];
        
        [subPath addLineToPoint:CGPointMake(pointX1, height1)];
        [subPath addLineToPoint:CGPointMake(pointX1 + 20, height1 + 15)];
        [subPath addLineToPoint:CGPointMake(pointX1 + 40, height1)];
        [subPath addLineToPoint:CGPointMake(pointX1 + 60, height1 + 15)];
        [subPath addLineToPoint:CGPointMake(pointX2, height2)];
        [subPath addLineToPoint:CGPointMake(size.width / 1.8, size.height - 85)];
        [subPath addLineToPoint:CGPointMake(pointX3, height3)];
        [subPath addLineToPoint:CGPointMake(size.width / 1.65, height3 + 5)];
        [subPath addLineToPoint:CGPointMake(size.width / 1.60, height3 - 2)];
        [subPath addLineToPoint:CGPointMake(size.width / 1.58, height4 + 2)];
        [subPath addLineToPoint:CGPointMake(size.width / 1.55, height4 - 5)];
        [subPath addLineToPoint:CGPointMake(pointX4, height4)];
        [subPath addLineToPoint:CGPointMake(size.width / 1.35, size.height - 70)];
        [subPath addLineToPoint:CGPointMake(0, size.height)];
        [self setShapeLayer:subPath.CGPath color:[self corlorWithRed:72 green:70 blue:110].CGColor];
    }
    
    // 第一座
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, size.height - 120)];
        [path addLineToPoint:CGPointMake(100, 100)];
        [path addLineToPoint:CGPointMake(size.width / 3, size.height - 100)];
        [path addLineToPoint:CGPointMake(size.width / 1.5, size.height - 50)];
        [path addLineToPoint:CGPointMake(0, size.height)];
        [self setShapeLayer:path.CGPath color:[UIColor whiteColor].CGColor];
        
        
        UIBezierPath *subPath = [UIBezierPath bezierPath];
        [subPath moveToPoint:CGPointMake(0, size.height - 120)];
        
        CGFloat pointX1 = 55, pointX2 = 160;
        CGFloat height1 = [self calculatePointYWithPointX:pointX1
                                                   point1:CGPointMake(0, size.height - 120)
                                                   point2:CGPointMake(100, 100)];
        CGFloat height2 = [self calculatePointYWithPointX:pointX2 point1:CGPointMake(100, 100)
                                                   point2:CGPointMake(size.width / 3, size.height - 100)];
        
        [subPath addLineToPoint:CGPointMake(pointX1, height1)];
        [subPath addLineToPoint:CGPointMake(70, height1 + 15)];
        [subPath addLineToPoint:CGPointMake(90, height1)];
        [subPath addLineToPoint:CGPointMake(110, height1 + 25)];
        [subPath addLineToPoint:CGPointMake(130, height1 - 5)];
        [subPath addLineToPoint:CGPointMake(pointX2, height2)];
        [subPath addLineToPoint:CGPointMake(size.width / 3, size.height - 100)];
        [subPath addLineToPoint:CGPointMake(size.width / 1.5, size.height - 50)];
        [subPath addLineToPoint:CGPointMake(0, size.height)];
        [self setShapeLayer:subPath.CGPath color:[self corlorWithRed:100 green:99 blue:155].CGColor];
    }
}

/**
 绘制草坪
 */
- (void)drawGrass:(CGSize)size {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, size.height - 20)];
    [path addLineToPoint:CGPointMake(0, size.height - 100)];
    [path addQuadCurveToPoint:CGPointMake(size.width / 3, size.height - 50) controlPoint:CGPointMake(size.width / 6, size.height - 100)];
    [path addQuadCurveToPoint:CGPointMake(size.width, size.height - 60) controlPoint:CGPointMake(size.width / 2, size.height - 100)];
    [path addLineToPoint:CGPointMake(size.width, size.height - 20)];
    [self setShapeLayer:path.CGPath color:[self corlorWithRed:116 green:179 blue:54].CGColor];
}

/**
 绘制土地
 */
- (void)drawGround:(CGSize)size {
    CGFloat width = 134, height = 20;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(width / 2, size.height - height / 2, width, height);
    replicatorLayer.instanceCount = ceil(size.width / width);
    [self.layer addSublayer:replicatorLayer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, width, 0, 0);
    replicatorLayer.instanceTransform = transform;
    
    CALayer *layer = [CALayer layer];
    layer.bounds = replicatorLayer.bounds;
    layer.contentsGravity = kCAGravityResize;
    layer.contents = (__bridge id)[UIImage imageNamed:@"ground"].CGImage;
    [replicatorLayer addSublayer:layer];
}

/**
 绘制树
 */
- (void)drawTrees:(CGSize)size {
    id cgImg = (__bridge id)[UIImage imageNamed:@"tree"].CGImage;
    
    for (int i = 0; i < 7; i++) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake([@[@(5),@(55),@(70),@(size.width/3+15),@(size.width/3+25),@(size.width-130),@(size.width-160)][i] floatValue],
                                 size.height - 43, 13, 23);
        layer.contents = cgImg;
        [self.layer addSublayer:layer];
    }
    for (int i = 0; i < 4; i++) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake([@[@(10),@(60),@(size.width/3),@(size.width-150)][i] floatValue],
                                 size.height - 52, 18, 32);
        layer.contents = cgImg;
        [self.layer addSublayer:layer];
    }
    for (int i = 0; i < 2; i++) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake([@[@(size.width-210),@(size.width-50)][i] floatValue],
                                 [@[@(size.height - 75),@(size.height - 80)][i] floatValue], 18, 32);
        layer.contents = cgImg;
        [self.layer addSublayer:layer];
    }
    for (int i = 0; i < 3; i++) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake([@[@(size.width-235),@(size.width-220),@(size.width-40)][i] floatValue],
                                 [@[@(size.height - 67),@(size.height - 67),@(size.height - 72)][i] floatValue], 13, 23);
        layer.contents = cgImg;
        [self.layer addSublayer:layer];
    }
}

/**
 绘制云朵
 */
- (void)drawCloud:(CGSize)size {
    CGFloat width = 63, height = 20;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(-width, 40, width, height);
    layer.contents = (id)[UIImage imageNamed:@"cloud"].CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    [self.layer addSublayer:layer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[@(-width), @(size.width + width)];
    animation.duration = 30;
    animation.repeatCount = INFINITY;
    animation.calculationMode = kCAAnimationPaced;
    [layer addAnimation:animation forKey:nil];
}

/**
 绘制黄色轨道
 */
- (void)drawYellowPath:(CGSize)size {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width + 10, size.height - 20)];
    [path addLineToPoint:CGPointMake(size.width + 10, 100)];
    [path addCurveToPoint:CGPointMake(size.width / 2 - 100, size.height - 70)
            controlPoint1:CGPointMake(size.width - 100, 10)
            controlPoint2:CGPointMake(size.width / 2 + 100, size.height - 60)];
    [path addCurveToPoint:CGPointMake(-10, size.height - 70)
            controlPoint1:CGPointMake(size.width / 2 - 140, size.height - 70)
            controlPoint2:CGPointMake(90, size.height - 150)];
    [path addLineToPoint:CGPointMake(-10, size.height - 20)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    [pathLayer setStrokeColor:[self corlorWithRed:208 green:176 blue:69].CGColor];
    [pathLayer setFillColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor];
    [pathLayer setLineWidth:5];
    pathLayer.path = path.CGPath;
    [self.layer addSublayer:pathLayer];
    
    {
        // 轨道虚线
        CAShapeLayer *dashShapeLayer = [CAShapeLayer layer];
        dashShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashShapeLayer.fillColor = [UIColor clearColor].CGColor;
        dashShapeLayer.lineWidth = 2;
        dashShapeLayer.lineCap = kCALineCapRound;
        dashShapeLayer.lineJoin = kCALineJoinRound;
        dashShapeLayer.lineDashPattern = @[@(3), @(6)];
        dashShapeLayer.path = path.CGPath;
        [pathLayer addSublayer:dashShapeLayer];
    }
    
    {
        // 动画
        CGFloat width = 17, height = 11;
        
        for (int i = 0; i < 5; i++) {
            
            CALayer *carLayer = [CALayer layer];
            carLayer.anchorPoint = CGPointMake(0.5, 0.0);
            carLayer.frame = CGRectMake(size.width + 10 + (width + 2) * i, 60, width, height);
            carLayer.contentsGravity = kCAGravityResizeAspect;
            carLayer.contents = (id)[UIImage imageNamed:@"otherCar"].CGImage;
            [self.layer addSublayer:carLayer];
            
            
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"position";
            animation.duration = 5;
            animation.path = path.CGPath;
            animation.calculationMode = kCAAnimationPaced;
            animation.rotationMode = kCAAnimationRotateAuto;
            animation.repeatCount = INFINITY;
            // 设置每辆车的动画开始时间，这样才能看起来是一串过山车在移动
            animation.beginTime = CACurrentMediaTime() + i * 0.09;
            [carLayer addAnimation:animation forKey:nil];
        }
    }
}

/**
 绘制绿色轨道
 */
- (void)drawGreenPath:(CGSize)size {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-10, size.height - 20)];
    [path addLineToPoint:CGPointMake(-10, size.height - 100)];
    [path addCurveToPoint:CGPointMake(size.width / 2, size.height - 70)
                 controlPoint1:CGPointMake(size.width / 4.6, size.height - 180)
            controlPoint2:CGPointMake(size.width / 2 - 25, size.height - 70)];
    [path addArcWithCenter:CGPointMake(size.width / 1.9, size.height - 140) radius:70 startAngle:M_PI_2 endAngle:M_PI * -1.5 clockwise:NO];
    [path addCurveToPoint:CGPointMake(size.width, size.height - 80)
            controlPoint1:CGPointMake(size.width / 1.7, size.height - 70)
            controlPoint2:CGPointMake(size.width * 3 / 4, size.height - 150)];
    [path addLineToPoint:CGPointMake(size.width + 10, size.height - 20)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    [pathLayer setStrokeColor:[self corlorWithRed:58 green:144 blue:161].CGColor];
    [pathLayer setFillColor:[UIColor clearColor].CGColor];
    [pathLayer setLineWidth:5];
    [pathLayer setLineCap:kCALineCapRound];
    [pathLayer setLineJoin:kCALineJoinRound];
    pathLayer.path = path.CGPath;
    [self.layer addSublayer:pathLayer];
    
    {
        // 轨道虚线
        CAShapeLayer *dashShapeLayer = [CAShapeLayer layer];
        dashShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashShapeLayer.fillColor = [UIColor clearColor].CGColor;
        dashShapeLayer.lineWidth = 2;
        dashShapeLayer.lineCap = kCALineCapRound;
        dashShapeLayer.lineJoin = kCALineJoinRound;
        dashShapeLayer.lineDashPattern = @[@(3), @(6)];
        dashShapeLayer.path = path.CGPath;
        [pathLayer addSublayer:dashShapeLayer];
    }
    
    {
        // 轨道支架
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(-10, size.height - 20)];
        [path addLineToPoint:CGPointMake(-10, size.height - 100)];
        [path addCurveToPoint:CGPointMake(size.width / 2, size.height - 70)
                controlPoint1:CGPointMake(size.width / 4.6, size.height - 180)
                controlPoint2:CGPointMake(size.width / 2 - 25, size.height - 70)];
        [path addCurveToPoint:CGPointMake(size.width, size.height - 80)
                controlPoint1:CGPointMake(size.width / 1.7, size.height - 70)
                controlPoint2:CGPointMake(size.width * 3 / 4, size.height - 150)];
        [path addLineToPoint:CGPointMake(size.width + 10, size.height - 20)];
        
        CAShapeLayer *holderLayer = [CAShapeLayer layer];
        [holderLayer setFillColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]].CGColor];
        holderLayer.path = path.CGPath;
        [self.layer insertSublayer:holderLayer below:pathLayer];
    }
    
    {
        // 动画
        CGFloat width = 17, height = 11;
        
        for (int i = 0; i < 5; i++) {
            CALayer *carLayer = [CALayer layer];
            carLayer.anchorPoint = CGPointMake(0.5, 0.9);
            carLayer.frame = CGRectMake(-10 - (width + 2) * i, size.height - 80, width, height);
            carLayer.contentsGravity = kCAGravityResizeAspect;
            carLayer.contents = (id)[UIImage imageNamed:@"car"].CGImage;
            [self.layer addSublayer:carLayer];
            
            
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"position";
            animation.duration = 6;
            animation.path = path.CGPath;
            animation.calculationMode = kCAAnimationPaced;
            animation.rotationMode = kCAAnimationRotateAuto;
            animation.repeatCount = INFINITY;
            // 设置每辆车的动画开始时间，这样才能看起来是一串过山车在移动
            animation.beginTime = CACurrentMediaTime() + i * 0.09;
            [carLayer addAnimation:animation forKey:nil];
        }
    }
}

#pragma mark - Tools

/**
 根据正切函数获取两点之间的某个点

 @param pointX 该点的X值
 @param point1 起点
 @param point2 终点
 @return 该点的Y值
 */
- (CGFloat)calculatePointYWithPointX:(CGFloat)pointX point1:(CGPoint)point1 point2:(CGPoint)point2 {
    CGFloat tanA = (point2.y - point1.y) / (point2.x - point1.x);
    return tanA * (pointX - point1.x) + point1.y;
}

- (void)setShapeLayer:(CGPathRef)path color:(CGColorRef)color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:color];
    shapeLayer.path = path;
    [self.layer addSublayer:shapeLayer];
}

- (UIColor *)corlorWithRed:(CGFloat)red green:(CGFloat)greed blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0 green:greed/255.0 blue:blue/255.0 alpha:1];
}

@end
