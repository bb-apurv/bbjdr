//
//  CartServiceClient.h
//  BlickBee
//
//  Created by Kunal Chelani on 1/1/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseServiceClient.h"

@interface CartServiceClient : BaseServiceClient

- (void) fetchCartRepoForProductIds:(NSString*)selectedIds WithSuccess:(void (^) (NSMutableArray* repo))success failure:(void (^) (NSError *error)) failure;


@end
