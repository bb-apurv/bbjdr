//
//  MyOrdersViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/23/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "MyOrdersTableViewCell.h"
#import "SWRevealViewController.h"
#import "OrderServiceClient.h"
#import "MyOrdersTableView.h"
#import "OrdersDetailTableViewCell.h"
#import "OrdersDetailViewController.h"

@interface MyOrdersViewController (){
    MyOrdersTableView *myOrdersTableView;
}

@end

@implementation MyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *swRevealVC = self.revealViewController;
    if(swRevealVC){
        UIImage *image =[UIImage imageNamed:@"menu.png"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, image.size.width-40, image.size.height-40);
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
        [btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:image forState:UIControlStateNormal];
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = menuButton;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        self.revealViewController.panGestureRecognizer.delegate=self;
        self.navigationController.navigationBar.barTintColor=RGBA(246, 71, 17, 1);
        [self.navigationItem.leftBarButtonItem setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        //swRevealVC.rearViewRevealWidth=270.0f;
        [swRevealVC revealToggleAnimated:YES];
    }
    OrderServiceClient *client = [[OrderServiceClient alloc] init];
    [client getAllOrdersWithSuccess:^(NSMutableArray *orderaArray) {
        self.myOrdersArray=orderaArray;
        myOrdersTableView.myOrdersArray=orderaArray;
        [myOrdersTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    myOrdersTableView = [[MyOrdersTableView alloc]initWithFrame:CGRectMake(0, 0, getScreenWidth(), getScreenHeight()) andOrdersArray:self.myOrdersArray];
    myOrdersTableView.parentVC=self;
    myOrdersTableView.separatorColor=[UIColor clearColor];
    myOrdersTableView.backgroundColor=RGBA(225, 225, 225, 1);
    [self.view addSubview:myOrdersTableView];
    
    self.title=@"My Orders";
}

-(void) launchOrderDetailVC : (Order *)order{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *revealVC = self.revealViewController;
    OrdersDetailViewController *ordersDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"OrdersDetailViewController"];
    ordersDetailVC.order=order;
    [self.navigationController pushViewController:ordersDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
