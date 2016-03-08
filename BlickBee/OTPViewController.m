//
//  OTPViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/29/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "OTPViewController.h"
#import "LoginServiceClient.h"
#import "SWRevealViewController.h"
#import "ChangePasswordViewController.h"
#import "BlickbeeAppManager.h"
@interface OTPViewController ()
{
    NSInteger count;
}
@end

@implementation OTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count=60;
    self.resendOTPBtn.userInteractionEnabled=NO;
    self.progressUpdateTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
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
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
    self.topSpaceConstraint.constant=-100;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

-(void)keyboardWillHide {
    self.topSpaceConstraint.constant=32;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
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

- (IBAction)verifyBtnPressed:(id)sender {
    
    
    
    if ([self.otpTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the otp." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    NSString *otpStr = self.otpTextField.text;

    if (self.user && ![self.user.name isEqualToString:@""]) {
        
        NSString *dummyUser = self.user.name;
        dummyUser=[dummyUser stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        BOOL matchedUser = NO;
        
        if ([dummyUser rangeOfString:@"test123" options:NSCaseInsensitiveSearch].location == NSNotFound)
        {
            //not dummy user
            matchedUser=NO;
        }
        else
        {
            //dummy user
            matchedUser=YES;
        }
        
        
        if (matchedUser && ![self.user.otpRequest isEqualToString:@""]) {
            otpStr= self.user.otpRequest;
        }
    }
    
   /* if (self.isForgotPassword) {
        
        if (![self.clientSideOtp isEqualToString:@""]) {
            if ([otpStr isEqualToString:self.clientSideOtp]) {
                UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ChangePasswordViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                cont.phone=self.phone;
                cont.isForgotPassword=YES;
                //            [self presentViewController:cont animated:YES completion:^{
                //            }];
                [self.navigationController pushViewController:cont animated:YES];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"The one time password does not match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
            }
            
        }
    }*/
    //else{
        LoginServiceClient *client = [[LoginServiceClient alloc] init];
        

        
        [client verifyOTPWithOTP:otpStr WithSuccess:^(User *user) {
           if (user.userId && ![user.userId isEqualToString:@""]) {
            
            [[BlickbeeAppManager sharedInstance] userLoginSuccessfulWith:user];
            UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         //   [[BlickbeeAppManager sharedInstance] setOtpVerified:1];
            //NSLog(@"%@ After OTP",user.otpStatus);
           // if(self.isFromSignUp){

                    SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"LoginDetailsViewController"];
                    //            [self presentViewController:cont animated:YES completion:^{
                    //
                    //            }];
                    [self.navigationController pushViewController:cont animated:YES];
             //   }
               // else{
                  //  ChangePasswordViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                    //            [self presentViewController:cont animated:YES completion:^{
                    //            }];
                   // [self.navigationController pushViewController:cont animated:YES];
                //}
           }
        } failure:^(NSError *error) {
            
        }];
        
    //}
}
-(void) updateProgress:(NSTimer *)updatedTimer{
    if (count>0) {
        [self.resendOTPBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
        [self.resendOTPBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateHighlighted];
        self.resendOTPBtn.userInteractionEnabled=NO;
        count--;
    }
    else{
        [self.resendOTPBtn setTitle:@"Resend OTP" forState:UIControlStateNormal];
        [self.resendOTPBtn setTitle:@"Resend OTP" forState:UIControlStateHighlighted];
        self.resendOTPBtn.userInteractionEnabled=YES;
        [self.progressUpdateTimer invalidate];
        self.progressUpdateTimer=nil;
    }
}

- (IBAction)resendOtp:(id)sender {
    LoginServiceClient *client = [[LoginServiceClient alloc] init];
    [client resendOTPWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
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
    border.frame = CGRectMake(0, self.otpTextField.frame.size.height - borderWidth, self.otpTextField.frame.size.width, self.otpTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.otpTextField.layer addSublayer:border];
    self.otpTextField.layer.masksToBounds = YES;
    
    self.verifyOTPBtn.layer.cornerRadius = 17.0;
    self.verifyOTPBtn.layer.borderWidth = 2.0;
    self.verifyOTPBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.resendOTPBtn.layer.cornerRadius = 17.0;
    self.resendOTPBtn.layer.borderWidth = 2.0;
    self.resendOTPBtn.layer.borderColor = [UIColor whiteColor].CGColor;

    
    [self.otpTextField becomeFirstResponder];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
