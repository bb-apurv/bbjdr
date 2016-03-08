//
//  NearByArea.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "NearByArea.h"

@implementation NearByArea

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.areaId=@"";
        self.region=@"";
        self.status=@"";
        self.zoneCode=@"";
    }
    return self;
}

@end
