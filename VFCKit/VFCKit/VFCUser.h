//
//  VFCUser.h
//  VFCKit
//

@import Foundation;

#pragma mark - VFCUser

@interface VFCUser : NSObject
+ (VFCUser *)user;
- (NSString *)email;
- (void)setEmail:(NSString *)email;
@end