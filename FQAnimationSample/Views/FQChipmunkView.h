//
//  FQChipmunkView.h
//  FQAnimationSample
//
//  Created by fanqi on 2021/6/4.
//  Copyright © 2021 fanqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chipmunk.h"

NS_ASSUME_NONNULL_BEGIN

@interface FQChipmunkView : UIView

- (void)starMotion;
- (void)stopMotion;

@end

@interface Crate : UIImageView

@property (nonatomic, assign) cpBody *body;
@property (nonatomic, assign) cpShape *shape;

@end

NS_ASSUME_NONNULL_END
