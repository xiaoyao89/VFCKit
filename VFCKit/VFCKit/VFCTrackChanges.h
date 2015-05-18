//
//  VFCTrackChanges.h
//  VFCKit
//

@import Foundation;
#import "AFNetworking.h"

#pragma mark - VFCTrackChanges

#pragma mark - Public Interface

@interface VFCTrackChanges : NSObject
+ (void)submitTracking:(NSInteger)appID URLString:(NSString *)urlString dictionary:(NSDictionary *)dict;
@end
