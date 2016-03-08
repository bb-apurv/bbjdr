//
//  DeliveryAddressTableViewCell.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "DeliveryAddressTableViewCell.h"
#import "AddAddressServiceClient.h"
@implementation DeliveryAddressTableViewCell

- (void)awakeFromNib {
//    self.backgroundColor=RGBA(225, 225, 225, 1);
    UIImage *editImage = [UIImage imageNamed:@"pencil.png"];
    [_editButtonClicked setImage:editImage forState:UIControlStateNormal];
    UIImage *removeImage = [UIImage imageNamed:@"dustbin.png"];
    [_removeButtonClicked setImage:removeImage forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)editButtonClicked:(id)sender {
    [self.editBtnDelegate editBtnClickedWith:self.itemAddress];
}

- (IBAction)removeButtonClicked:(id)sender {
    
    AddAddressServiceClient *client = [[AddAddressServiceClient alloc] init];
    [client removeAddress:self.itemAddress WithSuccess:^{
        NSInteger idx=-1;
        for (int i=0; i<[BlickbeeAppManager sharedInstance].userAddresses.count; i++) {
            Address *address = [[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:i];
            if ([address.addressId isEqualToString:self.itemAddress.addressId]) {
                idx=i;
                break;
            }
        }
        if (idx>=0) {
            [[BlickbeeAppManager sharedInstance].userAddresses removeObjectAtIndex:idx];
        }
        
        [self.editBtnDelegate removeBtnClicked];
    } failure:^(NSError *error) {
        
    }];
    
}

-(void) bindData:(Address*)address{
    self.itemAddress=address;
    self.nameLabel.text = address.name;
    self.phoneLabel.text = address.phone;
    self.address1Label.text = address.street;
    self.address2Label.text = address.landmark;
}

@end
