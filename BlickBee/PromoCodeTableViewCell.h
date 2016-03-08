//
//  PromoCodeTableViewCell.h
//  BlickBee
//
//  Created by Apurv Gupta on 11/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promo.h"


@protocol reloadTableCell <NSObject>
-(void) applyClicked;
//-(void) applyToApplied;
@end

@interface PromoCodeTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *promoCodeText;

- (IBAction)applyButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *applyButtonText;

//@property (nonatomic, copy) void (^buttonTapAction)(id *sender );

@property (weak,nonatomic) id <reloadTableCell> reloadTableCellDelegate;

@end
