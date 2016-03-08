//
//  Product.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.productId=@"";
        self.productName=@"";
        self.productCatId=@"";
        self.productDesc=@"";
        self.productKeyword=@"";
        self.status=@"";
        self.productCreatedDate=@"";
        self.productUpdatedDate=@"";
        self.pId=@"";
        self.productQuantity=@"";
        self.productPrice=@"";
        self.productBbPrice=@"";
        self.productUnitQty=@"";
        self.productCap=@"";
        self.updatedDate=@"";
        self.selectedProductQuantity=@"0";
        self.productImages=[[NSMutableArray alloc] init];
    }
    return self;
}

@end
