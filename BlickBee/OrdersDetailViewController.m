//
//  OrdersDetailViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "OrdersDetailViewController.h"
#import "OrdersDetailTableView.h"

@interface OrdersDetailViewController (){
    OrdersDetailTableView *ordersDetailTableView;
}

@end

@implementation OrdersDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ordersDetailTableView =[[OrdersDetailTableView alloc]initWithFrame:CGRectMake(0, 0, getScreenWidth(), getScreenHeight()) andOrder: self.order];
    ordersDetailTableView.backgroundColor=RGBA(225, 225, 225, 1);
    [ordersDetailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.title=@"Order Detail";
    [self.view addSubview:ordersDetailTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
