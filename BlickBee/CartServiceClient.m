//
//  CartServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 1/1/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "CartServiceClient.h"
#import "Product.h"
@implementation CartServiceClient

- (void) fetchCartRepoForProductIds:(NSString*)selectedIds WithSuccess:(void (^) (NSMutableArray* repo))success failure:(void (^) (NSError *error)) failure
{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    User *user = [BlickbeeAppManager sharedInstance].user;
    if (!user || [user.userId isEqualToString:@""]) {
        failure(nil);
        return;
    }
    NSLog(@"%@ id user", user.userId);
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *params = @{@"request": @"getProductsUpdatedDetails()",
                             @"user_id": user.userId,
                             @"auth_key": user.authKey,
                             @"product_ids": selectedIds};
    
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


-(NSMutableArray*) getProductsFrom:(NSArray*) responseArray{
    NSMutableArray *repo = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dict in responseArray) {
        [repo addObject:[self getProductForDict:dict]];
    }
    return repo;
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

@end
