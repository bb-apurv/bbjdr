//
//  AddAddressTableViewCell.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/25/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AddAddressTableViewCell.h"

@implementation AddAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self prepareView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addAddressBtn:(id)sender {
    [self.addressDelegate openAddressPopUp];
}
-(void) prepareView{
  //  self.addBtn.layer.cornerRadius = 0.0;
   // self.addBtn.layer.borderWidth = 1.0;
   // self.addBtn.layer.borderColor = [UIColor blackColor].CGColor;
}
@end
