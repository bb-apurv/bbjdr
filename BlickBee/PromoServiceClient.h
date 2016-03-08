//
//  PromoServiceClient.h
//  BlickBee
//
//  Created by Apurv Gupta on 17/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseServiceClient.h"
#import "Promo.h"

@interface PromoServiceClient : BaseServiceClient

- (void) verifyPromoCode:(NSString*)codeStr WithSuccess:(void (^) (Promo* promo))success failure:(void (^) (NSError *error)) failure;

@end
