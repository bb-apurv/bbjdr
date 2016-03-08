//
//  CartTableView.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/17/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELL_HEIGHT 85

@protocol openHomeVC <NSObject>

-(void) openHomeVC;

@end

@protocol changePriceLabelInCartViewController <NSObject>

-(void)changePriceLabel;

@end

@interface CartTableView : UITableView

-(id) initWithFrame:(CGRect)frame andProductsArray:(NSMutableArray*) prodsArray;
@property (weak,nonatomic) NSMutableArray *productArray;

@property (weak,nonatomic) id<openHomeVC> openHomeVCDelegate;
@property (weak,nonatomic) id<changePriceLabelInCartViewController> changePriceLabelInCartViewControllerDelegate;

@end
