//
//  FQChipmunkViewController.m
//  FQAnimationSample
//
//  Created by fanqi on 2021/6/4.
//  Copyright © 2021 fanqi. All rights reserved.
//

#import "FQChipmunkViewController.h"
#import "FQChipmunkView.h"

@interface FQChipmunkViewController ()

@property (nonatomic, strong) FQChipmunkView *chipmunkView;

@end

@implementation FQChipmunkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.chipmunkView = [[FQChipmunkView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    [self.view addSubview:self.chipmunkView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.chipmunkView stopMotion];
}

@end
