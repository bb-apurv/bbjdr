//
//  AccountSettingsViewController.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/28/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
@interface AccountSettingsViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *accountSettingsTableView;

@end
