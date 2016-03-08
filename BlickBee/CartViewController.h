//
//  CartViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/17/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "BaseViewController.h"
@interface CartViewController :BaseViewController
- (IBAction)startShoppingButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startShoppingButtonClicked;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForCartViewController;
@property (weak, nonatomic) IBOutlet UIButton *proceedButtonClicked;
- (IBAction)proceedButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelForSubtotal;
@property (weak, nonatomic) IBOutlet UILabel *labelForDelivery;
@property (weak, nonatomic) IBOutlet UILabel *labelForTotal;
@property (strong, nonatomic) NSMutableArray *productArray;
-(void)openHomeVC;
@end
