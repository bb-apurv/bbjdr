//
//  OrderedProduct.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseModel.h"

@interface OrderedProduct : BaseModel

@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong) NSString *productQty;
@property (nonatomic,strong) NSString *productAmount;
@property (nonatomic,strong) NSString *productUnitQty;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *productImage;



/*
"order_product_id": "29",
"product_quantities": "10",
"product_ammount": "66",
"product_unit_quantity": "500gm",
"product_name": "Pomegranate -II \/\u0905\u0928\u093e\u0930",
"product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/aJ5Kp4TyU-ZwxxgOTISP1CamfKULDY6r.png"
*/

@end
