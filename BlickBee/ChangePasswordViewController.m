//
//  ChangePasswordViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LoginServiceClient.h"
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    // Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
    self.topSpaceConstraint.constant=-170;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

-(void)keyboardWillHide {
    self.topSpaceConstraint.constant=32;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{// return NO to disallow editing.
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
- (IBAction)proceedBtnPressed:(id)sender {
    NSString *msg=@"";
    if ([self.passwordTextField.text isEqualToString:@""]) {
        msg=@"Please enter the password.";
    }
    if ([self.confirmPasswordTextField.text isEqualToString:@""]) {
        msg=@"Please confirm the password.";
    }
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        msg=@"The confirmed password do not match with the password entered";
    }
    if (![msg isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    LoginServiceClient *client = [[LoginServiceClient alloc] init];
    if (self.isForgotPassword) {
        if (![self.phone isEqualToString:@""]) {
            [client changePasswordWithNewPassword:self.passwordTextField.text andPhone:self.phone withSuccess:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
            }];
        }
    }
    else{
        [client changePasswordWithNewPassword:self.passwordTextField.text withSuccess:^{
            SWRevealViewController *swRevealVC = self.revealViewController;
            [swRevealVC.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
    }

}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self prepareView];
    // Your layout logic here
}
-(void) prepareView{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, self.passwordTextField.frame.size.height - borderWidth, self.passwordTextField.frame.size.width, self.passwordTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.passwordTextField.layer addSublayer:border];
    self.passwordTextField.layer.masksToBounds = YES;
    [self.passwordTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];

    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor whiteColor].CGColor;
    border2.frame = CGRectMake(0, self.confirmPasswordTextField.frame.size.height - borderWidth, self.confirmPasswordTextField.frame.size.width, self.confirmPasswordTextField.frame.size.height);
    border2.borderWidth = borderWidth;
    [self.confirmPasswordTextField.layer addSublayer:border2];
    self.confirmPasswordTextField.layer.masksToBounds = YES;
    [self.confirmPasswordTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];

    self.proceedBtnPressed.layer.cornerRadius = 17.0;
    self.proceedBtnPressed.layer.borderWidth = 2.0;
    self.proceedBtnPressed.layer.borderColor = [UIColor whiteColor].CGColor;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
