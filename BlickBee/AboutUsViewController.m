//
//  AboutUsViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/29/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AboutUsViewController.h"
#import "PrivacyPolicyandTermsViewController.h"

@interface AboutUsViewController (){
    
}

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelForParagraphTwo.backgroundColor=[UIColor clearColor];
    self.labelForAboutUs.backgroundColor=[UIColor clearColor];
    self.labelForAboutUs.text=@"Farming sector in India is highly unorganized lives of the most of the farmer remains vulnerable because of irregular income and uncertainty of production. On the other hand, we have the consumers who always aspire for the best quality production of the fair prices.";
    self.labelForAboutUs.textAlignment=NSTextAlignmentJustified;
    self.labelForAboutUs.lineBreakMode=NSLineBreakByWordWrapping;
    self.labelForAboutUs.numberOfLines=0;
    self.labelForParagraphTwo.text=@"BlickBee is the aspiration of the young enthusiastic minds to bridge this gap by addressing issues at the producers and consumers by stringent quality control and effective supply chain.";
    self.labelForParagraphTwo.lineBreakMode=NSLineBreakByWordWrapping;
    self.labelForParagraphTwo.numberOfLines=0;
    SWRevealViewController *swRevealVC = self.revealViewController;
    if(swRevealVC){
        UIImage *image =[UIImage imageNamed:@"menu.png"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, image.size.width-40, image.size.height-40);
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
        [btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:image forState:UIControlStateNormal];
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = menuButton;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        self.revealViewController.panGestureRecognizer.delegate=self;
        self.navigationController.navigationBar.barTintColor=RGBA(246, 71, 17, 1);
        [self.navigationItem.leftBarButtonItem setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        //swRevealVC.rearViewRevealWidth=270.0f;
        [swRevealVC revealToggleAnimated:YES];
        [self.termsAndConditonButtonClicked setTitle:@"Terms & Conditions" forState:UIControlStateNormal];
        [self.privacyPolicyButtonClicked setTitle:@"Privacy Policy" forState:UIControlStateNormal];
    }
    self.title=@"About Us";
    [self.view setBackgroundColor:RGBA(234, 234, 234, 1)];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)privacyPolicyButtonClicked:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PrivacyPolicyandTermsViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"PrivacyPolicyandTermsViewController"];
    vc.url=[NSURL URLWithString:@"http://www.blickbee.com/privacy/"];
    vc.title=@"Privacy Policy";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (IBAction)termsAndConditionButtonClicked:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PrivacyPolicyandTermsViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"PrivacyPolicyandTermsViewController"];
    vc.url=[NSURL URLWithString:@"http://www.blickbee.com/terms/"];
    vc.title=@"Terms And Condition";
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
