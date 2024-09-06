//
//  ShimmeringView.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import "ShimmeringView.h"

@implementation ShimmeringView

NSString *const ShimmerAnimationKey = @"shimmer";

- (BOOL)getShimmeringStatus {
    return [self.layer.mask.animationKeys containsObject:ShimmerAnimationKey];
}

- (void)setShimmingStatus:(BOOL)status {
    status ? [self startShimmering] : [self stopShimmering];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isShimmering) {
        [self stopShimmering];
        [self startShimmering];
    }
}

- (void)startShimmering {
    id white = (id)UIColor.whiteColor.CGColor;
    id alpha = (id)[UIColor.whiteColor colorWithAlphaComponent:0.3].CGColor;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CAGradientLayer *gradient = [[CAGradientLayer alloc] init];
    gradient.colors = @[alpha, white, alpha];
    gradient.startPoint = CGPointMake(0.0, 0.4);
    gradient.endPoint = CGPointMake(1.0, 0.6);
    gradient.locations = @[@0.4, @0.5, @0.6];
    gradient.frame = CGRectMake(-width, 0, width * 3, height);
    self.layer.mask = gradient;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@0.0, @0.1, @0.2];
    animation.toValue = @[@0.8, @0.9, @1.0];
    animation.duration = 1.25;
    animation.repeatCount = INFINITY;
    [gradient addAnimation:animation forKey:ShimmerAnimationKey];
}

- (void)stopShimmering {
    self.layer.mask = nil;
}

@end
