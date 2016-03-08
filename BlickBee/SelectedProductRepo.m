//
//  SelectedProductRepo.m
//  BlickBee
//
//  Created by Kunal Chelani on 12/5/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "SelectedProductRepo.h"

@implementation SelectedProductRepo

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.selectedProdsArray=[[NSMutableArray alloc] init];
    }
    return self;
}

@end
