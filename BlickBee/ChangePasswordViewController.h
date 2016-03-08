//
//  ChangePasswordViewController.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
@interface ChangePasswordViewController : BaseViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *proceedBtnPressed;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceConstraint;
@property (strong, nonatomic) NSString *phone;
@property (assign,nonatomic) BOOL isForgotPassword;

@end
