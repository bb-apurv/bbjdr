//
//  PrivacyPolicyandTermsViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/29/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "PrivacyPolicyandTermsViewController.h"

@interface PrivacyPolicyandTermsViewController ()

@end

@implementation PrivacyPolicyandTermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    [self.webViewForPrivacyPolicy loadRequest:request];
    self.webViewForPrivacyPolicy.scalesPageToFit=YES;
    self.webViewForPrivacyPolicy.backgroundColor=[UIColor clearColor];
    self.webViewForPrivacyPolicy.opaque=NO;
    self.title=self.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
