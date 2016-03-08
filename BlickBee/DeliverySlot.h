//
//  DeliverySlot.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface DeliverySlot : BaseModel

@property (nonatomic,strong) NSString *deliveryId;
@property (nonatomic,strong) NSString *deliveryTime;
@property (nonatomic,strong) NSString *deliveryDate;
@property (nonatomic,strong) NSString *deliveryDay;

@end
