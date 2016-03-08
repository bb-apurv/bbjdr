//
//  AccountSettingsViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/28/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AccountSettingsViewController.h"
#import "AddAddressTableViewCell.h"
#import "DeliveryAddressTableViewCell.h"
#import "OTPViewController.h"
#import "LoginServiceClient.h"
#import "AddAddressViewController.h"
@interface AccountSettingsViewController ()<openAddressPopUp,addressUpdated,editBtnClicked>

@end

@implementation AccountSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.accountSettingsTableView registerNib:[UINib nibWithNibName:@"DeliveryAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeliveryAddressTableViewCell"];
    [self.accountSettingsTableView registerNib:[UINib nibWithNibName:@"AddAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddAddressTableViewCell"];
    self.title=@"Account Settings";
    SWRevealViewController *swRevealVC = self.revealViewController;
    if(swRevealVC){
        UIImage *image =[UIImage imageNamed:@"menu.png"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, image.size.width-40, image.size.height-40);
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
        [btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:image forState:UIControlStateNormal];
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
        //        [self.navigationItem.leftBarButtonItem setTarget: self.revealViewController];
        //        [self.navigationItem.leftBarButtonItem setAction: @selector( revealToggle: )];
        self.navigationItem.leftBarButtonItem = menuButton;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        self.revealViewController.panGestureRecognizer.delegate=self;
        self.navigationController.navigationBar.barTintColor=RGBA(246, 71, 17, 1);
        [self.navigationItem.leftBarButtonItem setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        //swRevealVC.rearViewRevealWidth=270.0f;
        //[swRevealVC revealToggle:self];
        [swRevealVC revealToggleAnimated:YES];
    }
    self.title=@"My Addresses";
    [self.view setBackgroundColor:RGBA(225, 225, 225, 1)];
    [self.accountSettingsTableView setBackgroundColor:RGBA(225, 225, 225, 1)];

    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        if ([BlickbeeAppManager sharedInstance].userAddresses.count==2) {
            return [BlickbeeAppManager sharedInstance].userAddresses.count;
        }
        else if ([BlickbeeAppManager sharedInstance].userAddresses.count==0) {
            return 2;
        }
        else{
            return [BlickbeeAppManager sharedInstance].userAddresses.count+1;
        }
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section==0) {
        if ([BlickbeeAppManager sharedInstance].userAddresses.count==0) {
            if(indexPath.row==0){
                cell = (AddAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ShowWhenAddressEmptyTableViewCell"];
                if(cell==nil){
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShowWhenAddressEmptyTableViewCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    
                }
                [cell setBackgroundColor:RGBA(225, 225, 225, 1)];

                return cell;
            }
            
                else{
            cell = (AddAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddAddressTableViewCell"];
            if(cell==nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddAddressTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }}
            ((AddAddressTableViewCell *)cell).addressDelegate=self;
        }
        else if ([BlickbeeAppManager sharedInstance].userAddresses.count==1) {
            if (indexPath.row==0){
                cell = (DeliveryAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DeliveryAddressTableViewCell"];
                if(cell==nil){
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryAddressTableViewCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                ((DeliveryAddressTableViewCell *)cell).editBtnDelegate=self;
                
                [((DeliveryAddressTableViewCell*)cell) bindData:[[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]];
            }
            else if (indexPath.row==1){
                cell = (AddAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddAddressTableViewCell"];
                if(cell==nil){
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddAddressTableViewCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                ((AddAddressTableViewCell *)cell).addressDelegate=self;
            }
        }
        else if ([BlickbeeAppManager sharedInstance].userAddresses.count==2) {
            cell = (DeliveryAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DeliveryAddressTableViewCell"];
            if(cell==nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryAddressTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            ((DeliveryAddressTableViewCell *)cell).editBtnDelegate=self;
            [((DeliveryAddressTableViewCell*)cell) bindData:[[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]];
        }
    }
    else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
       /* UIButton *changePasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        [changePasswordBtn setTitle:@"Change Password" forState:UIControlStateNormal];
        [changePasswordBtn setTitle:@"Change Password" forState:UIControlStateHighlighted];
        [changePasswordBtn addTarget:self action:@selector(changePasswordPressed) forControlEvents:UIControlEventTouchUpInside];
        [changePasswordBtn setTitleColor:RGBA(252, 95, 16, 1) forState:UIControlStateNormal];
        [changePasswordBtn setTitleColor:RGBA(252, 95, 16, 1) forState:UIControlStateHighlighted];

        [cell addSubview:changePasswordBtn];*/
        [cell setBackgroundColor:RGBA(225, 225, 225, 1)];

        return cell;
    }
    [cell setBackgroundColor:RGBA(225, 225, 225, 1)];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section==0){
        if ([BlickbeeAppManager sharedInstance].userAddresses.count==0) {
            if (indexPath.row==0){
                return 300;
            }
            else{
                return 70;
            }
            

        }
        else if ([BlickbeeAppManager sharedInstance].userAddresses.count==1) {
            if (indexPath.row==0){
                return 130;
            }
            else{
                return 70;
            }
        }
        else if ([BlickbeeAppManager sharedInstance].userAddresses.count==2) {
            return 130;
        }
    }
    return 44;
}

-(void) changePasswordPressed{
    
    LoginServiceClient *client = [[LoginServiceClient alloc] init];
    [client resendOTPWithSuccess:^{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OTPViewController *cont = [storyBoard instantiateViewControllerWithIdentifier:@"OTPViewController"];
        cont.isFromSignUp=NO;
        [self.navigationController pushViewController:cont animated:YES];
//        [self presentViewController:cont animated:YES completion:^{
//            
//        }];
    } failure:^(NSError *error) {
        
    }];
}

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];*/
    /* Create custom view to display section header... */
  //  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 35)];
    //[label setText:@"Addresses :"];
   // [view addSubview:label];
//    //    [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, view.frame.size.height-3, tableView.frame.size.width-20, 1)];
//    [imgView setBackgroundColor:[UIColor lightGrayColor]];
//    [view addSubview:imgView];
//    view.backgroundColor=RGBA(225, 225, 225, 1);
    //view.backgroundColor = [UIColor whiteColor];
    //return view;
    
//}

-(void) openAddressPopUp{
    AddAddressViewController *cont = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil andPreviouslySelectedAddress:nil];
    cont.addressDelegate=self;
    UINavigationController *navcont = [[UINavigationController alloc] initWithRootViewController:cont];
    [self.navigationController presentViewController:navcont animated:YES completion:^{
        
    }];
}
-(void) addressUpdated{
    [self.accountSettingsTableView reloadData];
}

-(void) editBtnClickedWith:(Address*)prevAddress{
    AddAddressViewController *cont = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil andPreviouslySelectedAddress:prevAddress];
    cont.addressDelegate=self;
    UINavigationController *navcont = [[UINavigationController alloc] initWithRootViewController:cont];
    [self.navigationController presentViewController:navcont animated:YES completion:^{
        
    }];
}

-(void) removeBtnClicked{
    [self.accountSettingsTableView reloadData];
}


-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    if(section == 0 ){
        return  0;
    }
    return 0;
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
