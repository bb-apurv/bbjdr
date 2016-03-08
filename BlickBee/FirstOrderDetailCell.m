//
//  FirstOrderDetailCell.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "FirstOrderDetailCell.h"
#import "Order.h"

@implementation FirstOrderDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bindData : (Order *)order{
    //self.imageViewForStatus.image = [UIImage imageNamed:@"2_a.png"];
    if([order.orderStatus isEqualToString:@"0"]||[order.orderStatus isEqualToString:@"Pending"]){
        self.imageViewForStatus.image=[UIImage imageNamed:@"2_a.png"];
    }
    else if([order.orderStatus isEqualToString:@"1"]){
        self.imageViewForStatus.image=[UIImage imageNamed:@"2_b.png"];
    }
    else if([order.orderStatus isEqualToString:@"2"]){
        self.imageViewForStatus.image=[UIImage imageNamed:@"2_c.png"];
    }
    else if([order.orderStatus isEqualToString:@"3"]){
        self.imageViewForStatus.image=[UIImage imageNamed:@"4.png"];
    }
    [self.imageViewForStatus sizeToFit];
    self.labelForOrderID.text=order.uniqueOrderId;
    self.labelForAmount.text=[NSString stringWithFormat:@"₹ %.2f",[order.orderAmount floatValue]];
    self.labelForDate.text=order.orderCreatedDate;
    self.selectionStyle=UITableViewCellSelectionStyleNone;

}

@end
