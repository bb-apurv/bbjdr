//
//  OptionsPopOverViewControllerTableViewController.h
//  BlickBee
//
//  Created by Kunal Chelani on 12/4/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kFruits,
    kVegetables
}DeliveryOptions;

@protocol optionSelected <NSObject>

-(void) optionSelected:(DeliveryOptions)optionSelected;

@end

@interface OptionsPopOverViewControllerTableViewController : UITableViewController

@property (nonatomic,weak) id<optionSelected> optionSelectedDelegate;

@end
