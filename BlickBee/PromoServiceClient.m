//
//  PromoServiceClient.m
//  BlickBee
//
//  Created by Apurv Gupta on 17/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "PromoServiceClient.h"
#import "Promo.h"

@implementation PromoServiceClient

- (void) verifyPromoCode:(NSString*)codeStr WithSuccess:(void (^) (Promo* promo))success failure:(void (^) (NSError *error)) failure
{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"verifyPromoCode()",
                             @"customer_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"promoCode": codeStr
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"] && [[responseObject objectForKey:@"response_data"] isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@",responseObject);

            success([self getPromoFromRespons:[responseObject objectForKey:@"response_data"]]);
        }
        else if ([[responseObject objectForKey:@"response"] isEqualToString:@"failed"]){
            [self showAlertWithErrorMsg:[responseObject objectForKey:@"message"]];
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

-(Promo*) getPromoFromRespons:(NSDictionary*)responseDict{
    Promo *promo = [[Promo alloc] init];
    promo.promoId = [responseDict objectForKey:@"promoId"];
    [[BlickbeeAppManager sharedInstance] setPromoCodeId:promo.promoId ];
    promo.code = [responseDict objectForKey:@"code"];
    promo.offerType = [responseDict objectForKey:@"offerType"];
    promo.discount = [responseDict objectForKey:@"discount"];
    if (promo.discount && ![promo.discount isEqualToString:@""]) {
        [[BlickbeeAppManager sharedInstance] setDiscount:[promo.discount intValue]];}
    promo.amountCap = [responseDict objectForKey:@"amountCap"];
    [[BlickbeeAppManager sharedInstance] setAmountCap:[promo.amountCap intValue]];

    promo.offerStatus = [responseDict objectForKey:@"offerStatus"];
    promo.appliedType = [responseDict objectForKey:@"appliedType"];
    return promo;
}



@end


