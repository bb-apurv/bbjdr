//
//  OrderConfirmationViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/27/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "OrderConfirmationViewController.h"
#import "SWRevealViewController.h"
#import "BlickbeeAppManager.h"
#import "OrderServiceClient.h"

@interface OrderConfirmationViewController ()

@end

@implementation OrderConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelForOrderID.text=self.orderItem.uniqueOrderId;
    self.labelForOrderID.textColor=RGBA(213, 43, 16, 1);
    self.view.backgroundColor=RGBA(225, 225, 226, 1);
    [[self.shopMoreButtonPressed layer]setBorderColor:[UIColor blackColor].CGColor];
    [[self.shopMoreButtonPressed layer]setBorderWidth:1.0f];
    self.shopMoreButtonPressed.layer.cornerRadius = 0.0;

    [[BlickbeeAppManager sharedInstance] archiveSelectedProducts];
   // [self.navigationItem.backBarButtonItem setAction:@selector(openHomeVC:)];
    self.title=@"Confirm Order";
    
    UIImage *image =[UIImage imageNamed:@"back.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(-30, 0, image.size.width-40, image.size.height-40);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
    //[btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(moveBack) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = menuButton;
}

-(void) moveBack{
    [self emptySelectedProduct];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)openHomeVC:(id)sender{
    [self emptySelectedProduct];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) emptySelectedProduct{
    for(int i=0;i<[BlickbeeAppManager sharedInstance].selectedProducts.count;i++){
        Product*product = [[BlickbeeAppManager sharedInstance].selectedProducts objectAtIndex:i];
        product.selectedProductQuantity=@"0";
//        [[BlickbeeAppManager sharedInstance].selectedProducts removeLastObject];
    }

    [[BlickbeeAppManager sharedInstance].selectedProducts removeAllObjects];
    [[BlickbeeAppManager sharedInstance] archiveSelectedProducts];
    
}

-(void) viewWillAppear:(BOOL)animated{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @""
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(shopMoreButtonPressed:)];
    self.navigationItem.backBarButtonItem = backButton;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shopMoreButtonPressed:(id)sender {
    [self emptySelectedProduct];
    [self.navigationController popToViewController:[BlickbeeAppManager sharedInstance].homeViewController animated:YES];
}
@end
