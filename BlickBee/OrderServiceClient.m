//
//  OrderServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "OrderServiceClient.h"
#import "BlickbeeAppManager.h"
#import "OrderedProduct.h"
@implementation OrderServiceClient

- (void) makeOrderWithProductArray:(NSMutableArray*)productsArray andAddress:(Address*)address WithSuccess:(void (^) (Order* order))success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /*
     eq:
     {
     "request": "makeOrder()",
     "user_id": "525",
     "auth_key": "fba047db2b87b402eb0d154e6cc6e0a0",
     "cart_id": "BBCID_1446274757",
     "product_ids": "29,45",
     "product_qnts": "10,2",
     "product_amt": "66,24",
     "billing_id": "340",
     "shipping_id": "340",
     "product_unit_qnt": "500gm,500gm",
     "total_amount": "708.0"
     }
     */
    NSString *productId=@"";
    NSString *productQty=@"";
    NSString *productAmt=@"";
    NSString *productUnitQty=@"";
    double totalAmt=0.0f;
    for (Product *product in productsArray) {
        productId=[NSString stringWithFormat:@"%@,%@",productId,product.productId];
        productQty=[NSString stringWithFormat:@"%@,%@",productQty,product.selectedProductQuantity];
        productAmt=[NSString stringWithFormat:@"%@,%@",productAmt,product.productBbPrice];
        productUnitQty=[NSString stringWithFormat:@"%@,%@",productUnitQty,product.productUnitQty];
        totalAmt += [product.selectedProductQuantity doubleValue]*[product.productBbPrice doubleValue];
    }
    
    productId = [productId substringFromIndex:1];
    productQty = [productQty substringFromIndex:1];
    productAmt = [productAmt substringFromIndex:1];
    productUnitQty = [productUnitQty substringFromIndex:1];
    
    NSDictionary *params = @{@"request": @"makeOrder()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey,
                             @"cart_id": [BlickbeeAppManager sharedInstance].user.cartId,
                             @"promoCodeId": [BlickbeeAppManager sharedInstance].promoCodeId,
                             @"product_ids": productId,
                             @"product_qnts": productQty,
                             @"product_amt": productAmt,
                             @"billing_id": address.addressId,
                             @"shipping_id": address.addressId,
                             @"product_unit_qnt": productUnitQty,
                             @"total_amount": [NSString stringWithFormat:@"%0.2f",totalAmt]};
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"] && [[responseObject objectForKey:@"response_data"] isKindOfClass:[NSArray class]]) {
            NSDictionary *orderDict = [[responseObject objectForKey:@"response_data"] objectAtIndex:0];
            success([self getOrderFor:orderDict]);
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

-(Order*) getOrderFor:(NSDictionary*)dict{
    Order *order = [[Order alloc] init];
    order.orderId = [dict objectForKey:@"id"];
    order.customerId = [dict objectForKey:@"customer_id"];
    order.deliverySlot = [dict objectForKey:@"delivery_slot"];
    order.cartId = [dict objectForKey:@"cart_id"];
    order.orderStatus = [dict objectForKey:@"order_status"];
    order.orderProcessingBy = [dict objectForKey:@"order_processing_by"];
    order.bikeNo = [dict objectForKey:@"bike_no"];
    order.orderAmount = [dict objectForKey:@"order_ammount"];
    order.currency = [dict objectForKey:@"currency"];
    order.paymentMethod = [dict objectForKey:@"payment_method"];
    order.paymentStatus = [dict objectForKey:@"payment_status"];
    order.billingAddressId = [dict objectForKey:@"billing_address_id"];
    order.payuJson = [dict objectForKey:@"payu_json"];
    order.payuItemTransaction = [dict objectForKey:@"payu_item_transaction"];
    order.payuItemPrice = [dict objectForKey:@"payu_item_price"];
    order.payuItemCurrency = [dict objectForKey:@"payu_item_currency"];
    order.shippingAddressId = [dict objectForKey:@"shipping_address_id"];
    order.uniqueOrderId = [dict objectForKey:@"unique_order_id"];
    order.orderCreatedDate = [dict objectForKey:@"order_created_date"];
    order.orderUpdatedDate = [dict objectForKey:@"order_updated_date"];
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for (NSDictionary* prodDict in [dict objectForKey:@"products"]) {
        OrderedProduct *product = [[OrderedProduct alloc] init];
        product.productId = [prodDict objectForKey:@"order_product_id"];
        product.productQty = [prodDict objectForKey:@"product_quantities"];
        product.productAmount = [prodDict objectForKey:@"product_ammount"];
        product.productUnitQty = [prodDict objectForKey:@"product_unit_quantity"];
        product.productName = [prodDict objectForKey:@"product_name"];
        product.productImage = [prodDict objectForKey:@"product_image"];
        [products addObject:product];
    }
    order.orderedProducts=products;
    return order;
}


