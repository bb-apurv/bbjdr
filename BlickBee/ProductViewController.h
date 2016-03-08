//
//  ProductViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/12/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductRepo.h"
#import "OptionsPopOverViewControllerTableViewController.h"
#import "BaseViewController.h"
@interface ProductViewController : BaseViewController
@property (strong,nonatomic) NSMutableArray *productArray;
@property (strong,nonatomic) ProductRepo *productRepo;
@property (assign,nonatomic) DeliveryOptions deliveryOptions;

@property (weak, nonatomic) IBOutlet UIButton *floatingBtn;

@end
