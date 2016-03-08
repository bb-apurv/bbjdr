//
//  ForgotPasswordViewController.h
//  BlickBee
//
//  Created by Kunal Chelani on 12/28/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ForgotPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@end
