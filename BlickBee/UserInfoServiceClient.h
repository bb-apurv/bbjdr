//
//  UserInfoServiceClient.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/25/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseServiceClient.h"

@interface UserInfoServiceClient : BaseServiceClient


- (void) updateCustomerInfo:(void (^) ())success failure:(void (^) (NSError *error)) failure;

- (void) checkIfOtpVerified:(void (^) ())success failure:(void (^) (NSError *error)) failure;

@end
