//
//  ReferalServiceClient.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 1/19/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "ReferalServiceClient.h"
#import "BaseServiceClient.h"

@implementation ReferalServiceClient

-(void) validateCodeWithDeviceId : (NSString *)deviceId :(NSString *)referralCode withSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    User *user = [BlickbeeAppManager sharedInstance].user;
    if (!user || [user.userId isEqualToString:@""]) {
        failure(nil);
        return;
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"referralSystem()",
                             @"code": @"BB3nA5",
                             @"type": @"codeValidation",
                             @"device_id": deviceId};
    
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
           // fetch the response repo here.
        }
        else if ([responseObject objectForKey:@"error"]){
            [self showAlertWithErrorMsg:[responseObject objectForKey:@"error"]];
            failure(nil);
        }
        else{
            failure(nil);
        }
        
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (error.code==-1009) {
            [self showNoNetworkAlert];
            return;
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Error in retrieving information."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        failure(error);
        [SVProgressHUD dismiss];
    }];

}

-(void) validationDoneWithDeviceId : (NSString *)deviceId :(NSString *)referralCode withSuccess:(void(^)(User* user))success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    User *user = [BlickbeeAppManager sharedInstance].user;
    if (!user || [user.userId isEqualToString:@""]) {
        failure(nil);
        return;
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"referralSystem()",
                             @"code": @"BB3UA5",
                             @"type": @"validationDone",
                             @"device_id": deviceId,
                             @"user_Id": user.userId};
    
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            // success([self getRepoFrom:[responseObject objectForKey:@"response_data"]]);
        }
        else if ([responseObject objectForKey:@"error"]){
            [self showAlertWithErrorMsg:[responseObject objectForKey:@"error"]];
            failure(nil);
        }
        else{
            failure(nil);
        }
        
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (error.code==-1009) {
            [self showNoNetworkAlert];
            return;
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Error in retrieving information."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        failure(error);
        [SVProgressHUD dismiss];
    }];
}

@end
