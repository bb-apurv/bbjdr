//
//  AddAddressServiceClient.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseServiceClient.h"
#import "Address.h"
#import "NearByArea.h"

@interface AddAddressServiceClient : BaseServiceClient

- (void) getNearestAreasWithSuccess:(void (^) (NSMutableArray* areasArray))success failure:(void (^) (NSError *error)) failure;


- (void) setAddressForName:(NSString*)name andNearByArea:(NearByArea*)landmark andPhone:(NSString*)phone andStreet:(NSString*)street andCity:(NSString*)city andState:(NSString*)state andPostalCode:(NSString*)postalCode WithSuccess:(void (^) (Address *newAddress))success failure:(void (^) (NSError *error)) failure;

- (void) removeAddress:(Address*)address WithSuccess:(void (^) ())success failure:(void (^) (NSError *error)) failure;

- (void) editAddressForAddressId:(NSString*)addressId ForName:(NSString*)name andNearByArea:(NearByArea*)landmark andPhone:(NSString*)phone andStreet:(NSString*)street andCity:(NSString*)city andState:(NSString*)state andPostalCode:(NSString*)postalCode WithSuccess:(void (^) (Address *newAddress))success failure:(void (^) (NSError *error)) failure;


@end
