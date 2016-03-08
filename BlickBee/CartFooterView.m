//
//  CartFooterView.m
//  BlickBee
//
//  Created by Kunal Chelani on 12/1/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "CartFooterView.h"
#import "CartViewController.h"
@implementation CartFooterView


- (IBAction)shopMorePressed:(id)sender {
    UIViewController *home = [self getViewController];
    if ([home isKindOfClass:[CartViewController class]]) {
        [(CartViewController*)home openHomeVC];
    }
}

-(void) prepareView{
   // self.shopMoreBtn.layer.cornerRadius = 0.0;
    //self.shopMoreBtn.layer.borderWidth = 1.0;
    //self.shopMoreBtn.layer.borderColor = [UIColor blackColor].CGColor;
}
- (UIViewController *)getViewController {
    UIResponder *nextResponderView = [self nextResponder];
    while (![nextResponderView isKindOfClass:[UIViewController class]]) {
        nextResponderView = [nextResponderView nextResponder];
        if (nil == nextResponderView) {
            break;
        }
    }
    return (UIViewController *)nextResponderView;
}
@end
