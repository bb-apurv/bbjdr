//
//  AddressConfirmationViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "Order.h"
#import "PromoCodeTableViewCell.h"

@interface AddressConfirmationViewController : UIViewController //<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) Address *address;
@property (weak, nonatomic) IBOutlet UITableView *addressConfirmationTableView;

@property (weak, nonatomic) IBOutlet UIButton *confirmOrderClicked;
- (IBAction)confirmOrderClicked:(id)sender;

@end
