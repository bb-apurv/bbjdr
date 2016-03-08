//
//  AddressConfirmationTableViewCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "Promo.h"

/*@protocol applyToApplied <NSObject>

-(void) applyToApplied;

@end
*/

@interface AddressConfirmationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelForTotalAmount;
@property (weak, nonatomic) IBOutlet UILabel *netAmountField;
@property (weak, nonatomic) IBOutlet UILabel *labelForDiscount;

@property (weak, nonatomic) IBOutlet UILabel *labelForTotalQuantity;
@property (weak, nonatomic) IBOutlet UILabel *labelForPaymentMode;
@property (strong,nonatomic) NSString *totalQuantity;
@property (strong,nonatomic) NSString *totalAmount;
-(void) bindDataForOrder;
-(void) updateTotalAmountByPromo;
//@property (weak,nonatomic) id<applyToApplied> applyToAppliedDelegate;


@end
