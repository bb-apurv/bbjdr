//
//  DeliverySlot.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "DeliverySlot.h"

@implementation DeliverySlot

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.deliveryId=@"";
        self.deliveryTime=@"";
        self.deliveryDate=@"";
        self.deliveryDay=@"";
    }
    return self;
}


@end
