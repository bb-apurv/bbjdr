//
//  BaseTableViewCell.m
//  
//
//  Created by Sanchit Kumar Singh on 11/9/15.
//
//

#import "BaseTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "BlickbeeAppManager.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addToCartClicked:(id)sender {
    
    //delegate - product
    self.item.selectedProductQuantity = @"1";
    if(![[[BlickbeeAppManager sharedInstance] selectedProducts] containsObject:self.item]){
    [[[BlickbeeAppManager sharedInstance] selectedProducts] addObject:self.item];
    }
    [self.productDelegate productRecievedFromCell:self.item];
    
}


//bind- product
-(void) bindData:(Product*)product{
    self.item=product;
    if([product.productImages objectAtIndex:0]){
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:[product.productImages objectAtIndex:0]] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
        [self.imageViewForProduct setImageWithURLRequest:req placeholderImage:[UIImage imageNamed:@"loading-img.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            if (!request) {
                self.imageViewForProduct.image=image;
                self.imageViewForProduct.contentMode=UIViewContentModeScaleToFill;
            }
            else{
                
                [UIView transitionWithView:self.imageViewForProduct duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    self.imageViewForProduct.image=image;
                    self.imageViewForProduct.contentMode=UIViewContentModeScaleToFill;
                } completion:^(BOOL finished) {
                    
                }];
            }
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        }];
    }
    NSMutableAttributedString *productChangedPrice= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",@"₹",product.productPrice]];//₹
    NSMutableAttributedString *productPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",@"₹",product.productBbPrice]];
    [productChangedPrice addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [productChangedPrice length])];
    [productChangedPrice addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [productChangedPrice length])];
    NSAttributedString *space = [[NSAttributedString alloc]initWithString:@" "];
    [productChangedPrice appendAttributedString:space];
    [productChangedPrice appendAttributedString:productPrice];
    [self.labelForProductName setNumberOfLines:0];
    self.labelForProductName.text=product.productName;
    
    self.labelForProductPrice.attributedText=productChangedPrice;
    self.labelForProductQuantity.text=product.productUnitQty;
    [self.addToCartClicked setBackgroundImage:[UIImage imageNamed:@"cartadd.png"] forState:UIControlStateNormal];
    
    self.backgroundColor=RGBA(225, 225, 225, 1);
}

@end
