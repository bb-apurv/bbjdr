//
//  SignUpViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/15/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginServiceClient.h"
#import "BlickbeeAppManager.h"
#import "SWRevealViewController.h"
#import "OTPViewController.h"
@interface SignUpViewController ()
{
    BOOL securityEntry;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    securityEntry=YES;
    self.passwordTextField.secureTextEntry = securityEntry;
    self.phoneTextField.keyboardType=UIKeyboardTypeNumberPad;
}
    // Do any additional setup after loading the view.

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
    self.topSpaceConstraint.constant=-160;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

-(void)keyboardWillHide {
    self.topSpaceConstraint.constant=20;
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


- (IBAction)signUpBtn:(id)sender {

    if ([self.nameTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text.length>10) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid phone number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    if (![self.emailTextField.text isEqualToString:@""] && ![self NSStringIsValidEmail:self.emailTextField.text]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email address." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    
    LoginServiceClient *client = [[LoginServiceClient alloc] init];
    NSMutableDictionary *credentialsDict = [[NSMutableDictionary alloc] init];
    [credentialsDict setObject:self.emailTextField.text forKey:@"email"];
    [credentialsDict setObject:self.passwordTextField.text forKey:@"password"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]) {
        [credentialsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"] forKey:@"access_token"];
    }
    else{
        [credentialsDict setObject:@"kjhskjhaskjhasdkjsahk" forKey:@"access_token"];
    }
    [credentialsDict setObject:self.phoneTextField.text forKey:@"phone"];
    [credentialsDict setObject:self.nameTextField.text forKey:@"name"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]) {
        [credentialsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"] forKey:@"device_id"];
    }
    else{
        [credentialsDict setObject:@"kjhskjhaskjhasdkjsahk" forKey:@"device_id"];
    }
    
    [client signUpWithDictionary:credentialsDict WithSuccess:^(User *user) {
        
        if (user.userId && ![user.userId isEqualToString:@""]) {
            
            [[BlickbeeAppManager sharedInstance] userLoginSuccessfulWith:user];
            UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            OTPViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"OTPViewController"];
            cont.isFromSignUp=YES;
            cont.user=user;
            [self.navigationController pushViewController:cont animated:YES];
            
//            [self presentViewController:cont animated:YES completion:^{
//                
//            }];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-ba-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


- (IBAction)showPasswordPressed:(id)sender {
    securityEntry=!securityEntry;
    if (securityEntry) {
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesclosed"] forState:UIControlStateNormal];
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesclosed"] forState:UIControlStateHighlighted];
    }
    else{
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesopen"] forState:UIControlStateNormal];
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesopen"] forState:UIControlStateHighlighted];
    }    self.passwordTextField.secureTextEntry = securityEntry;
}
- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    border.frame = CGRectMake(0, self.nameTextField.frame.size.height - borderWidth, self.nameTextField.frame.size.width, self.nameTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.nameTextField.layer addSublayer:border];
    self.nameTextField.layer.masksToBounds = YES;
    [self.nameTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor whiteColor].CGColor;
    border2.frame = CGRectMake(0, self.emailTextField.frame.size.height - borderWidth, self.emailTextField.frame.size.width, self.emailTextField.frame.size.height);
    border2.borderWidth = borderWidth;
    [self.emailTextField.layer addSublayer:border2];
    self.emailTextField.layer.masksToBounds = YES;
    [self.emailTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = [UIColor whiteColor].CGColor;
    border3.frame = CGRectMake(0, self.passwordTextField.frame.size.height - borderWidth, self.passwordTextField.frame.size.width, self.passwordTextField.frame.size.height);
    border3.borderWidth = borderWidth;
    [self.passwordTextField.layer addSublayer:border3];
    self.passwordTextField.layer.masksToBounds = YES;
    [self.passwordTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    CALayer *border4 = [CALayer layer];
    border4.borderColor = [UIColor whiteColor].CGColor;
    border4.frame = CGRectMake(0, self.phoneTextField.frame.size.height - borderWidth, self.phoneTextField.frame.size.width, self.phoneTextField.frame.size.height);
    border4.borderWidth = borderWidth;
    [self.phoneTextField.layer addSublayer:border4];
    self.phoneTextField.layer.masksToBounds = YES;
    [self.phoneTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    self.signUpBtn.layer.cornerRadius = 17.0;
    self.signUpBtn.layer.borderWidth = 2.0;
    self.signUpBtn.layer.borderColor = [UIColor whiteColor].CGColor;
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
