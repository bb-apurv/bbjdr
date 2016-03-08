//
//  AddToCartTableViewCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/15/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@protocol reloadTable <NSObject>
-(void) addClicked:(Product *) product;
-(void) subtractClicked:(Product *) product;
@end

@interface AddToCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForProduct;
- (IBAction)addButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addButtonClicked;
@property (weak, nonatomic) IBOutlet UIButton *subtractButtonClicked;

@property (weak, nonatomic) IBOutlet UIButton *addToCartPressed;

@property (weak, nonatomic) IBOutlet UILabel *labelForProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelForPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelForQuantity;
@property (strong, nonatomic) Product *itemData;

- (IBAction)subtractButtonClicked:(id)sender;
-(void) bindData:(Product*)product andQuantityAdded:(NSString *) quantity;
@property (weak,nonatomic) id <reloadTable> reloadTableCellDelegate;
@end
