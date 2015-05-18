//
//  UIColor+VFCAdditions.m
//  VFCKit
//

#import "UIColor+VFCAdditions.h"

#pragma mark - UIColor (VFCAdditions)

@implementation UIColor (VFCAdditions)

+ (UIColor *)interactiveColor {
    return [UIColor normalizedColorWithRed:0.0 green:88.0 blue:254.0 alpha:1.0];
}

+ (UIColor *)venturaFoodsBlueColor {
    return [UIColor normalizedColorWithRed:27.0 green:39.0 blue:119.0 alpha:1.0];
}

+ (UIColor *)venturaFoodsBlackColor {
    return [UIColor normalizedColorWithRed:2.0 green:2.0 blue:2.0 alpha:1.0];
}

#pragma mark Private

+ (UIColor *)normalizedColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    CGFloat divider = 255.0;
    return [UIColor colorWithRed:red/divider green:green/divider blue:blue/divider alpha:alpha];
}

@end