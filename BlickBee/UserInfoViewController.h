//
//  UserInfoViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 12/27/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "BaseViewController.h"

@interface UserInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *labelForEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelForMobNumb;
- (IBAction)updateButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textForName;
@property (weak, nonatomic) IBOutlet UIImageView *imageForProfilePic;
@property (strong,nonatomic) User *user;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceConstraint;
@end
