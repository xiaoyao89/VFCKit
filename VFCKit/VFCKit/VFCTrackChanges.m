//
//  VFCTrackChanges.m
//  VFCKit
//

#import "VFCTrackChanges.h"
#import "VFCUtilities.h"

#pragma mark - VFCTrackChanges

#pragma mark - Public Implementation

@implementation VFCTrackChanges

+ (void)submitTracking:(NSInteger)appID URLString:(NSString *)urlString dictionary:(NSDictionary *)dict {
    VFCLog(@"Submit tracking for app with ID <%li> at <%@>", (long)appID, urlString);
    if (urlString && dict) {
        VFCLog(@"Submitting iPad Tracking info: %@", dict);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [manager GET:urlString
          parameters:dict
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 VFCLog(@"JSON: %@", responseObject);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 VFCLog(@"ERROR - JSON <%@>", [error localizedDescription]);
             }];
    }
}

@end