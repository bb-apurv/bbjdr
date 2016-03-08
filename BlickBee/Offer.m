//
//  Offer.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "Offer.h"

@implementation Offer

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.offerId=@"";
        self.offerName=@"";
        self.offerDesc=@"";
        self.offerType=@"";
        self.offerOn=@"";
        self.offerAppliedOn=@"";
        self.minPurchase=@"";
        self.fromTime=@"";
        self.toTime=@"";
        self.scheme=@"";
        self.value=@"";
        self.offerBanner=@"";
        self.offerStatus=@"";
    }
    return self;
}

@end
