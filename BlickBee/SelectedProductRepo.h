//
//  SelectedProductRepo.h
//  BlickBee
//
//  Created by Kunal Chelani on 12/5/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseModel.h"
#import "NSObject+NSCoding.h"
@interface SelectedProductRepo : BaseModel<NSCoding,NSCopying>

@property (nonatomic,strong) NSMutableArray *selectedProdsArray;


@end
