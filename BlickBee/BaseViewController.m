//
//  BaseViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 12/6/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseViewController.h"
#import "UIFont+Custom.h"
@interface BaseViewController () <SWRevealViewControllerDelegate>
    @property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
    @property (nonatomic,strong) UIView *overlayView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        self.navigationController.navigationBar.titleTextAttributes =  @{
                                                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                         NSFontAttributeName: [UIFont getProximaNovaBoldWithSize:18.0],
                                                                         }
        ;
        
}
    UIImage *image =[UIImage imageNamed:@"back.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(-30, 0, image.size.width-40, image.size.height-40);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
    [btn addTarget:self action:@selector(moveBack) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = menuButton;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SWRevealViewController *swRevealVC = self.revealViewController;
    if (swRevealVC) {
        swRevealVC.delegate=self;
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(rightRevealToggle:)];
        
        self.overlayView  = [[UIView alloc] initWithFrame:swRevealVC.frontViewController.view.frame];
        self.overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.overlayView addGestureRecognizer:self.tapGestureRecognizer];
//        self.tapGestureRecognizer.enabled = NO;
    }
}

#pragma mark - SWRevealViewController Delegate Methods

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft){
//        [revealController.frontViewController.view removeGestureRecognizer:self.tapGestureRecognizer];
//        self.tapGestureRecognizer.enabled = NO;                 // Enable the tap gesture Recognizer
        [self.overlayView removeFromSuperview];
    }else{
//        [revealController.frontViewController.view addGestureRecognizer:self.tapGestureRecognizer];
//        self.tapGestureRecognizer.enabled = YES;
        [revealController.frontViewController.view addSubview:self.overlayView];
        [revealController.frontViewController.view bringSubviewToFront:self.overlayView];
    }
}

-(void)moveBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
