//
//  CartTableViewCell.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/17/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "CartTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "BlickbeeAppManager.h"
/*
@interface NSLayoutConstraint (Description)

@end

@implementation NSLayoutConstraint (Description)

-(NSString *)description {
    return [NSString stringWithFormat:@"id: %@, constant: %f", self.identifier, self.constant];
}

@end*/

@implementation CartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void) bindData : (Product *) product{
    self.item=product;
    
    NSMutableAttributedString *productChangedPrice= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",@"₹",product.productBbPrice]];//₹
//    NSMutableAttributedString *productPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",@"₹",product.productPrice]];
//    [productChangedPrice addAttribute:NSStrikethroughStyleAttributeName
//                                value:@2
//                                range:NSMakeRange(0, [productChangedPrice length])];
//    [productPrice addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [productChangedPrice length])];
//    NSAttributedString *space = [[NSAttributedString alloc]initWithString:@" "];
//    [productChangedPrice appendAttributedString:space];
//    [productChangedPrice appendAttributedString:productPrice];

    
    self.labelForProductTitle.text=product.productName;
    self.labelForPrice.attributedText=productChangedPrice;
    self.labelForUnitQuantity.text=product.productUnitQty;
    self.labelForQuantity.text=product.selectedProductQuantity;
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
}

- (IBAction)addButtonClicked:(id)sender {
    NSInteger selectedQty = [self.item.selectedProductQuantity integerValue];
    NSInteger productCap = [self.item.productCap integerValue];
    if (selectedQty < productCap ) {
    self.item.selectedProductQuantity = [NSString stringWithFormat:@"%ld",(long)([self.item.selectedProductQuantity integerValue]+1)];
        [self.reloadCellDelegate reloadCellWithProduct:self.item];
        [self.productQuantityChangedDelegate productQuantityChanged];
    }

}
- (IBAction)subtractButtonClicked:(id)sender {
    if([self.item.selectedProductQuantity isEqualToString:@"0"]){
        if([[[BlickbeeAppManager sharedInstance] selectedProducts] containsObject:self.item]){
                [[[BlickbeeAppManager sharedInstance] selectedProducts] removeObject:self.item];
        }
    }
    else{
        self.item.selectedProductQuantity = [NSString stringWithFormat:@"%ld",(long)([self.item.selectedProductQuantity integerValue]-1)];
        if([self.item.selectedProductQuantity isEqualToString:@"0"]){
            if([[[BlickbeeAppManager sharedInstance] selectedProducts] containsObject:self.item]){
                [[[BlickbeeAppManager sharedInstance] selectedProducts] removeObject:self.item];
            }
        }
        [self.reloadCellDelegate reloadCellWithProduct:self.item];
    }
    [self.productQuantityChangedDelegate productQuantityChanged];
}
@end
