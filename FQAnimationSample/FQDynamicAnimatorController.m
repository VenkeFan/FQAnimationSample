//
//  FQDynamicAnimatorController.m
//  FQAnimationSample
//
//  Created by fanqi on 2021/6/3.
//  Copyright © 2021 fanqi. All rights reserved.
//

#import "FQDynamicAnimatorController.h"
#import "FQDynamicAnimatorView.h"

@interface FQDynamicAnimatorController ()

@property (nonatomic, strong) FQDynamicAnimatorView *dynamicView;

@end

@implementation FQDynamicAnimatorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dynamicView = [[FQDynamicAnimatorView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    [self.view addSubview:self.dynamicView];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame = CGRectMake(0, 0, 80, 30);
    startBtn.center = CGPointMake(self.view.frame.size.width * 0.5 - 10 - 40, self.view.bounds.size.height - 100);
    [startBtn setTitle:@"StartMotion" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    stopBtn.frame = CGRectMake(0, 0, 80, 30);
    stopBtn.center = CGPointMake(self.view.frame.size.width * 0.5 + 10 + 40, self.view.bounds.size.height - 100);
    [stopBtn setTitle:@"StopMotion" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
}

- (void)startBtnOnClicked {
    [self.dynamicView starMotion];
}

- (void)stopBtnOnClicked {
    [self.dynamicView stopMotion];
}

@end
