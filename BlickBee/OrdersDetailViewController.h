//
//  OrdersDetailViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "BaseViewController.h"
@interface OrdersDetailViewController : BaseViewController
@property (strong,nonatomic) Order *order;
@end
