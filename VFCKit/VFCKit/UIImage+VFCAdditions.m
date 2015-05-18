//
//  UIImage+VFCAdditions.m
//  VFCKit
//

#import "UIImage+VFCAdditions.h"

#pragma mark - UIImage (VFCAdditions)

@implementation UIImage (VFCAdditions)

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor {
    return [self tintedImageWithColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor {
    return [self tintedImageWithColor:tintColor blendMode:kCGBlendModeOverlay];
}

#pragma mark Private

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor blendMode:(CGBlendMode)mode {
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0);
    [tintColor setFill];
    
    CGRect bounds = CGRectMake(0.0, 0.0, [self size].width, [self size].height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:mode alpha:1.0];
    if (mode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
