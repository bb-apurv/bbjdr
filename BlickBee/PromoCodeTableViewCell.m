//
//  PromoCodeTableViewCell.m
//  BlickBee
//
//  Created by Apurv Gupta on 11/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "PromoCodeTableViewCell.h"
#import "PromoServiceClient.h"
#import "User.h"
#import "Promo.h"
#import "AddressConfirmationTableViewCell.h"
#import "AddressConfirmationViewController.h"
#import "BlickbeeAppManager.h"

@implementation PromoCodeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.promoCodeText.delegate =self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*-(void) changeLabel{
    self.applyButtonText.userInteractionEnabled = NO;
     
}*/

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}





- (IBAction)applyButtonPressed:(id)sender {
    /*if (self.buttonTapAction) {
        self.buttonTapAction(sender);
    }*/
    
    if ([self.promoCodeText.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid Promo Code." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }
  //  self.promoCodeText.delegate=self;
    PromoServiceClient *client = [[PromoServiceClient alloc] init];
    
    NSString *codeStr = self.promoCodeText.text;
    
     [client verifyPromoCode:codeStr WithSuccess:^(Promo *promo) {
         //NSLog(@"%@",promo.discount);
        
        /* AddressConfirmationTableViewCell *cell = [[AddressConfirmationTableViewCell alloc] init];
         
         [cell updateTotalAmountByPromo:promo];
         */
         [BlickbeeAppManager sharedInstance].offerType = promo.offerType;

         [BlickbeeAppManager sharedInstance].discount =[promo.discount intValue] ;
         [BlickbeeAppManager sharedInstance].promoApplied = 1;
        [self.reloadTableCellDelegate applyClicked];
         /*if ([BlickbeeAppManager sharedInstance].promoApplied == 1){
             [_applyButtonText setTitle:@"Applied" forState:UIControlStateNormal];
         }
         if ([BlickbeeAppManager sharedInstance].promoApplied == 1){
             [self.reloadTableCellDelegate applyToApplied];
         }*/
         if ([BlickbeeAppManager sharedInstance].promoApplied ==1){
         self.promoCodeText.userInteractionEnabled = NO;
             self.applyButtonText.enabled = NO;
             [self.applyButtonText setTitle:@"Applied" forState:UIControlStateNormal];
         }
    
     } failure:^(NSError *error) {
         
     }];

   /* if (self.buttonTapAction) {
        self.buttonTapAction(sender);
    }*/

    
}
@end
