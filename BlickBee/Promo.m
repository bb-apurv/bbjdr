//
//  Promo.m
//  BlickBee
//
//  Created by Apurv Gupta on 17/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "Promo.h"

@implementation Promo

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.promoId=@"";
        self.code=@"";
        self.offerType=@"";
        self.discount=@"";
        self.offerStatus=@"";
        self.appliedType=@"";
        self.amountCap=@"";
        
    }
    return self;
}



@end
 
