//
//  OrdersDetailTableView.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "OrdersDetailTableView.h"
#import "OrdersDetailTableViewCell.h"
#import "FirstOrderDetailCell.h"

@implementation OrdersDetailTableView

-(id) initWithFrame:(CGRect)frame andOrder:(Order*) order{
    self = [super initWithFrame:frame];
    if (self) {
        self.order=order;
        self.dataSource=self;
        self.delegate=self;
        [self registerNib:[UINib nibWithNibName:@"OrdersDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrdersDetailTableViewCell"];
        self.backgroundColor=RGBA(0, 0, 255, 1);
        if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
            self.contentInset = UIEdgeInsetsMake(64,0,0,0);
        }
    }
    return self;
}

- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return self.order.orderedProducts.count + 1;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    OrdersDetailTableViewCell *cell = (OrdersDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OrdersDetailTableViewCell"];
    if(cell==nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrdersDetailTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setBackgroundColor:RGBA(225, 225, 225, 1)];
    if(indexPath.row-1>=0){
    [cell bindDataWithProduct:[self.order.orderedProducts objectAtIndex:indexPath.row-1]];
    }
    if(indexPath.row==0){
        FirstOrderDetailCell *firstOrderDetailCell = (FirstOrderDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"FirstOrderDetailCell"];
        if(firstOrderDetailCell==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FirstOrderDetailCell" owner:self options:nil];
            firstOrderDetailCell = [nib objectAtIndex:0];
        }
        [firstOrderDetailCell setBackgroundColor:RGBA(225, 225, 225, 1)];
        [firstOrderDetailCell bindData:self.order];
        return  firstOrderDetailCell;
    }
    return cell;
}

-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 130;
    }
    return 110;
}

@end