/*
 
 response:
 {
	"response": "success",
	"response_data": [{
 "id": "646",
 "customer_id": "525",
 "delivery_slot": "",
 "cart_id": "BBCID_1446274757",
 "order_status": "Pending",
 "order_processing_by": "",
 "bike_no": "0",
 "order_ammount": "708.0",
 "currency": "INR",
 "payment_method": "COD",
 "payment_status": "",
 "billing_address_id": "340",
 "payu_json": "",
 "payu_item_transaction": "",
 "payu_item_price": "",
 "payu_item_currency": "",
 "shipping_address_id": "340",
 "unique_order_id": "BB1219OID652",
 "order_created_date": "2015-11-20 15:48:52",
 "order_updated_date": "2015-11-20 15:48:52",
 "products": [{
 "order_product_id": "29",
 "product_quantities": "10",
 "product_ammount": "66",
 "product_unit_quantity": "500gm",
 "product_name": "Pomegranate -II \/\u0905\u0928\u093e\u0930",
 "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/aJ5Kp4TyU-ZwxxgOTISP1CamfKULDY6r.png"
 }, {
 "order_product_id": "45",
 "product_quantities": "2",
 "product_ammount": "24",
 "product_unit_quantity": "500gm",
 "product_name": "Tomato \/ \u091f\u092e\u093e\u091f\u0930",
 "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/BH9RoA9TT-c9X8Q5XSxebcFsZFSMYNdX.png"
 }]
	}]
 }
 

 
 */


