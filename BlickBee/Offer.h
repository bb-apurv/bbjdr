//
//  Offer.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface Offer : BaseModel

@property (nonatomic,strong) NSString *offerId;
@property (nonatomic,strong) NSString *offerName;
@property (nonatomic,strong) NSString *offerDesc;
@property (nonatomic,strong) NSString *offerType;
@property (nonatomic,strong) NSString *offerOn;
@property (nonatomic,strong) NSString *offerAppliedOn;
@property (nonatomic,strong) NSString *minPurchase;
@property (nonatomic,strong) NSString *fromTime;
@property (nonatomic,strong) NSString *toTime;
@property (nonatomic,strong) NSString *scheme;
@property (nonatomic,strong) NSString *value;
@property (nonatomic,strong) NSString *offerBanner;
@property (nonatomic,strong) NSString *offerStatus;


@end
