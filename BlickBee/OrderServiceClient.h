//
//  OrderServiceClient.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseServiceClient.h"
#import "User.h"
#import "Product.h"
#import "Address.h"
#import "Order.h"

@interface OrderServiceClient : BaseServiceClient

- (void) makeOrderWithProductArray:(NSMutableArray*)productsArray andAddress:(Address*)address WithSuccess:(void (^) (Order* order))success failure:(void (^) (NSError *error)) failure;

- (void) getAllOrdersWithSuccess:(void (^) (NSMutableArray* orderaArray))success failure:(void (^) (NSError *error)) failure;

    



@end
