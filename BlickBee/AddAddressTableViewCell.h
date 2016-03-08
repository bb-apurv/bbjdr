//
//  AddAddressTableViewCell.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/25/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol openAddressPopUp <NSObject>

-(void) openAddressPopUp;

@end


@interface AddAddressTableViewCell : UITableViewCell

@property (nonatomic,strong) id<openAddressPopUp> addressDelegate;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
