//
//  AddressConfirmationTableViewCell.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AddressConfirmationTableViewCell.h"
#import "BlickbeeAppManager.h"
#import "Product.h"
#import "Promo.h"


@implementation AddressConfirmationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) bindDataForOrder{
    self.labelForPaymentMode.text=@"COD";
    NSInteger totalAmount=0;
    NSInteger totalQuantity=0;
    for(int i=0;i<[BlickbeeAppManager sharedInstance].selectedProducts.count;i++){
        //NSInteger productCost=0;
        Product *product=[[Product alloc]init];
        product = [[BlickbeeAppManager sharedInstance].selectedProducts objectAtIndex:i];
        //productCost=[product.productPrice integerValue];
        totalQuantity+=[product.selectedProductQuantity integerValue];
        totalAmount+=([product.selectedProductQuantity integerValue]*[product.productBbPrice integerValue]);
    }
    //[BlickbeeAppManager sharedInstance].totAmount = totalAmount;
    self.labelForDiscount.text=@"0";
    self.labelForTotalAmount.text=[NSString stringWithFormat:@"%@ %ld",@"₹",(long)totalAmount];
    self.labelForTotalQuantity.text=[NSString stringWithFormat:@"%@ %ld",@"₹",(long)totalAmount];
}

/*-(void) applyClicked:(Promo *) promo{
    //NSInteger row = [self.productArray indexOfObject:product];
    NSRange range = NSMakeRange(2, 1);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    
   // [self.addressConfirmationTableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    
    //[self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
}*/


-(void) updateTotalAmountByPromo{
    self.labelForPaymentMode.text=@"COD";
    NSInteger totalAmount=0;
    NSInteger totalQuantity=0;
    NSInteger discount = 0;
    double discountedAmount = 0.0f;
    for(int i=0;i<[BlickbeeAppManager sharedInstance].selectedProducts.count;i++){
        //NSInteger productCost=0;
        Product *product=[[Product alloc]init];
        product = [[BlickbeeAppManager sharedInstance].selectedProducts objectAtIndex:i];
        //productCost=[product.productPrice integerValue];
        totalQuantity+=[product.selectedProductQuantity integerValue];
        totalAmount+=([product.selectedProductQuantity integerValue]*[product.productBbPrice integerValue]);
    }
    if (totalAmount<[BlickbeeAppManager sharedInstance].amountCap){
        [BlickbeeAppManager sharedInstance].promoApplied = 0;
        NSString *msg = [NSString stringWithFormat:@"%@ %d",@"This Promo Code is valid above the amount ₹",[BlickbeeAppManager sharedInstance].amountCap];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        self.labelForTotalAmount.text=[NSString stringWithFormat:@"%@ %ld",@"₹",(long)totalAmount];
        self.labelForDiscount.text=@"0";

        self.labelForTotalQuantity.text=[NSString stringWithFormat:@"%@ %ld",@"₹", (long)totalAmount];
    }
    else{
        NSString *msg = @"Code Applied";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];

    discount = [BlickbeeAppManager sharedInstance].discount;
      //  [self.applyToAppliedDelegate applyToApplied]; //to change button apply to applied
        
    if([[BlickbeeAppManager sharedInstance].offerType isEqualToString:@"1"] ){
        discountedAmount = (totalAmount - discount);
       // NSLog(@"%f",discountedAmount);
        self.labelForDiscount.text=[NSString stringWithFormat:@"%@ %li",@"₹",discount];
    } else {
        discountedAmount = totalAmount - (double)(discount*totalAmount)/100;
        self.labelForDiscount.text=[NSString stringWithFormat:@"%@ %0.1f",@"₹",(double)(discount*totalAmount)/100];
       // NSLog(@"%f",discountedAmount);

    }
    self.labelForTotalAmount.text=[NSString stringWithFormat:@"%@ %ld",@"₹",(long)totalAmount];
        

       // [self.netAmountField setHidden:YES];
      //  [self.labelForTotalQuantity setHidden:YES];
    self.labelForTotalQuantity.text=[NSString stringWithFormat:@"%@ %0.1f",@"₹",discountedAmount];

    }
    
}

@end
