//
//  LoginDetailsViewController.m
//  BlickBee
//
//  Created by Apurv Gupta on 23/02/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "LoginDetailsViewController.h"
#import "LoginServiceClient.h"
#import "User.h"

@interface LoginDetailsViewController ()

@end

@implementation LoginDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.emailTextField.delegate = self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self prepareView];
    // Your layout logic here
}



-(void) prepareView{
    UIColor *color = [UIColor whiteColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: color};
    NSAttributedString *attributedPlaceholderString = [[NSAttributedString alloc] initWithString:@"Enter your Name" attributes:attributes];
    NSAttributedString *attributedPlaceholderString1 = [[NSAttributedString alloc] initWithString:@"Enter your Email" attributes:attributes];
    self.emailTextField.attributedPlaceholder = attributedPlaceholderString1;
    self.nameTextField.attributedPlaceholder = attributedPlaceholderString;

}



- (IBAction)proceedButton {
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }

    if (![self.emailTextField.text isEqualToString:@""] && ![self NSStringIsValidEmail:self.emailTextField.text]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email address." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    

    
    LoginServiceClient *client = [[LoginServiceClient alloc] init];
    NSMutableDictionary *credentialsDict = [[NSMutableDictionary alloc] init];
    //[credentialsDict setObject:self.emailTextField.text forKey:@"email"];
    //[credentialsDict setObject:self.passwordTextField.text forKey:@"password"];
   // if ([[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]) {
     //   [credentialsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"] forKey:@"access_token"];
   // }
    //else{
      //  [credentialsDict setObject:@"kjhskjhaskjhasdkjsahk" forKey:@"access_token"];
    //}
    [credentialsDict setObject:self.emailTextField.text forKey:@"email"];
    [credentialsDict setObject:self.nameTextField.text forKey:@"name"];
    //[credentialsDict setObject:user.user_id.text forKey:@"user_id"];
    
    //if ([[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"]) {
     //   [credentialsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"devicetoken"] forKey:@"device_id"];
    //}
    //else{
      //  [credentialsDict setObject:@"kjhskjhaskjhasdkjsahk" forKey:@"device_id"];
    //}
    
    [client signUpWithDictionary:credentialsDict WithSuccess:^(User *user) {
        
        if (user.userId && ![user.userId isEqualToString:@""]) {
            
            [[BlickbeeAppManager sharedInstance] userLoginSuccessfulWith:user];
            UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        SWRevealViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            //OTPViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"OTPViewController"];
            //cont.isFromSignUp=YES;
            //cont.user=user;
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
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}



@end

