//
//  DeliveryDetailTableView.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/19/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAddressTableViewCell.h"
#import "DeliveryDetailTableViewCell.h"
#import "DeliveryTimeTableViewCell.h"
#import "DeliveryAddressTableViewCell.h"
#import "Address.h"
@protocol openNewAddress <NSObject>

-(void) openNewAddress;
-(void) editAddressWithPrevAddress:(Address*)prevAddress;

@end
@protocol addressRecived <NSObject>

-(void)addressRecived:(Address *)addressItem;

@end

@interface DeliveryDetailTableView : UITableView<openAddressPopUp,editBtnClicked>
-(id) initWithFrames:(CGRect)frame;
@property (nonatomic,strong) id<openNewAddress> addressDelegate;
@property (nonatomic,strong) id<addressRecived> addressrecievedDelegate;
@end
