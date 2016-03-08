//
//  LeftDeckTableViewCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/9/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftDeckTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageForDeckItem;
@property (weak, nonatomic) IBOutlet UILabel *labelForDeckItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageForColorSeperation;

@end
