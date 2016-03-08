//
//  UserInfoServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/25/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "UserInfoServiceClient.h"
#import "Address.h"
@implementation UserInfoServiceClient


- (void) updateCustomerInfo:(void (^) ())success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /*
     req:
     {
     "request": "getCustomerInfo()",
     "user_id": "1245",
     "auth_key": "3e6ccc5990f77d095eb71e55e23b0c4a"
     }
     */
    
    NSDictionary *params = @{@"request": @"getCustomerInfo()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            
            if ([[responseObject objectForKey:@"response_data"] isKindOfClass:[NSDictionary class]]) {
                [self updateAddressesWith:[[responseObject objectForKey:@"response_data"] objectForKey:@"addresses"]];
              //  [self checkIfOtpVerified:[[responseObject objectForKey:@"response_data"] objectForKey:@"otp_status"]];
                
            }
            else
                failure(nil);
            
        }
        else if ([responseObject objectForKey:@"error"]){
            [self showAlertWithErrorMsg:[responseObject objectForKey:@"error"]];
            failure(nil);
        }
        else{
            failure(nil);
        }        [SVProgressHUD dismiss];
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


- (void) checkIfOtpVerified:(void (^) ())success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /*
     req:
     {
     "request": "getCustomerInfo()",
     "user_id": "1245",
     "auth_key": "3e6ccc5990f77d095eb71e55e23b0c4a"
     }
     */
    
    NSDictionary *params = @{@"request": @"getCustomerInfo()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            
            if ([[responseObject objectForKey:@"response_data"] isKindOfClass:[NSDictionary class]]) {
               // [self updateAddressesWith:[[responseObject objectForKey:@"response_data"] objectForKey:@"addresses"]];
                [self isOtpVerified:[[responseObject objectForKey:@"response_data"] objectForKey:@"otp_status"]];
                
            }
            else
                failure(nil);
            
        }
        else if ([responseObject objectForKey:@"error"]){
            [self showAlertWithErrorMsg:[responseObject objectForKey:@"error"]];
            failure(nil);
        }
        else{
            failure(nil);
        }        [SVProgressHUD dismiss];
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


-(void) updateAddressesWith:(NSArray*)addressArray{
    
    NSMutableArray *addArray = [[NSMutableArray alloc] init];
    for (NSDictionary* adddict in addressArray) {
        Address *address = [[Address alloc] init];
        address.addressId = [adddict objectForKey:@"id"];
        address.name = [adddict objectForKey:@"name"];
        address.phone = [adddict objectForKey:@"phone"];
        address.landmark = [adddict objectForKey:@"landmark"];
        address.street = [adddict objectForKey:@"street"];
        address.city = [adddict objectForKey:@"city"];
        address.state = [adddict objectForKey:@"state"];
        address.country = [adddict objectForKey:@"country"];
        address.postalCode = [adddict objectForKey:@"postal_code"];
        address.defaultAddress = [adddict objectForKey:@"default_address"];
        address.status = [adddict objectForKey:@"status"];
        address.createdDate = [adddict objectForKey:@"created_date"];
        address.updatedDate = [adddict objectForKey:@"updated_date"];
        [addArray addObject:address];
    }
    if (addArray.count>0) {
        [BlickbeeAppManager sharedInstance].userAddresses = addArray;
    }
}
-(void) isOtpVerified:(NSString*)isOtpVerified{
    NSLog(@"%@ in userinfo", isOtpVerified);
    [BlickbeeAppManager sharedInstance].isOtpVerified = [isOtpVerified integerValue];

}


/*
 
 {
	"response": "success",
	"response_data": {
 "id": "622",
 "device_id": "352706060910433",
 "username": "",
 "name": "Sanchit kumar singh",
 "auth_key": "65a8eba0111b243bf0951bfc05b5e238",
 "password_hash": "$2a$10$C8EaxB648fBR8Atu8nxlV.2e9RdWBloUU.ZKj64wXlnpbeK6Aii7S",
 "password_reset_token": null,
 "email": "sanchitkumarsingh@gmail.com",
 "phone": "8386068785",
 "cart_id": "BBCID_1446533999",
 "avatar": "",
 "avatar_mine_type": "",
 "status": "10",
 "otp": "843140",
 "otp_status": "1",
 "myWallet": "0",
 "access_token": "APA91bFIMxQNOTtcEbTDh0vSecL2Bf0tkLtN0d7kT3PvkGi9E55J5giYzHsF_4vl7fsWcz1YPQDrvZ12NpW_KOR_a5a1oT-Un84YVWmB6O1oL7hGsiwa8BA",
 "created_at": "2015-11-03 12:30:00",
 "updated_at": "2015-11-03 12:30:00",
 "addresses": [{
 "id": "377",
 "customer_id": "622",
 "zone_code": "0",
 "name": "2",
 "phone": "8386068784",
 "landmark": "1st Pulia",
 "street": "t",
 "city": "Jodhpur",
 "state": "Rajasthan",
 "country": "India",
 "postal_code": "342001",
 "default_address": "1",
 "status": "0",
 "created_date": "2015-11-03 12:42:16",
 "updated_date": "2015-11-03 12:42:16"
 }]
	}
 }
 */


@end
