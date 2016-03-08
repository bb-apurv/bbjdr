//
//  OrderedProduct.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "OrderedProduct.h"

@implementation OrderedProduct


-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.productId=@"";
        self.productQty=@"";
        self.productAmount=@"";
        self.productUnitQty=@"";
        self.productName=@"";
        self.productImage=@"";
    }
    return self;
}

@end
