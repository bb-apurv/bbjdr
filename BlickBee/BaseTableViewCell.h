//
//  BaseTableViewCell.h
//  
//
//  Created by Sanchit Kumar Singh on 11/9/15.
//
//

#import <UIKit/UIKit.h>
#import "Product.h"
@protocol productProtocolDelegate <NSObject>
-(void) productRecievedFromCell: (Product*) product;
@end
@interface BaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewForProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelForProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelForProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelForProductQuantity;
@property (weak, nonatomic) IBOutlet UIButton *addToCartClicked;
@property (strong, nonatomic) Product *item;
- (IBAction)addToCartClicked:(id)sender;
-(void) bindData:(Product*)product;
@property (weak,nonatomic) id <productProtocolDelegate> productDelegate;
@end
