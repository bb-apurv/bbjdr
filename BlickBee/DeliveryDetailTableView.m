//
//  DeliveryDetailTableView.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/19/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "DeliveryDetailTableView.h"

@interface DeliveryDetailTableView(){
    BOOL addressCellOneColor;
    BOOL addressCellTwoColor;
}

@end

@implementation DeliveryDetailTableView

-(id) initWithFrames:(CGRect)frame{
    
    self.dataSource=self;
    self.delegate=self;
    [self registerNib:[UINib nibWithNibName:@"DeliveryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeliveryDetailTableViewCell"];
    [self registerNib:[UINib nibWithNibName:@"DeliveryTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeliveryTimeTableViewCell"];
    [self registerNib:[UINib nibWithNibName:@"AddAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddAddressTableViewCell"];
    self.backgroundColor=RGBA(225, 225, 225, 1);
    addressCellOneColor=YES;
    return [self initWithFrame:frame];
}

- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 2;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    if(section==1){
        if ([BlickbeeAppManager sharedInstance].userAddresses.count==2) {
            return [BlickbeeAppManager sharedInstance].userAddresses.count;
        }
        else{
            return [BlickbeeAppManager sharedInstance].userAddresses.count+1;
        }
    }
    return 2;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    UITableViewCell *cell;
    if(indexPath.row==0 && indexPath.section==0){
      DeliveryDetailTableViewCell  *cellOne = (DeliveryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DeliveryDetailTableViewCell"];
        if(cellOne==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryDetailTableViewCell" owner:self options:nil];
            cellOne = [nib objectAtIndex:0];
        }
        cellOne.imageViewFordeliveryDetail.image=[UIImage imageNamed:@"1.png"];
        [cellOne setBackgroundColor:RGBA(225, 225, 225, 1)];
        return  cellOne;
    }
    else if(indexPath.row==1 && indexPath.section==0){
        cell = (DeliveryTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DeliveryTimeTableViewCell"];
        if(cell==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryTimeTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    }
    if (indexPath.section==1){
        if ([BlickbeeAppManager sharedInstance].userAddresses.count==0) {
            cell = (AddAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddAddressTableViewCell"];
            if(cell==nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddAddressTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
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
                [((DeliveryAddressTableViewCell *)cell).nameLabel setTextColor:RGBA(246, 71, 17, 1)];
                [((DeliveryAddressTableViewCell *)cell).phoneLabel setTextColor:RGBA(246, 71, 17, 1)];
                [((DeliveryAddressTableViewCell *)cell).address1Label setTextColor:RGBA(246, 71, 17, 1)];
                [((DeliveryAddressTableViewCell *)cell).address2Label setTextColor:RGBA(246, 71, 17, 1)];
            }
            else{
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
            [((DeliveryAddressTableViewCell *)cell).nameLabel setTextColor:[UIColor blackColor]];
            [((DeliveryAddressTableViewCell *)cell).phoneLabel setTextColor:[UIColor blackColor]];
            [((DeliveryAddressTableViewCell *)cell).address1Label setTextColor:[UIColor blackColor]];
            [((DeliveryAddressTableViewCell *)cell).address2Label setTextColor:[UIColor blackColor]];
            
            if(addressCellOneColor==YES && indexPath.row==0){
                [((DeliveryAddressTableViewCell *)cell).nameLabel setTextColor:RGBA(238, 77, 28, 1)];
                [((DeliveryAddressTableViewCell *)cell).phoneLabel setTextColor:RGBA(238, 77, 28, 1)];
                [((DeliveryAddressTableViewCell *)cell).address1Label setTextColor:RGBA(238, 77, 28, 1)];
                [((DeliveryAddressTableViewCell *)cell).address2Label setTextColor:RGBA(238, 77, 28, 1)];
            }
            if(indexPath.row==1 && addressCellTwoColor==YES){
                [((DeliveryAddressTableViewCell *)cell).nameLabel setTextColor:RGBA(238, 77, 28, 1)];
                [((DeliveryAddressTableViewCell *)cell).phoneLabel setTextColor:RGBA(238, 77, 28, 1)];
                [((DeliveryAddressTableViewCell *)cell).address1Label setTextColor:RGBA(238, 77, 28, 1)];
                [((DeliveryAddressTableViewCell *)cell).address2Label setTextColor:RGBA(238, 77, 28, 1)];
            }
            
        }
        [cell setBackgroundColor:RGBA(225, 225, 225, 1)];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *header=@"Select Delivery Address :";
//    return header;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 35)];
    [label setText:@"Select Delivery Address :"];
    [view addSubview:label];
//    [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, view.frame.size.height-3, tableView.frame.size.width-20, 1)];
    [imgView setBackgroundColor:[UIColor lightGrayColor]];
    [view addSubview:imgView];
    view.backgroundColor=RGBA(225, 225, 225, 1);
    return view;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([BlickbeeAppManager sharedInstance].userAddresses.count==0 || [BlickbeeAppManager sharedInstance].userAddresses.count==1){
        if(indexPath.row == [BlickbeeAppManager sharedInstance].userAddresses.count){
            return nil;
        }
    
    } else{
        
        return indexPath;
    }
    return indexPath;

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    addressCellOneColor=NO;
    addressCellTwoColor=NO;
    if(indexPath.section==1){
        if(indexPath.row==0){
            if([[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]){
                [self.addressrecievedDelegate addressRecived:[[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]];
            NSLog(@"%@",[[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]);
                addressCellOneColor=YES;
                [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
           // if([BlickbeeAppManager sharedInstance].userAddresses.count ==2){
            [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                }
        }
        else if(indexPath.row==1){
           // NSLog(@"%@",[[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]);

            if([[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]){
                [self.addressrecievedDelegate addressRecived:[[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:indexPath.row]];
            }
                addressCellTwoColor=YES;
                                [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            }
    }
    [self reloadData];
}

-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    if(section==1){
        return 35;
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==1&&indexPath.section==0){
        return 70;
    }
    if(indexPath.section==1){
            if ([BlickbeeAppManager sharedInstance].userAddresses.count==0) {
                return 85;
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
    return 90;
}
-(void) openAddressPopUp{
    [self.addressDelegate openNewAddress];
}
-(void) editBtnClickedWith:(Address*)address{
    [self.addressDelegate editAddressWithPrevAddress:address];
}
-(void) removeBtnClicked{
    [self reloadData];
}


@end
