//
//  ProductRepo.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseModel.h"

@interface ProductRepo : BaseModel

@property (nonatomic,strong) NSMutableArray *offersArray;
@property (nonatomic,strong) NSMutableArray *fruitsArray;
@property (nonatomic,strong) NSMutableArray *vegetablesArray;
@property (nonatomic,strong) NSMutableArray *deliverySlotsArray;
@property (nonatomic,strong) NSMutableDictionary *popupDict;

@property (nonatomic,strong) NSString *orderAmountLimit;

@end
