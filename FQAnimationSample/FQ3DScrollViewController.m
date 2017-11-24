//
//  FQ3DScrollViewController.m
//  FQLoopScrollView
//
//  Created by fanqi on 17/6/26.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQ3DScrollViewController.h"
#import "FQ3DLoopScrollView.h"

@interface FQ3DScrollViewController ()

@end

@implementation FQ3DScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FQ3DLoopScrollView *scrollView = [[FQ3DLoopScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,
                                                                                          self.view.bounds.size.height - 64)];
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
