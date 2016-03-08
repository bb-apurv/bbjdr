//
//  MyOrdersTableViewCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/23/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@protocol launchOrderDetailVC <NSObject>
-(void) launchOrderDetailVC : (Order *)order;

@end
@interface MyOrdersTableViewCell : UITableViewCell

-(void) bindData : (Order *) myOrder;
@property (weak, nonatomic) IBOutlet UILabel *labelForOrderDate;
@property (weak, nonatomic) IBOutlet UILabel *labelForOrderID;

@property (weak, nonatomic) IBOutlet UILabel *labelForPrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonPressedViewOrder;
- (IBAction)buttonPressedViewOrder:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForStatus;
@property (weak,nonatomic) id <launchOrderDetailVC> launchOrderDetailVCDelegate;
@property (strong,nonatomic) Order *item;
@end
