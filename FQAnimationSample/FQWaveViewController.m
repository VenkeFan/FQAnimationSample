//
//  FQWaveViewController.m
//  FQLoopScrollView
//
//  Created by fanqi on 17/6/26.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQWaveViewController.h"
#import "FQWaveView.h"

@interface FQWaveViewController ()

@end

@implementation FQWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FQWaveView *waveView = [[FQWaveView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    [self.view addSubview:waveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
