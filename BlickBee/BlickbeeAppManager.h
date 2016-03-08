//
//  BlickbeeAppManager.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/16/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"




@interface BlickbeeAppManager : NSObject

+ (BlickbeeAppManager*)sharedInstance;
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) NSMutableArray *selectedProducts;
@property (nonatomic,strong) NSMutableArray *userAddresses;
@property (nonatomic,strong) NSMutableArray *regionsArray;
@property (nonatomic,strong) HomeViewController *homeViewController;
@property (nonatomic,assign) int orderAmountLimit;
@property (nonatomic,assign) NSInteger isOtpVerified;

@property (nonatomic,assign) int discount;
@property (nonatomic,assign) int promoApplied;
@property (nonatomic,assign) NSString* promoCodeId;
@property (nonatomic,assign) NSString* offerType;
@property (nonatomic,assign) int amountCap;



-(void) userLoginSuccessfulWith:(User*)user;
-(void) archiveSelectedProducts;
-(void) archiveUser;
-(void) readUserDataFromArchiver;

-(NSMutableArray*) updateWithNewSearchedArray:(NSMutableArray*) repoArray;

-(void) getSelectedProductsArrayWithUpdatedPricesWithCompletionBlock:(void(^)(bool success, NSMutableArray* selectedProdsArray))completionBlock;

@end
