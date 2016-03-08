//
//  MyOrdersTableView.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/23/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "MyOrdersTableView.h"
#import "MyOrdersTableViewCell.h"

@implementation MyOrdersTableView

-(id) initWithFrame:(CGRect)frame andOrdersArray:(NSMutableArray*) ordersArray{
    self.myOrdersArray=ordersArray;
    self.dataSource=self;
    self.delegate=self;
    [self registerNib:[UINib nibWithNibName:@"MyOrdersTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyOrdersTableViewCell"];
    if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
        self.contentInset = UIEdgeInsetsMake(64,0,0,0);
    }

    return [self initWithFrame:frame];
}

- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return self.myOrdersArray.count;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    MyOrdersTableViewCell *cell = (MyOrdersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyOrdersTableViewCell"];
    if(cell==nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyOrdersTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //[cell setBackgroundColor:RGBA(225, 225, 225, 1)];
    [cell bindData:[self.myOrdersArray objectAtIndex:indexPath.row]];
    cell.launchOrderDetailVCDelegate=self.parentVC;
    return cell;
}

-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


@end
