//
//  LoginDetailsViewController.h
//  BlickBee
//
//  Created by Apurv Gupta on 23/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginDetailsViewController : BaseViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *proceedBtn;

- (IBAction)proceedButton;

@end
