//
//  User.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/15/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.userId=@"";
        self.deviceId=@"";
        self.userName=@"";
        self.name=@"";
        self.authKey=@"";
        self.passHash=@"";
        self.email=@"";
        self.phone=@"";
        self.cartId=@"";
        self.avatar=@"";
        self.avatarMineType=@"";
        self.myWallet=@"";
        self.accessToken=@"";
        self.otpRequest=@"";
        self.otpStatus=@"";

        
    }
    return self;
}



@end
