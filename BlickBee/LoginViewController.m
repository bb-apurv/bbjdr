//
//  LoginViewController.m
//  BlickBee
//
//  Created by Apurv Gupta on 20/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfoServiceClient.h"
#import "LoginServiceClient.h"
#import "SWRevealViewController.h"
#import "BlickbeeAppManager.h"
#import "UIFont+Custom.h"
#import "OTPViewController.h"
@interface LoginViewController () <UITextFieldDelegate>
{
   // BOOL securityEntry;
    

}
@end

@implementation LoginViewController

//-(void)

- (void)viewDidLoad {
    [super viewDidLoad];
    //securityEntry=YES;
    self.phoneTextField.delegate =self;
    //self.passTextField.secureTextEntry = securityEntry;
    [self checkIfUserIsLoggedIn];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.phoneTextField.text=@"";
    //self.passTextField.text=@"";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
   // self.topSpaceConstraint.constant=-170;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

-(void)keyboardWillHide {
    //self.topSpaceConstraint.constant=31;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self prepareView];
    // Your layout logic here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) textViewDidBeginEditing:(UITextField *) textField {
    [textField setText:@""];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 10 || returnKey;
}

- (IBAction)loginBtn:(id)sender {
    /*
     if ([self.emailTxtField.text isEqualToString:@""]) {
     [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email address or mobile number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
     return;
     }*/
    
    if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text.length!=10) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid phone number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    
    /*  if ([self.passTextField.text isEqualToString:@""]) {
     [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
     return;
     }*/
    
    LoginServiceClient *client = [[LoginServiceClient alloc] init];
    NSMutableDictionary *credentialsDict = [[NSMutableDictionary alloc] init];
    [credentialsDict setObject:self.phoneTextField.text forKey:@"phone"];
    //[credentialsDict setObject:self.passTextField.text forKey:@"password"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]) {
        [credentialsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"] forKey:@"access_token"];
    }
    else{
        [credentialsDict setObject:@"kjhskjhaskjhasdkjsahk" forKey:@"access_token"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]) {
        [credentialsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"] forKey:@"device_id"];
    }
    else{
        [credentialsDict setObject:@"kjhskjhaskjhasdkjsahk" forKey:@"device_id"];
    }
    
    [client signInWithDictionary:credentialsDict WithSuccess:^(User *user) {
        
        if (user.userId && ![user.userId isEqualToString:@""]) {
           
            [BlickbeeAppManager sharedInstance].user.userId = user.userId;
            [BlickbeeAppManager sharedInstance].user.phone = user.phone;
            
           // [[BlickbeeAppManager sharedInstance] userLoginSuccessfulWith:user];
            if([user.otpStatus isEqualToString:@"1"]){
                [[BlickbeeAppManager sharedInstance] userLoginSuccessfulWith:user];
                
            UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            //            [self presentViewController:cont animated:YES completion:^{
            //
            //            }];
            [self.navigationController pushViewController:cont animated:YES];
            }
            else {
            
                UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                //            SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                OTPViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"OTPViewController"];
              //  cont.isFromSignUp=YES;
                cont.user=user;
                [self.navigationController pushViewController:cont animated:YES];
                

            
            
            }
        
        }
        
    } failure:^(NSError *error) {
        
    }];
}

/*- (BOOL)emailTxtField:(UITextField *)emailTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
 NSString *newString = [emailTextField.text stringByReplacingCharactersInRange:range withString:string];
 return !([newString length] > 10);
 
 }*/

/*-(BOOL) NSStringIsValidEmail:(NSString *)checkString
 {
 BOOL stricterFilter = NO;
 NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
 NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
 NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
 NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
 return [emailTest evaluateWithObject:checkString];
 }*/

/*- (IBAction)showPassword:(id)sender {
    securityEntry=!securityEntry;
    if (securityEntry) {
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesclosed"] forState:UIControlStateNormal];
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesclosed"] forState:UIControlStateHighlighted];
    }
    else{
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesopen"] forState:UIControlStateNormal];
        [self.securityBtn setImage:[UIImage imageNamed:@"eyesopen"] forState:UIControlStateHighlighted];
    }
    self.passTextField.secureTextEntry = securityEntry;
}*/
//- (IBAction)forgotPassword:(id)sender {
    
    
    
//}

/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 10);
    
}*/

-(void) prepareView{
    UIColor *color = [UIColor whiteColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: color};
    NSAttributedString *attributedPlaceholderString = [[NSAttributedString alloc] initWithString:@"Enter number" attributes:attributes];
    self.phoneTextField.attributedPlaceholder = attributedPlaceholderString;
}
    /*if ([_phoneTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Number" attributes:@{NSForegroundColorAttributeName: color}];
        
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }}*/
    /*CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, self.emailTxtField.frame.size.height - borderWidth, self.emailTxtField.frame.size.width, self.emailTxtField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.emailTxtField.layer addSublayer:border];
    self.emailTxtField.layer.masksToBounds = YES;
    [self.emailTxtField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor whiteColor].CGColor;
    border2.frame = CGRectMake(0, self.passTextField.frame.size.height - borderWidth, self.passTextField.frame.size.width, self.passTextField.frame.size.height);
    border2.borderWidth = borderWidth;
    [self.passTextField.layer addSublayer:border2];
    self.passTextField.layer.masksToBounds = YES;
    [self.passTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    self.loginBtn.layer.cornerRadius = 17.0;
    self.loginBtn.layer.borderWidth = 2.0;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 1;
    border3.borderColor = [UIColor whiteColor].CGColor;
    border3.frame = CGRectMake(0, self.signUpBtn.frame.size.height - borderWidth3, self.signUpBtn.frame.size.width, self.signUpBtn.frame.size.height);
    border3.borderWidth = borderWidth3;
    [self.signUpBtn.layer addSublayer:border3];
    self.signUpBtn.layer.masksToBounds = YES;
    
}*/

-(void) checkIfUserIsLoggedIn{
    [[BlickbeeAppManager sharedInstance] readUserDataFromArchiver];
    User *user = [BlickbeeAppManager sharedInstance].user;
   
   /* UserInfoServiceClient *userClient = [[UserInfoServiceClient alloc] init];
    [userClient checkIfOtpVerified:^{
        // NSLog(@"%ld getcustomerinfo called",(long)[BlickbeeAppManager sharedInstance].isOtpVerified);
    } failure:^(NSError *error) {
        
    }];*/
   
    // NSLog(@"%ld getcustomerinfo called",(long)[BlickbeeAppManager sharedInstance].isOtpVerified);

    
    if (user && ![user.userId isEqualToString:@""]) {
       // NSLog(@"%@ USER",user.userId);
        //NSLog(@"%@ OTP STATUS", user.otpStatus);
       // if([user.otpStatus isEqualToString:@"1"]){
    //     if([user.otpStatus isEqualToString:@"1"] || [BlickbeeAppManager sharedInstance].otpVerified == 1){
   
            UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            //            [self presentViewController:cont animated:YES completion:^{
            //
            //            }];
            [self.navigationController pushViewController:cont animated:NO];
         }
      /*  else {
            
            UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //            SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            OTPViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"OTPViewController"];
            cont.isFromSignUp=YES;
            cont.user=user;
            [self.navigationController pushViewController:cont animated:YES];
            
            
           */
            
        //}
        
        
        /*
        UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        //            [self presentViewController:cont animated:YES completion:^{
        //
        //            }];
        [self.navigationController pushViewController:cont animated:NO];
         */
    //}
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
