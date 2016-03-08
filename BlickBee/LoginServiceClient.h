//
//  LoginServiceClient.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/15/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseServiceClient.h"
#import "User.h"
@interface LoginServiceClient : BaseServiceClient

- (void) signInWithDictionary:(NSMutableDictionary*)inputDict WithSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure;
- (void) signUpWithDictionary:(NSMutableDictionary*)inputDict WithSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure;
- (void) verifyOTPWithOTP:(NSString*)otpStr WithSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure;
- (void) resendOTPWithSuccess:(void (^) ())success failure:(void (^) (NSError *error)) failure;
- (void) changePasswordWithNewPassword:(NSString*)newPassword withSuccess:(void (^) ())success failure:(void (^) (NSError *error)) failure;
- (void) resendOTPWithPhone:(NSString*)phone andSuccess:(void (^) (NSString* otp))success failure:(void (^) (NSError *error)) failure;
- (void) verifyOTPWithOTP:(NSString*)otpStr ForPhone:(NSString*)phone WithSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure;
- (void) changePasswordWithNewPassword:(NSString*)newPassword andPhone:(NSString*)phone withSuccess:(void (^) ())success failure:(void (^) (NSError *error)) failure;
- (void) changeNameWithNew:(NSString*)newName withSuccess:(void (^) ())success failure:(void (^) (NSError *error)) failure;

@end
