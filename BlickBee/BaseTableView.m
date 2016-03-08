//
//  BaseTableView.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/9/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseTableView.h"
#import "BaseTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "BlickbeePrefix.pch"
#import "Product.h"
#import "AddToCartTableViewCell.h"
#import "BlickbeeAppManager.h"

@interface BaseTableView() <reloadTable,productProtocolDelegate>{
    
}
@end

@implementation BaseTableView{
    NSMutableArray *indexPathArray;
}

-(id) initWithFrame:(CGRect)frame andProductsArray:(NSMutableArray*) prodsArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.productArray=prodsArray;
        self.dataSource=self;
        self.delegate=self;
        [self registerNib:[UINib nibWithNibName:@"BaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseTableViewCell"];
        self.backgroundColor=RGBA(0, 0, 255, 1);
        indexPathArray = [[NSMutableArray alloc]init];
        if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
            self.contentInset = UIEdgeInsetsMake(64,0,0,0);
        }
        return self;
    }
    return nil;
}

-(void) productRecievedFromCell: (Product*) product{
    NSInteger row = [self.productArray indexOfObject:product];
    if (row>=0 && row<self.productArray.count) {
        [self.changeFlotingBtnDelegate changeValOfFloatingBtn];
        [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
//    self.indexpth = [NSIndexPath indexPathForRow:row inSection:0];
//    [indexPathArray addObject:self.indexpth];
}

-(void) addClicked:(Product *) product{
    NSInteger row = [self.productArray indexOfObject:product];
    if (row>=0 && row<self.productArray.count) {
        product.selectedProductQuantity=[NSString stringWithFormat:@"%ld",(long)([product.selectedProductQuantity integerValue]+1)];
        [self.changeFlotingBtnDelegate changeValOfFloatingBtn];
        [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void) subtractClicked:(Product *) product{
    NSInteger row = [self.productArray indexOfObject:product];
    if (row>=0 && row<self.productArray.count) {
        if(![product.selectedProductQuantity isEqualToString:@"0"]){
        product.selectedProductQuantity=[NSString stringWithFormat:@"%ld",(long)([product.selectedProductQuantity integerValue]-1)];
        [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            if([product.selectedProductQuantity isEqualToString:@"0"]){
                [[BlickbeeAppManager sharedInstance].selectedProducts removeObject:product];
            }
        }
    }
    [self.changeFlotingBtnDelegate changeValOfFloatingBtn];
}



- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return self.productArray.count+1;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    
    //productqaty >0 - addtocart
    //else - bAsetableviewcell
    
    if (indexPath.row==self.productArray.count) {
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.backgroundColor = RGBA(225, 225, 225, 1);
        return cell;
    }
    Product *product = [self.productArray objectAtIndex:indexPath.row];
    if([product.selectedProductQuantity isEqualToString:@"0"]){

        BaseTableViewCell *cell= (BaseTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"BaseTableViewCell"];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BaseTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.productDelegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell bindData:product];
        return cell;
    }
    else{
        AddToCartTableViewCell *coverCell = (AddToCartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddToCartTableViewCell"];
        if(coverCell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddToCartTableViewCell" owner:self options:nil];
            coverCell = [nib objectAtIndex:0];
        }
        coverCell.reloadTableCellDelegate=self;
        [coverCell bindData:[self.productArray objectAtIndex:indexPath.row] andQuantityAdded:product.selectedProductQuantity];
        coverCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return coverCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

@end
