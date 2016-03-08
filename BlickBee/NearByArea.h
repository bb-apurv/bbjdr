//
//  NearByArea.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseModel.h"

@interface NearByArea : BaseModel

@property (nonatomic,strong) NSString *areaId;
@property (nonatomic,strong) NSString *region;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *zoneCode;

/*
 {
 id = 50;
 region = "1st Pulia";
 status = 0;
 "zone_code" = "BBZN-JDH-5";
 }
 */

@end
