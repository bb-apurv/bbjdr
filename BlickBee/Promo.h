//
//  Promo.h
//  BlickBee
//
//  Created by Apurv Gupta on 17/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface Promo : BaseModel

@property (nonatomic,strong) NSString *promoId;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *offerType;
@property (nonatomic,strong) NSString *discount;
@property (nonatomic,strong) NSString *offerStatus;
@property (nonatomic,strong) NSString *appliedType;
@property (nonatomic,strong) NSString *amountCap;



@end
