//
//  DeliveryTimeTableViewCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliveryTimeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelForDeliveryTimings;
@property (weak, nonatomic) IBOutlet UILabel *labelForSameDayTimings;
@property (weak, nonatomic) IBOutlet UILabel *labelForNextDayTimings;

@end
