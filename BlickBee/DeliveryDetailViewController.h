//
//  DeliveryDetailViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/19/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryDetailTableView.h"
#import "Address.h"
#import "BaseViewController.h"
@interface DeliveryDetailViewController : BaseViewController <openNewAddress,addressRecived>
@property (strong,nonatomic) Address *addressItem;
@end
