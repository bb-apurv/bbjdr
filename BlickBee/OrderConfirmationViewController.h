//
//  OrderConfirmationViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/27/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "BaseViewController.h"
@interface OrderConfirmationViewController : BaseViewController
- (IBAction)shopMoreButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shopMoreButtonPressed;
@property (weak, nonatomic) IBOutlet UILabel *labelForOrderID;
@property (strong,nonatomic) Order *orderItem;
@end
