//
//  ForgotPasswordViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 12/28/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "LoginServiceClient.h"
#import "OTPViewController.h"
@interface ForgotPasswordViewController () <UITextFieldDelegate>

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self prepareView];
    // Your layout logic here
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
    self.topConstraint.constant=-150;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

-(void)keyboardWillHide {
    self.topConstraint.constant=20;
    [self.view layoutSubviews];
    [self.view layoutIfNeeded];
}

-(void) prepareView{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, self.phoneTextField.frame.size.height - borderWidth, self.phoneTextField.frame.size.width, self.phoneTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.phoneTextField.layer addSublayer:border];
    self.phoneTextField.layer.masksToBounds = YES;
    
    self.nextBtn.layer.cornerRadius = 17.0;
    self.nextBtn.layer.borderWidth = 2.0;
    self.nextBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)nextBtnPressed:(id)sender {
    if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text.length>10) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid phone number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    LoginServiceClient *client = [[LoginServiceClient alloc] init];
    [client resendOTPWithPhone:self.phoneTextField.text andSuccess:^(NSString *otp) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OTPViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"OTPViewController"];
        cont.clientSideOtp=otp;
        cont.isForgotPassword=YES;
        cont.phone=self.phoneTextField.text;
        [self.navigationController pushViewController:cont animated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}

- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
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
