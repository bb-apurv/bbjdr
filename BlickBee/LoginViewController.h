//
//  LoginViewController.h
//  BlickBee
//
//  Created by Apurv Gupta on 20/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
- (IBAction)loginBtn:(id)sender;
@end
