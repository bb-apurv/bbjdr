//
//  FirstOrderDetailCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface FirstOrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelForOrderID;
@property (weak, nonatomic) IBOutlet UILabel *labelForAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelForDate;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForStatus;
-(void)bindData : (Order *)order;
@end
