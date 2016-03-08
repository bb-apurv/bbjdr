//
//  Order.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseModel.h"

@interface Order : BaseModel

@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *customerId;
@property (nonatomic,strong) NSString *zoneCode;
@property (nonatomic,strong) NSString *deliverySlot;
@property (nonatomic,strong) NSString *cartId;
@property (nonatomic,strong) NSString *orderStatus;
@property (nonatomic,strong) NSString *orderProcessingBy;
@property (nonatomic,strong) NSString *bikeNo;
@property (nonatomic,strong) NSString *orderAmount;
@property (nonatomic,strong) NSString *currency;
@property (nonatomic,strong) NSString *paymentMethod;
@property (nonatomic,strong) NSString *paymentStatus;
@property (nonatomic,strong) NSString *billingAddressId;
@property (nonatomic,strong) NSString *payuJson;

@property (nonatomic,strong) NSString *payuItemTransaction;
@property (nonatomic,strong) NSString *payuItemPrice;
@property (nonatomic,strong) NSString *payuItemCurrency;
@property (nonatomic,strong) NSString *shippingAddressId;
@property (nonatomic,strong) NSString *uniqueOrderId;
@property (nonatomic,strong) NSString *orderCreatedDate;
@property (nonatomic,strong) NSString *orderUpdatedDate;
@property (nonatomic,strong) NSMutableArray *orderedProducts;


@end


/*

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


*/