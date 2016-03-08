//
//  AboutUsViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/29/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AboutUsViewController : BaseViewController
- (IBAction)privacyPolicyButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicyButtonClicked;
@property (weak, nonatomic) IBOutlet UIButton *termsAndConditonButtonClicked;
- (IBAction)termsAndConditionButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelForAboutUs;
@property (weak, nonatomic) IBOutlet UILabel *labelForParagraphTwo;

@end
