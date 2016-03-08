//
//  Product.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface Product : BaseModel

@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *productCatId;//1-veg, 2-fruits
@property (nonatomic,strong) NSString *productDesc;
@property (nonatomic,strong) NSString *productKeyword;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *productCreatedDate;
@property (nonatomic,strong) NSString *productUpdatedDate;
@property (nonatomic,strong) NSString *pId;
@property (nonatomic,strong) NSString *productQuantity;
@property (nonatomic,strong) NSString *productPrice;
@property (nonatomic,strong) NSString *productBbPrice;
@property (nonatomic,strong) NSString *productUnitQty;
@property (nonatomic,strong) NSString *productCap;
@property (nonatomic,strong) NSString *updatedDate;
@property (nonatomic,strong) NSMutableArray *productImages;
@property (nonatomic,strong) NSString *selectedProductQuantity;

@end