- (void) getAllOrdersWithSuccess:(void (^) (NSMutableArray* orderaArray))success failure:(void (^) (NSError *error)) failure{

    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /*
     req:
     {
     "request": "allOrders()",
     "user_id": "622",
     "auth_key": "35de69962f14aa77dc8c405328ff4a71",
     "cart_id": "BBCID_1446533999"
     }
     */
    
    NSDictionary *params = @{@"request": @"allOrders()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey,
                             @"cart_id": [BlickbeeAppManager sharedInstance].user.cartId
                             };
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"] && [[responseObject objectForKey:@"response_data"] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@",responseObject);
            success([self getFullOrderFor:[responseObject objectForKey:@"response_data"]]);
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
-(NSMutableArray*) getFullOrderFor:(NSArray*)responseArray{
    NSMutableArray *ordersArray= [[NSMutableArray alloc] init];
    for (NSDictionary *dict in responseArray) {
        Order *order = [[Order alloc] init];
        order.orderId = [dict objectForKey:@"id"];
        order.customerId = [dict objectForKey:@"customer_id"];
        order.zoneCode = [dict objectForKey:@"zone_code"];
        
        order.cartId = [dict objectForKey:@"cart_id"];
        order.orderStatus = [dict objectForKey:@"order_status"];
        order.orderProcessingBy = [dict objectForKey:@"order_processing_by"];
        order.bikeNo = [dict objectForKey:@"bike_no"];
        order.orderAmount = [dict objectForKey:@"order_ammount"];
        order.currency = [dict objectForKey:@"currency"];
        order.paymentMethod = [dict objectForKey:@"payment_method"];
        order.paymentStatus = [dict objectForKey:@"payment_status"];
        order.billingAddressId = [dict objectForKey:@"billing_address_id"];
        order.payuJson = [dict objectForKey:@"payu_json"];
        order.payuItemTransaction = [dict objectForKey:@"payu_item_transaction"];
        order.payuItemPrice = [dict objectForKey:@"payu_item_price"];
        order.payuItemCurrency = [dict objectForKey:@"payu_item_currency"];
        order.shippingAddressId = [dict objectForKey:@"shipping_address_id"];
        order.uniqueOrderId = [dict objectForKey:@"unique_order_id"];
        order.orderCreatedDate = [dict objectForKey:@"order_created_date"];
        order.orderUpdatedDate = [dict objectForKey:@"order_updated_date"];
        NSMutableArray *products = [[NSMutableArray alloc] init];
        for (NSDictionary* prodDict in [dict objectForKey:@"products"]) {
            OrderedProduct *product = [[OrderedProduct alloc] init];
            product.productId = [prodDict objectForKey:@"order_product_id"];
            product.productQty = [prodDict objectForKey:@"product_quantities"];
            product.productAmount = [prodDict objectForKey:@"product_ammount"];
            product.productUnitQty = [prodDict objectForKey:@"product_unit_quantity"];
            product.productName = [prodDict objectForKey:@"product_name"];
            product.productImage = [prodDict objectForKey:@"product_image"];
            [products addObject:product];
        }
        order.orderedProducts=products;
        [ordersArray addObject:order];
    }
    return ordersArray;
}



/*
{
    "response": "success",
    "response_data": [{
        "id": "697",
        "customer_id": "622",
        "zone_code": "",
        "cart_id": "BBCID_1446533999",
        "order_status": "3",
        "order_processing_by": "",
        "bike_no": "0",
        "order_ammount": "404.0",
        "currency": "INR",
        "payment_method": "COD",
        "payment_status": "",
        "billing_address_id": "377",
        "payu_json": "",
        "payu_item_transaction": "",
        "payu_item_price": "",
        "payu_item_currency": "",
        "shipping_address_id": "377",
        "unique_order_id": "BB5538OID115",
        "order_created_date": "2015-11-23 17:53:07",
        "order_updated_date": "2015-11-23 17:53:07",
        "products": [{
            "order_product_id": "27",
            "product_quantities": "1",
            "product_ammount": "55",
            "product_unit_quantity": "500gm",
            "product_name": "Apple - I \/ \u0938\u0947\u092c",
            "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/xMLqnmuQYk9ss1p2f1DBmbDOeZ8Uoa28.png"
        }, {
            "order_product_id": "28",
            "product_quantities": "1",
            "product_ammount": "42",
            "product_unit_quantity": "500gm",
            "product_name": "Apple - II \/ \u0938\u0947\u092c",
            "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/DKcTppOED_ECoHM1faPUazX1k0m7r4J2.png"
        }, {
            "order_product_id": "29",
            "product_quantities": "1",
            "product_ammount": "67",
            "product_unit_quantity": "500gm",
            "product_name": "Pomegranate -II \/\u0905\u0928\u093e\u0930",
            "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/aJ5Kp4TyU-ZwxxgOTISP1CamfKULDY6r.png"
        }, {
            "order_product_id": "30",
            "product_quantities": "3",
            "product_ammount": "80",
            "product_unit_quantity": "500gm",
            "product_name": "Pomegranate -I \/\u0905\u0928\u093e\u0930",
            "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/ohldqqfX0TagVWmIXJ5vfKAcoV-6rdzA.png"
        }]
    }]
}
*/


@end
