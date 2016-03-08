//
//  OrdersDetailTableViewCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderedProduct.h"

@interface OrdersDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelForProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelForCost;
@property (weak, nonatomic) IBOutlet UILabel *labelForQty;
@property (weak, nonatomic) IBOutlet UILabel *labelForTotalCost;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForProduct;
-(void)bindDataWithProduct : (OrderedProduct *) product;
@end
