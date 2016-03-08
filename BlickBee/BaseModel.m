//
//  BaseModel.m
//  demoPolling
//
//  Created by Kunal Chelani on 5/23/15.
//  Copyright (c) 2015 Kunal Chelani. All rights reserved.
//

#import "BaseModel.h"
#import "NSObject+NSCoding.h"
@implementation BaseModel

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [self autoEncodeWithCoder:coder];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        [self autoDecode:coder];
    }
    return self;
}


@end
