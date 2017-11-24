//
//  FQ3DLoopScrollView.h
//  FQLoopScrollView
//
//  Created by fanqi on 17/6/15.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FQ3DLoopScrollViewDelegate <NSObject>


@end

@protocol FQ3DLoopScrollViewDataSource <NSObject>

- (NSInteger)loopView:(UITableView *)loopView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)loopView:(UITableView *)loopView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FQ3DLoopScrollView : UIView

@property (nonatomic, weak) id<FQ3DLoopScrollViewDelegate> delegate;
@property (nonatomic, weak) id<FQ3DLoopScrollViewDataSource> dataSource;

@end
