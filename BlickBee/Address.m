//
//  Address.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "Address.h"

@implementation Address

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.addressId=@"";
        self.name=@"";
        self.phone=@"";
        self.landmark=@"";
        self.street=@"";
        self.city=@"";
        self.state=@"";
        self.country=@"";
        self.postalCode=@"";
        self.defaultAddress=@"";
        self.status=@"";
        self.createdDate=@"";
        self.updatedDate=@"";
    }
    return self;
}


@end

