//
//  ProductsServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ProductsServiceClient.h"
#import "Offer.h"
#import "Product.h"
#import "DeliverySlot.h"
#import "BlickbeeAppManager.h"
@implementation ProductsServiceClient


- (void) fetchProdctRepoWithSuccess:(void (^) (ProductRepo* repo))success failure:(void (^) (NSError *error)) failure
{
    //    if (![self isNetWorkAvailable]) {
    //        [self showNoNetworkAlert];
    //        return;
    //    }
    
    
    
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
    NSDictionary *params = @{@"request": @"allCategories()",
                             @"user_id": user.userId,
                             @"auth_key": user.authKey};

    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
       //     NSLog(@"%@", responseObject);
            success([self getRepoFrom:[responseObject objectForKey:@"response_data"]]);

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



- (void) fetchProductRepoForSearchedString:(NSString*)searchStr WithSuccess:(void (^) (NSMutableArray* repo))success failure:(void (^) (NSError *error)) failure
{
    
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
    NSDictionary *params = @{@"request": @"searchProducts()",
                             @"user_id": user.userId,
                             @"auth_key": user.authKey,
                             @"keyword": searchStr};
    
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {        
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            success([self getProductsFrom:[responseObject objectForKey:@"response_data"]]);
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


-(ProductRepo*) getRepoFrom:(NSDictionary*) responsDict{
    ProductRepo *repo = [[ProductRepo alloc] init];
    for (NSMutableDictionary *dict in [responsDict objectForKey:@"offers"]) {
        [repo.offersArray addObject:[self getOfferForDict:dict]];
    }
    for (NSMutableDictionary *dict in [responsDict objectForKey:@"vegetables"]) {
        [repo.vegetablesArray addObject:[self getProductForDict:dict]];
    }
    for (NSMutableDictionary *dict in [responsDict objectForKey:@"fruits"]) {
        [repo.fruitsArray addObject:[self getProductForDict:dict]];
    }
    for (NSMutableDictionary *dict in [responsDict objectForKey:@"delivery_slots"]) {
        [repo.deliverySlotsArray addObject:[self getDeliverySlotForDict:dict]];
    }
    
    //for popup
    repo.popupDict = [responsDict objectForKey:@"popupObject"];
    //NSLog(@"%@",repo.popupDict);

    
    repo.orderAmountLimit=[responsDict objectForKey:@"orderAmountLimit"];
   
    
    if (repo.orderAmountLimit && ![repo.orderAmountLimit isEqualToString:@""]) {
        [[BlickbeeAppManager sharedInstance] setOrderAmountLimit:[repo.orderAmountLimit intValue]];
    }
    
   /*if (repo.popupDescription && ![repo.popupDescription isEqualToString:@""]) {
        [BlickbeeAppManager sharedInstance] setPopupDescription = repo.popupDescription  ;
    }*/
    
    
    return repo;
}

-(NSMutableArray*) getProductsFrom:(NSArray*) responseArray{
    NSMutableArray *repo = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dict in responseArray) {
        [repo addObject:[self getProductForDict:dict]];
    }
    return repo;
}

-(Offer*) getOfferForDict:(NSMutableDictionary*)dict{
    Offer *offer = [[Offer alloc] init];
    offer.offerId = [dict objectForKey:@"offer_id"];
    offer.offerName = [dict objectForKey:@"offer_name"];
    offer.offerDesc = [dict objectForKey:@"description"];
    offer.offerType = [dict objectForKey:@"offer_type"];
    offer.offerOn = [dict objectForKey:@"offer_on"];
    offer.offerAppliedOn = [dict objectForKey:@"offer_applied_on"];
    offer.minPurchase = [dict objectForKey:@"min_purchase"];
    offer.fromTime = [dict objectForKey:@"from_time"];
    offer.toTime = [dict objectForKey:@"to_time"];
    offer.scheme = [dict objectForKey:@"scheme"];
    offer.value = [dict objectForKey:@"value"];
    offer.offerBanner = [dict objectForKey:@"offer_banner"];
    offer.offerStatus = [dict objectForKey:@"offer_status"];
    return offer;
}
-(Product*) getProductForDict:(NSMutableDictionary*)dict{
    Product *product = [[Product alloc] init];
    product.productId = [dict objectForKey:@"id"];
    product.productCatId = [dict objectForKey:@"product_cat_id"];
    product.productName = [dict objectForKey:@"product_name"];
    product.productDesc = [dict objectForKey:@"product_description"];
    product.productKeyword = [dict objectForKey:@"product_keywords"];
    product.status = [dict objectForKey:@"status"];
    product.productCreatedDate = [dict objectForKey:@"product_created_date"];
    product.productUpdatedDate = [dict objectForKey:@"product_updated_date"];
    product.pId = [dict objectForKey:@"p_id"];
    product.productQuantity = [dict objectForKey:@"product_quantity"];
    product.productPrice = [dict objectForKey:@"product_price"];
    product.productBbPrice = [dict objectForKey:@"product_bb_price"];
    product.productUnitQty = [dict objectForKey:@"product_unit_qnt"];
    product.productCap = [dict objectForKey:@"product_cap"];
    product.updatedDate = [dict objectForKey:@"updated_date"];
    for (NSString *imagesStr in [dict objectForKey:@"product_images"]) {
        [product.productImages addObject:imagesStr];
    }
    return product;
}
-(DeliverySlot*) getDeliverySlotForDict:(NSMutableDictionary*)dict{
    DeliverySlot *deliverySlot = [[DeliverySlot alloc] init];
    deliverySlot.deliveryId = [dict objectForKey:@"id"];
    deliverySlot.deliveryTime = [dict objectForKey:@"time"];
    deliverySlot.deliveryDate = [dict objectForKey:@"date"];
    deliverySlot.deliveryDay = [dict objectForKey:@"day"];
    return deliverySlot;
}



@end
