//
//  FQChipmunkView.m
//  FQAnimationSample
//
//  Created by fanqi on 2021/6/4.
//  Copyright © 2021 fanqi. All rights reserved.
//

#import "FQChipmunkView.h"

#define GRAVITY 1000

@interface FQChipmunkView () <UIAccelerometerDelegate>

@property (nonatomic, strong) UIView *canView;

// CADisplayLink
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CFTimeInterval lastStep;

// chipmunk
@property (nonatomic, assign) cpSpace *space;

@end

@implementation FQChipmunkView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self chipmunkInteractionSample];
    }
    return self;
}

- (void)dealloc {
    cpSpaceFree(_space);
}

- (void)setupSubviews {
    [self addSubview:self.canView];
    self.canView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

#pragma mark - Public

- (void)starMotion {
    
}

- (void)stopMotion {
    [_displayLink invalidate];
    _displayLink = nil;
}

#pragma mark - TestCode

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self addCrateWithFrame:CGRectMake(self.canView.frame.size.width * 0.5, self.canView.frame.size.height - 64, 64, 64)];
}

- (void)chipmunkInteractionSample {
    //invert view coordinate system to match physics
    self.layer.geometryFlipped = YES;
    
    //set up physics space
    self.space = cpSpaceNew();
    cpSpaceSetGravity(self.space, cpv(0, -GRAVITY));
    
    //add wall around edge of view
    CGSize size = CGSizeMake(280, 360);
    [self addWallShapeWithStart:cpv(139, size.height - 1) end:cpv(36, size.height - 6)];
    [self addWallShapeWithStart:cpv(36, size.height - 6) end:cpv(31, size.height - 16)];
    [self addWallShapeWithStart:cpv(31, size.height - 16) end:cpv(49, size.height - 49)];
    [self addWallShapeWithStart:cpv(49, size.height - 49) end:cpv(49, size.height - 71)];
    [self addWallShapeWithStart:cpv(49, size.height - 71) end:cpv(20, size.height - 122)];
    [self addWallShapeWithStart:cpv(20, size.height - 122) end:cpv(3, size.height - 172)];
    [self addWallShapeWithStart:cpv(3, size.height - 172) end:cpv(0, size.height - 238)];
    [self addWallShapeWithStart:cpv(0, size.height - 238) end:cpv(20, size.height - 298)];
    [self addWallShapeWithStart:cpv(20, size.height - 298) end:cpv(45, size.height - 335)];
    [self addWallShapeWithStart:cpv(45, size.height - 335) end:cpv(89, size.height - 356)];
    [self addWallShapeWithStart:cpv(89, size.height - 356) end:cpv(139, 1)];
    [self addWallShapeWithStart:cpv(139, 1) end:cpv(size.width - 89, size.height - 356)];
    [self addWallShapeWithStart:cpv(size.width - 89, size.height - 356) end:cpv(size.width - 45, size.height - 335)];
    [self addWallShapeWithStart:cpv(size.width - 45, size.height - 335) end:cpv(size.width - 20, size.height - 298)];
    [self addWallShapeWithStart:cpv(size.width - 20, size.height - 298) end:cpv(size.width, size.height - 238)];
    [self addWallShapeWithStart:cpv(size.width, size.height - 238) end:cpv(size.width - 3, size.height - 172)];
    [self addWallShapeWithStart:cpv(size.width - 3, size.height - 172) end:cpv(size.width - 20, size.height - 122)];
    [self addWallShapeWithStart:cpv(size.width - 20, size.height - 122) end:cpv(size.width - 49, size.height - 71)];
    [self addWallShapeWithStart:cpv(size.width - 49, size.height - 71) end:cpv(size.width - 49, size.height - 49)];
    [self addWallShapeWithStart:cpv(size.width - 49, size.height - 49) end:cpv(size.width - 31, size.height - 16)];
    [self addWallShapeWithStart:cpv(size.width - 31, size.height - 16) end:cpv(size.width - 36, size.height - 6)];
    [self addWallShapeWithStart:cpv(size.width - 36, size.height - 6) end:cpv(139, size.height - 1)];
    
    //add a crates
//    [self addCrateWithFrame:CGRectMake(0, 0, 32, 32)];
//    [self addCrateWithFrame:CGRectMake(32, 0, 32, 32)];
//    [self addCrateWithFrame:CGRectMake(64, 0, 64, 64)];
//    [self addCrateWithFrame:CGRectMake(128, 0, 32, 32)];
//    [self addCrateWithFrame:CGRectMake(0, 32, 64, 64)];
    
    //start the timer
    self.lastStep = CACurrentMediaTime();
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(chipmunkStep:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    //update gravity using accelerometer
    [UIAccelerometer sharedAccelerometer].delegate = self;
    [UIAccelerometer sharedAccelerometer].updateInterval = 1/60.0;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    //update gravity
    cpSpaceSetGravity(self.space, cpv(acceleration.x * GRAVITY, acceleration.y * GRAVITY));
}

- (void)chipmunkStep:(CADisplayLink *)displayLink {
//    //calculate time delta
//    CFTimeInterval thisStep = CACurrentMediaTime();
//    CFTimeInterval stepDuration = thisStep - self.lastStep;
//    self.lastStep = thisStep;
//
//    //update physics
//    cpSpaceStep(self.space, stepDuration);
//
//    //update all the shapes
//    cpSpaceEachShape(self.space, &updateShape, NULL);
    
    
    /// 模拟实践以及固定的时间步长
    #define SIMULATION_STEP (1/120.0)
    
    //calculate frame step duration
    CFTimeInterval frameTime = CACurrentMediaTime();
    
    //update simulation
    while (self.lastStep < frameTime) {
        cpSpaceStep(self.space, SIMULATION_STEP);
        self.lastStep += SIMULATION_STEP;
    }
    
    //update all the shapes cpSpaceEachShape(self.space, &updateShape, NULL);
    cpSpaceEachShape(self.space, &updateShape, NULL);
}

void updateShape(cpShape *shape, void *unused)
{
    //get the crate object associated with the shape
    Crate *crate = (__bridge Crate *)shape->data;
    
    //update crate view position and angle to match physics shape
    cpBody *body = shape->body;
    crate.center = cpBodyGetPos(body);
    crate.transform = CGAffineTransformMakeRotation(cpBodyGetAngle(body));
    
//    NSLog(@"crate centerY: %f", crate.center.y);
}

- (void)addCrateWithFrame:(CGRect)frame {
    Crate *crate = [[Crate alloc] initWithFrame:frame];
    [self.canView addSubview:crate];
    cpSpaceAddBody(self.space, crate.body);
    cpSpaceAddShape(self.space, crate.shape);
}

- (void)addWallShapeWithStart:(cpVect)start end:(cpVect)end {
    cpShape *wall = cpSegmentShapeNew(self.space->staticBody, start, end, 1);
    cpShapeSetCollisionType(wall, 2);
    cpShapeSetFriction(wall, 0.5);
    cpShapeSetElasticity(wall, 0.8);
    cpSpaceAddStaticShape(self.space, wall);
    
    
    // 画线区分下墙的边界
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 4;
    shapeLayer.path = path;
    [self.canView.layer addSublayer:shapeLayer];
    
    CFRelease(path);
}

#pragma mark - Getter

- (UIView *)canView {
    if (!_canView) {
        _canView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 360)];
        _canView.layer.borderColor = [UIColor redColor].CGColor;
        _canView.layer.borderWidth = 2.0;
        
        _canView.layer.contents = (__bridge id)[UIImage imageNamed:@"mood_can"].CGImage;
    }
    return _canView;
}

@end


@implementation Crate

#define MASS 100

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"crate.jpeg"];
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        self.body = cpBodyNew(MASS, cpMomentForBox(MASS, frame.size.width, frame.size.height));
        //create the shape
        cpVect corners[] = {
            cpv(0, 0),
            cpv(0, frame.size.height),
            cpv(frame.size.width, frame.size.height),
            cpv(frame.size.width, 0),
        };
        self.shape = cpPolyShapeNew(self.body, 4, corners, cpv(-frame.size.width/2, -frame.size.height/2));
        
        //set shape friction & elasticity
        cpShapeSetFriction(self.shape, 0.5);
        cpShapeSetElasticity(self.shape, 0.8);
        
        //link the crate to the shape
        //so we can refer to crate from callback later on
        self.shape->data = (__bridge void *)self;
        
        //set the body position to match view
        cpBodySetPos(self.body, cpv(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2));
    }
    return self;
}

- (void)dealloc {
    cpShapeFree(_shape);
    cpBodyFree(_body);
}

@end
