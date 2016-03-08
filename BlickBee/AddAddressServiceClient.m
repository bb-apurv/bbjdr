//
//  AddAddressServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AddAddressServiceClient.h"
@implementation AddAddressServiceClient

- (void) getNearestAreasWithSuccess:(void (^) (NSMutableArray* areasArray))success failure:(void (^) (NSError *error)) failure{
    
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"getNearestAreas()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey,
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"] && [[responseObject objectForKey:@"response_data"] isKindOfClass:[NSArray class]]) {
            NSDictionary *orderDict = [[responseObject objectForKey:@"response_data"] objectAtIndex:0];
            NSMutableArray *regionsArray = [self getRegionsArray:[responseObject objectForKey:@"response_data"]];
            if (regionsArray.count>0) {
                [BlickbeeAppManager sharedInstance].regionsArray=regionsArray;
            }
            success(regionsArray);
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

-(NSMutableArray*) getRegionsArray:(NSArray*)areasArray{
    NSMutableArray *regionsArray = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in areasArray) {
        NearByArea *area = [[NearByArea alloc] init];
        area.areaId = [dict objectForKey:@"id"];
        area.region = [dict objectForKey:@"region"];
        area.status = [dict objectForKey:@"status"];
        area.zoneCode = [dict objectForKey:@"zone_code"];
        [regionsArray addObject:area];
    }
    return regionsArray;
}


/*

 
 {
	"request": "setAddress()",
	"user_id": "525",
	"auth_key": "10524ac4b2d2566f07c59410a178580e",
	"name": "Babu",
	"landmark": "1st Pulia", -near by area
	"phone": "1234567890",
	"street": "Yahoo", - address
	"city": "Jodhpur",
	"state": "Rajasthan",
	"postal_code": "342001", -
	"type": "Add"
 }
 response:
 {
	"response": "success",
	"response_data": {
 "id": "628",
 "customer_id": "525",
 "zone_code": "",
 "name": "Babu",
 "phone": "1234567890",
 "landmark": "1st Pulia",
 "street": "Yahoo",
 "city": "Jodhpur",
 "state": "Rajasthan",
 "country": "India",
 "postal_code": "342001",
 "default_address": "1",
 "status": "0",
 "created_date": "2015-11-26 16:33:10",
 "updated_date": "2015-11-26 16:33:10"
	}
 }
 
 */



- (void) setAddressForName:(NSString*)name andNearByArea:(NearByArea*)landmark andPhone:(NSString*)phone andStreet:(NSString*)street andCity:(NSString*)city andState:(NSString*)state andPostalCode:(NSString*)postalCode WithSuccess:(void (^) (Address *newAddress))success failure:(void (^) (NSError *error)) failure{

    
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"setAddress()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey,
                             @"name": name,
                             @"landmark": landmark.region,
                             @"phone": phone,
                             @"street": street,
                             @"city": city,
                             @"state": state,
                             @"postal_code": postalCode,
                             @"type": @"Add"
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"] && [[responseObject objectForKey:@"response_data"] isKindOfClass:[NSDictionary class]]) {
            Address *address = [self getAddressesWith:[responseObject objectForKey:@"response_data"]];
            success(address);
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

-(Address*) getAddressesWith:(NSDictionary*)adddict{
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
    return address;
}

/*
 {"request":"setAddress()", "user_id":"22", "auth_key":"c8b0b46d5318d968fecf11a8146e80c9", "street":"23­34FCC, Basni, Near Ola Office", "city":"Jodhpur", "state":"Rajasthan", "postal_code":"342001","name":"phone","city":"232323", "type":"Edit", }
 */

- (void) editAddressForAddressId:(NSString*)addressId ForName:(NSString*)name andNearByArea:(NearByArea*)landmark andPhone:(NSString*)phone andStreet:(NSString*)street andCity:(NSString*)city andState:(NSString*)state andPostalCode:(NSString*)postalCode WithSuccess:(void (^) (Address *newAddress))success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"setAddress()",
                             @"address_id": addressId,
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey,
                             @"name": name,
                             @"landmark": landmark.region,
                             @"phone": phone,
                             @"street": street,
                             @"city": city,
                             @"state": state,
                             @"postal_code": postalCode,
                             @"type": @"Edit"
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];

    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"] && [[responseObject objectForKey:@"response_data"] isKindOfClass:[NSDictionary class]]) {
            Address *address = [self getAddressesWith:[responseObject objectForKey:@"response_data"]];
            success(address);
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


/*
{"request":"deleteAddress()", "user_id":"22","auth_key":"c8b0b46d5318d968fecf11a8146e80c9", "type":"Delete","address_id":"2"}
 */

- (void) removeAddress:(Address*)address WithSuccess:(void (^) ())success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"deleteAddress()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey,
                             @"address_id": address.addressId,
                             @"type": @"Delete"
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            success();
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
