//
//  User.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/15/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseModel.h"
#import "NSObject+NSCoding.h"
@interface User : BaseModel <NSCoding,NSCopying>

@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *deviceId;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *authKey;
@property(nonatomic,strong) NSString *passHash;
@property(nonatomic,strong) NSString *email;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *cartId;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *avatarMineType;
@property(nonatomic,strong) NSString *myWallet;
@property(nonatomic,strong) NSString *accessToken;
@property(nonatomic,strong) NSString *otpRequest;
@property(nonatomic,strong) NSString *otpStatus;

@end
