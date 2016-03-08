//
//  BlickbeeAppManager.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/16/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BlickbeeAppManager.h"
#import "Archiver.h"
#import "SelectedProductRepo.h"
#import "Product.h"
#import "CartServiceClient.h"
@implementation BlickbeeAppManager



+ (BlickbeeAppManager*)sharedInstance {
    static BlickbeeAppManager *_sharedInstance;
    if(!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[super allocWithZone:nil] init];
            // Init the dictionary
        });
    }
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

-(id)init
{
    self = [super init];
    self.user = [[User alloc] init];
//    self.selectedProducts = [[NSMutableArray alloc]init];
    self.userAddresses = [[NSMutableArray alloc] init];
    self.regionsArray = [[NSMutableArray alloc] init];
    self.orderAmountLimit = 250;
    self.discount = 0;
    self.promoApplied = 0;
    self.offerType = @"2";// becoz 0-> by percent adn 1-> by value
    self.promoCodeId = @"0";
    self.amountCap = 0;
    self.isOtpVerified = 0;
    
   // self.popupDescription = @"Get";
    [self readSelectedProdsDataFromArchiver];
    return self;
    
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#if (!__has_feature(objc_arc))

- (id)retain {
    
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  //denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}



- (id)autorelease {
    return self;
}
#endif

//
-(void) setSelectedProducts:(NSMutableArray *)selectedProducts{
    _selectedProducts=selectedProducts;
    [self archiveSelectedProducts];
}

-(void) archiveSelectedProducts{
    SelectedProductRepo *selectedProductRepo = [[SelectedProductRepo alloc] init];
    selectedProductRepo.selectedProdsArray=_selectedProducts;
    BOOL fileSaved = [Archiver persist:selectedProductRepo key:@"SelectedProductRepo"];
    if (fileSaved) {
        NSLog(@"SelectedProductRepo saved");
    }
    else{
        NSLog(@"SelectedProductRepo not saved");
    }
}

-(void) readSelectedProdsDataFromArchiver
{
    SelectedProductRepo *productRepo = [Archiver retrieve:@"SelectedProductRepo"];
    _selectedProducts=productRepo.selectedProdsArray;
    if (!_selectedProducts) {
        _selectedProducts = [[NSMutableArray alloc] init];
    }
}

-(void) userLoginSuccessfulWith:(User*)user{
    self.user=user;
    [self archiveUser];
}



-(void) archiveUser{
    BOOL fileSaved = [Archiver persist:self.user key:@"LoggedInUser"];
    if (fileSaved) {
        NSLog(@"LoggedInUser saved");
    }
    else{
        NSLog(@"LoggedInUser not saved");
    }
}

-(void) readUserDataFromArchiver
{
    User *user = [Archiver retrieve:@"LoggedInUser"];
    if (user) {
        self.user=user;
    }
}

-(NSMutableArray*) updateWithNewSearchedArray:(NSMutableArray*) repoArray{
    // to update the proce of the selected array and the incoming products array as well for the selected qty
    
    NSArray *repoCopy = [NSArray arrayWithArray:repoArray];
    for (int i=0; i<repoCopy.count; i++) {
        Product *product = [repoCopy objectAtIndex:i];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productId = %@",product.productId];
        NSArray *foundArray = [[BlickbeeAppManager sharedInstance].selectedProducts filteredArrayUsingPredicate:predicate];
        
        if (foundArray && [foundArray count]) {
            Product *selectedProduct = [foundArray objectAtIndex:0];
            selectedProduct.productPrice = product.productPrice;
            selectedProduct.productBbPrice = product.productBbPrice;
            repoArray[i]=selectedProduct;
        }
    }
    return repoArray;
}

-(void) getSelectedProductsArrayWithUpdatedPricesWithCompletionBlock:(void(^)(bool success, NSMutableArray* selectedProdsArray))completionBlock{
    CartServiceClient *client = [[CartServiceClient alloc] init];
    [client fetchCartRepoForProductIds:[self getSelectedProductIdsStr] WithSuccess:^(NSMutableArray *repo) {
        [self updateWithNewSearchedArray:repo];
        completionBlock(YES,self.selectedProducts);
    } failure:^(NSError *error) {
        completionBlock(NO,self.selectedProducts);
    }];
}

-(NSString*) getSelectedProductIdsStr{
    NSString *idsStr=@"";
    if (self.selectedProducts && self.selectedProducts.count) {
        for (Product *product in self.selectedProducts) {
            idsStr = [NSString stringWithFormat:@"%@,%@",idsStr,product.productId];
        }
        idsStr = [idsStr substringFromIndex:1];
    }
    return idsStr;
}

@end
