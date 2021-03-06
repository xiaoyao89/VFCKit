//
//  VFCUser.m
//  VFCKit
//

#import "VFCUser.h"
#import "VFCUtilities.h"

#pragma mark - NSUserDefaults

static NSString *VFCUserKeyEmail = @"com.venturafoods.useremail";

@interface NSUserDefaults(VFCUserAdditions)
- (NSString *)email;
- (void)setEmail:(NSString *)email;
@end

@implementation NSUserDefaults (VFCUserAdditions)

- (NSString *)email {
    return [self objectForKey:VFCUserKeyEmail];
}

- (void)setEmail:(NSString *)email {
    [self setObject:email forKey:VFCUserKeyEmail];
    [self synchronize];
}

@end

#pragma mark - VFCUser

@implementation VFCUser

#pragma mark Class Methods

+ (VFCUser *)user {
    static VFCUser *_user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[self alloc] init];
    });
    return _user;
}

#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark Public

- (NSString *)email {
    return [[NSUserDefaults standardUserDefaults] email];
}

- (void)setEmail:(NSString *)email {
    [[NSUserDefaults standardUserDefaults] setEmail:email];
    VFCLog(@"Updating user email to <%@>", [[NSUserDefaults standardUserDefaults] email]);
}

@end
