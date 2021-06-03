//
//  FQDynamicAnimatorView.m
//  FQAnimationSample
//
//  Created by fanqi on 2021/6/3.
//  Copyright © 2021 fanqi. All rights reserved.
//

#import "FQDynamicAnimatorView.h"
#import <CoreMotion/CoreMotion.h>

@interface FQDynamicAnimatorView ()

@property (nonatomic, strong) UIView *canView;
@property (nonatomic, strong) CMMotionManager *manager;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamic;
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation FQDynamicAnimatorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.canView];
    self.canView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

#pragma mark - TestCode

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.canView.frame.size.width * 0.5 - 10, 0, 40, 40)];
    view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    [self.canView addSubview:view];
    
    [self.gravity addItem:view];
    [self.collision addItem:view];
    [self.dynamic addItem:view];
}

#pragma mark - Public

- (void)starMotion {
    if (!self.manager.isDeviceMotionAvailable) {
        return;
    }
    
    self.manager.deviceMotionUpdateInterval = 0.01;
    
    __weak typeof(self) weakSelf = self;
    [self.manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        
        if (error != nil) {
            return;
        }
        weakSelf.gravity.gravityDirection = CGVectorMake(motion.gravity.x * 3, -motion.gravity.y * 3);
    }];
}

- (void)stopMotion {
    if (self.manager.isDeviceMotionActive) {
        [self.manager stopDeviceMotionUpdates];
    }
}

#pragma mark - Private



#pragma mark - Getter

- (UIView *)canView {
    if (!_canView) {
        _canView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 360)];
        _canView.layer.contents = (__bridge id)[UIImage imageNamed:@"mood_can"].CGImage;
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 4.0;
        shapeLayer.path = self.path.CGPath;
        [_canView.layer addSublayer:shapeLayer];
    }
    return _canView;
}

- (CMMotionManager *)manager {
    if (!_manager) {
        _manager = [[CMMotionManager alloc] init];
    }
    return _manager;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.canView];
    }
    return _animator;
}

- (UIGravityBehavior *)gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

- (UICollisionBehavior *)collision {
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        _collision.collisionMode = UICollisionBehaviorModeEverything;
        [_collision addBoundaryWithIdentifier:@"MyBezierPath" forPath:self.path];
        [self.animator addBehavior:_collision];
    }
    
    return _collision;
}

- (UIDynamicItemBehavior *)dynamic {
    if (!_dynamic) {
        _dynamic = [[UIDynamicItemBehavior alloc] init];
        _dynamic.friction = 0.2;
        _dynamic.elasticity = 0.3;
        _dynamic.density = 0.2;
        _dynamic.allowsRotation = YES;
        _dynamic.resistance = 0;
        [self.animator addBehavior:_dynamic];
    }
    return _dynamic;
}

- (UIBezierPath *)path {
    if (!_path) {
        CGSize size = self.canView.frame.size;
        
        _path = [UIBezierPath bezierPath];
        [_path moveToPoint:CGPointMake(139, 1)];
        [_path addLineToPoint:CGPointMake(36, 6)];
        [_path addLineToPoint:CGPointMake(31, 16)];
        [_path addLineToPoint:CGPointMake(49, 49)];
        [_path addLineToPoint:CGPointMake(49, 71)];
        [_path addLineToPoint:CGPointMake(20, 122)];
        [_path addLineToPoint:CGPointMake(3, 172)];
        [_path addLineToPoint:CGPointMake(0, 238)];
        [_path addLineToPoint:CGPointMake(20, 298)];
        [_path addLineToPoint:CGPointMake(45, 335)];
        [_path addLineToPoint:CGPointMake(89, 356)];
        [_path addLineToPoint:CGPointMake(139, size.height - 1)];
        [_path addLineToPoint:CGPointMake(size.width - 89, 356)];
        [_path addLineToPoint:CGPointMake(size.width - 45, 335)];
        [_path addLineToPoint:CGPointMake(size.width - 20, 298)];
        [_path addLineToPoint:CGPointMake(size.width, 238)];
        [_path addLineToPoint:CGPointMake(size.width - 3, 172)];
        [_path addLineToPoint:CGPointMake(size.width - 20, 122)];
        [_path addLineToPoint:CGPointMake(size.width - 49, 71)];
        [_path addLineToPoint:CGPointMake(size.width - 49, 49)];
        [_path addLineToPoint:CGPointMake(size.width - 31, 16)];
        [_path addLineToPoint:CGPointMake(size.width - 36, 6)];
        [_path closePath];
    }
    return _path;
}
@end
