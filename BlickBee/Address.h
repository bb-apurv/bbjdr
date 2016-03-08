//
//  Address.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseModel.h"

@interface Address : BaseModel
@property (nonatomic,strong) NSString *addressId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *landmark;
@property (nonatomic,strong) NSString *street;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *postalCode;
@property (nonatomic,strong) NSString *defaultAddress;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *createdDate;
@property (nonatomic,strong) NSString *updatedDate;

@end




/*

 req:
 {
	"request": "setAddress()",
	"user_id": "525",
	"auth_key": "fba047db2b87b402eb0d154e6cc6e0a0",
	"name": "Babq",
	"landmark": "Adarsh Society",
	"phone": "1234567890",
	"street": "Yahoo",
	"city": "Jodhpur",
	"state": "Rajasthan",
	"postal_code": "342001",
	"type": "Add"
 }
 response:
 {
	"response": "success",
	"response_data": {
 "id": "569",
 "customer_id": "525",
 "name": "Babq",
 "phone": "1234567890",
 "landmark": "Adarsh Society",
 "street": "Yahoo",
 "city": "Jodhpur",
 "state": "Rajasthan",
 "country": "India",
 "postal_code": "342001",
 "default_address": "1",
 "status": "0",
 "created_date": "2015-11-20 15:47:02",
 "updated_date": "2015-11-20 15:47:02"
	}
 }


*/