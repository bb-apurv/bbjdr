//
//  OrdersDetailTableView.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface OrdersDetailTableView : UITableView
-(id) initWithFrame:(CGRect)frame andOrder:(Order*) order;
@property (nonatomic,strong) Order *order;
@end
