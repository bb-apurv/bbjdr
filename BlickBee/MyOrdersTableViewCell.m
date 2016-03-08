//
//  MyOrdersTableViewCell.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/23/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "MyOrdersTableViewCell.h"

@implementation MyOrdersTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) bindData : (Order *)myOrder{
    [self setBackgroundColor:RGBA(225, 225, 225, 1)];
    self.item=myOrder;
    self.labelForOrderDate.text=myOrder.orderCreatedDate;
    self.labelForOrderID.text=myOrder.uniqueOrderId;
    self.labelForPrice.text=[NSString stringWithFormat:@"₹%.2f",[myOrder.orderAmount floatValue]];
    if([myOrder.orderStatus isEqualToString:@"0"]||[myOrder.orderStatus isEqualToString:@"Pending"]){
    self.imageViewForStatus.image=[UIImage imageNamed:@"2_a.png"];
    }
    else if([myOrder.orderStatus isEqualToString:@"1"]){
    self.imageViewForStatus.image=[UIImage imageNamed:@"2_b.png"];
    }
    else if([myOrder.orderStatus isEqualToString:@"2"]){
        self.imageViewForStatus.image=[UIImage imageNamed:@"2_c.png"];
    }
    else if([myOrder.orderStatus isEqualToString:@"3"]){
        self.imageViewForStatus.image=[UIImage imageNamed:@"4.png"];
    }
//    [self.imageViewForStatus sizeToFit];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (IBAction)buttonPressedViewOrder:(id)sender{
    [self.launchOrderDetailVCDelegate launchOrderDetailVC : self.item];
}

@end
