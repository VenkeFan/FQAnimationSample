//
//  FQRollerCoasterViewController.m
//  FQLoopScrollView
//
//  Created by fanqi on 17/6/26.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQRollerCoasterViewController.h"
#import "FQRollerCoasterView.h"

@interface FQRollerCoasterViewController ()

@end

@implementation FQRollerCoasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FQRollerCoasterView *rollerView = [[FQRollerCoasterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [self.view addSubview:rollerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}

@end
