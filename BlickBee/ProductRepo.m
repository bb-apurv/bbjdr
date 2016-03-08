//
//  ProductRepo.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ProductRepo.h"

@implementation ProductRepo

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.offersArray=[[NSMutableArray alloc] init];
        self.fruitsArray=[[NSMutableArray alloc] init];
        self.vegetablesArray=[[NSMutableArray alloc] init];
        self.deliverySlotsArray=[[NSMutableArray alloc] init];
        self.popupDict = [[NSMutableDictionary alloc] init];
        self.orderAmountLimit = @"";
        
    }
    return self;
}

@end
