//
//  AddressConfirmationViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AddressConfirmationViewController.h"
#import "DeliveryDetailTableViewCell.h"
#import "AddressConfirmationTableViewCell.h"
#import "DeliveryAddressTableViewCell.h"
#import "OrderServiceClient.h"
#import "Order.h"
#import "OrderConfirmationViewController.h"
#import "PromoCodeTableViewCell.h"
#import "Promo.h"


@interface AddressConfirmationViewController ()<reloadTableCell,UITableViewDataSource,UITableViewDelegate>{
}

@end

@implementation AddressConfirmationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.addressConfirmationTableView registerNib:[UINib nibWithNibName:@"DeliveryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeliveryDetailTableViewCell"];
    
        [self.addressConfirmationTableView registerNib:[UINib nibWithNibName:@"DeliveryAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeliveryAddressTableViewCell"];
    [self.addressConfirmationTableView registerNib:[UINib nibWithNibName:@"AddressConfirmationTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressConfirmationTableViewCell"];
    
    //Register PromoCode nib
    [self.addressConfirmationTableView registerNib:[UINib nibWithNibName:@"PromoCodeTableViewCell" bundle:nil] forCellReuseIdentifier:@"PromoCodeTableViewCell"];
    
    [self.view setBackgroundColor:RGBA(225, 225, 225, 1)];
    [self.addressConfirmationTableView setBackgroundColor:RGBA(225, 225, 225, 1)];
    [self.addressConfirmationTableView setSeparatorColor:[UIColor clearColor]];
    UIImage *image =[UIImage imageNamed:@"back.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(-30, 0, image.size.width-40, image.size.height-40);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
    //[btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(moveBack) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = menuButton;
    self.title = @"Order Confirmation";
    [BlickbeeAppManager sharedInstance].promoApplied =0;
    

}

-(void) moveBack{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void) applyClicked{
    //NSInteger row = [self.productArray indexOfObject:product];
    //Promo *prom = promo;
    
    NSRange range = NSMakeRange(2, 1);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    
    [self.addressConfirmationTableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];

        //[self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
    }

/*-(void) applyToApplied{
    //NSInteger row = [self.productArray indexOfObject:product];
    //Promo *prom = promo;
    
    NSRange range = NSMakeRange(1, 1);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    
    [self.addressConfirmationTableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    
    //[self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
}*/


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}


- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 4;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return 1;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
   DeliveryDetailTableViewCell *cell = (DeliveryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DeliveryDetailTableViewCell"];
    if(cell==nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryDetailTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor=RGBA(225, 225, 225, 1);
    cell.imageViewFordeliveryDetail.image=[UIImage imageNamed:@"2.png"];
   // [cell.imageViewFordeliveryDetail sizeToFit];
    
    if(indexPath.section==1){
        PromoCodeTableViewCell *cellPromo = (PromoCodeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PromoCodeTableViewCell"];
        if(cellPromo==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PromoCodeTableViewCell" owner:self options:nil];
            cellPromo = [nib objectAtIndex:0];
        }
        cellPromo.reloadTableCellDelegate = self;
        cellPromo.backgroundColor=RGBA(225, 225, 225, 1);
        
       
       // [self.addressConfirmationTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

      //  cellPromo.buttonTapAction = ^(id sender){
         //   NSLog(@"%@",promo.discount);

            //NSLog(@"Apply Pressed");//Do what you want to do when the button inside THIS cell is clicked
        //};
        return cellPromo;
    }
    
    
    else if(indexPath.section==2){
        AddressConfirmationTableViewCell *cellOne = (AddressConfirmationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AddressConfirmationTableViewCell"];
        if(cellOne==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddressConfirmationTableViewCell" owner:self options:nil];
            cellOne = [nib objectAtIndex:0];
        }
        cellOne.backgroundColor=RGBA(225, 225, 225, 1);
        if ([BlickbeeAppManager sharedInstance].promoApplied == 0){
            [cellOne bindDataForOrder];
        }
        else if ([BlickbeeAppManager sharedInstance].promoApplied == 1){
            [cellOne updateTotalAmountByPromo];
            
        }
        return cellOne;
    }
    else if (indexPath.section==3){
        DeliveryAddressTableViewCell *cellTwo = (DeliveryAddressTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"DeliveryAddressTableViewCell"];
        if(cellTwo==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryAddressTableViewCell" owner:self options:nil];
            cellTwo = [nib objectAtIndex:0];
        }
        cellTwo.itemAddress=self.address;
        [cellTwo bindData:self.address];
        cellTwo.backgroundColor=RGBA(225, 225, 225, 1);
        [cellTwo.editButtonClicked setHidden:YES];
        [cellTwo.removeButtonClicked setHidden:YES];
        return cellTwo;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    if(section ==1||section==3||section==2){
        return 30;
    }
    
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 78;
    }
    if(indexPath.section==1){
        return 39;
    }
    if(indexPath.section==2){
        return 120;
    }
    return 120;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 35)];
    if(section == 1){
        [label setText:@"Promo Code"];

    } else if(section==2){
        [label setText:@"Order Summary"];
    }
    else if(section ==3){
        [label setText:@"Delivery Address"];
    }
    [view addSubview:label];
    //    [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, view.frame.size.height-3, tableView.frame.size.width-20, 1)];
    [imgView setBackgroundColor:[UIColor lightGrayColor]];
    [view addSubview:imgView];
    view.backgroundColor=RGBA(225, 225, 225, 1);
    return view;
}

/*- (void)updateCell:(UIView *)cell {
    NSParameterAssert(cell);
    
   // NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)cell];
    if (cell) {
        //self.values[indexPath.row] = value;
        [self.addressConfirmationTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }
}*/

- (IBAction)confirmOrderClicked:(id)sender {
    OrderServiceClient *client = [[OrderServiceClient alloc] init];
    if ([BlickbeeAppManager sharedInstance].userAddresses.count>0) {
        [client makeOrderWithProductArray:[BlickbeeAppManager sharedInstance].selectedProducts andAddress:self.address WithSuccess:^(Order *order) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OrderConfirmationViewController *orderConfirmationVC = [storyBoard instantiateViewControllerWithIdentifier:@"OrderConfirmationViewController"];
            orderConfirmationVC.orderItem=order;
            [self.navigationController pushViewController:orderConfirmationVC animated:YES];
        } failure:^(NSError *error) {
        }];
    }
    
}
@end
