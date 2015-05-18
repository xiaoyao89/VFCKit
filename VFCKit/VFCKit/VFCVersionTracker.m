//
//  VFCVersionTracker.m
//  VFCKit
//

#import "VFCVersionTracker.h"

#pragma mark - NSUserDefaults

#pragma mark - Private Interface

static NSString *const NSUserDefaultsKeyVersions = @"com.venturafoods.versions";

@interface NSUserDefaults (VFCVersionTrackerAdditions)
- (NSSet *)versions;
- (void)setVersions:(NSSet *)versions;
- (void)addVersion:(NSString *)version build:(NSString *)build;
@end

#pragma mark - Private Implementation

@implementation NSUserDefaults (VFCVersionTrackerAdditions)

- (NSSet *)versions {
    NSData *data = [self objectForKey:NSUserDefaultsKeyVersions];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)setVersions:(NSSet *)versions {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:versions];
    [self setObject:data forKey:NSUserDefaultsKeyVersions];
    [self synchronize];
}

- (void)addVersion:(NSString *)version build:(NSString *)build {
    NSMutableSet *set = [[self versions] mutableCopy];
    if (!set) {
        set = [NSMutableSet set];
    }
}

@end

#pragma mark - VFCVersionTracker

#pragma mark - Public Implementation

@implementation VFCVersionTracker

@end
