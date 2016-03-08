//
//  ProductViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/12/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ProductViewController.h"
#import "CartViewController.h"
#import "BaseTableView.h"
#import "BlickBeePrefix.pch"
#import "BlickbeeAppManager.h"
#import "WYPopoverController.h"


@interface ProductViewController ()<chngValForFlotingBtn,optionSelected>{
    BaseTableView *productTableView;
    WYPopoverController *optionsPopoverController;
    UIButton *optionsBtn;
}

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image =[UIImage imageNamed:@"back.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(-30, 0, image.size.width-40, image.size.height-40);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
    [btn addTarget:self action:@selector(moveBack) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithCustomView:btn];

    optionsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    optionsBtn.bounds = CGRectMake(0, 0, 130, 44);
    [optionsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [optionsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    optionsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [optionsBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
    [optionsBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateHighlighted];
    [optionsBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 110, 0, 0)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
    [optionsBtn addTarget:self action:@selector(optionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *optionsMenuButton = [[UIBarButtonItem alloc]initWithCustomView:optionsBtn];
//    self.navigationItem.leftItemsSupplementBackButton = YES;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backButton,optionsMenuButton, nil];
    productTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,0, getScreenWidth(), getScreenHeight()) andProductsArray:nil];
    productTableView.separatorColor=[UIColor clearColor];
    productTableView.backgroundColor=RGBA(225, 225, 225, 1);
    productTableView.changeFlotingBtnDelegate=self;
    [self.view addSubview:productTableView];
    [self.view bringSubviewToFront:self.floatingBtn];
    [self.floatingBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[[BlickbeeAppManager sharedInstance]selectedProducts].count] forState:UIControlStateNormal];
}

-(void) setNavOptionButton{
    switch (self.deliveryOptions) {
        case kFruits:
            [optionsBtn setTitle:@"Fruits" forState:UIControlStateNormal];
            [optionsBtn setTitle:@"Fruits" forState:UIControlStateHighlighted];
            break;
        case kVegetables:
            [optionsBtn setTitle:@"Vegetables" forState:UIControlStateNormal];
            [optionsBtn setTitle:@"Vegetables" forState:UIControlStateHighlighted];
            break;
        default:
            break;
    }
}

-(void) moveBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[BlickbeeAppManager sharedInstance] archiveSelectedProducts];
}

-(void) prepareView{
    productTableView.frame = CGRectMake(0, 0, getScreenWidth(), getScreenHeight());
    switch (self.deliveryOptions) {
        case kFruits:
        {
            self.productRepo.fruitsArray = [[BlickbeeAppManager sharedInstance] updateWithNewSearchedArray:self.productRepo.fruitsArray];
            productTableView.productArray=self.productRepo.fruitsArray;
        }
            break;
        case kVegetables:
        {
            self.productRepo.vegetablesArray = [[BlickbeeAppManager sharedInstance] updateWithNewSearchedArray:self.productRepo.vegetablesArray];
            productTableView.productArray=self.productRepo.vegetablesArray;
        }
            break;
        default:
            break;
    }
    [productTableView reloadData];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if(![self.floatingBtn.titleLabel.text isEqualToString:@"0"]){
    if([segue.identifier isEqualToString:@"cartViewControllerSegue"]){
        CartViewController *cartViewController = [segue destinationViewController];
        cartViewController.productArray=[[BlickbeeAppManager sharedInstance] selectedProducts];
    }
    }
}

-(void)setRightNavigationItem{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0,0,55,12);
    int totalAmount=0;
    for(int i=0;i<[BlickbeeAppManager sharedInstance].selectedProducts.count;i++){
        Product *product=[[Product alloc]init];
        product = [[BlickbeeAppManager sharedInstance].selectedProducts objectAtIndex:i];
        totalAmount+=([product.selectedProductQuantity integerValue]*[product.productBbPrice integerValue]);
    }
    [btn setTitle:[NSString stringWithFormat:@"₹%ld",(long)totalAmount] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]init];
    UIBarButtonItem *total = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:total animated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(productTableView){
        [self prepareView];
    }
    [self setNavOptionButton];
    [self setRightNavigationItem];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.floatingBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[[BlickbeeAppManager sharedInstance]selectedProducts].count] forState:UIControlStateNormal];
}


-(void)changeValOfFloatingBtn{
    
[self.floatingBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[[BlickbeeAppManager sharedInstance]selectedProducts].count] forState:UIControlStateNormal];
    [self setRightNavigationItem];
}

-(void) awakeFromNib{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) optionsButtonPressed:(id)sender
{
    UIView *btn = (UIView *)sender;
    OptionsPopOverViewControllerTableViewController *controller = [[OptionsPopOverViewControllerTableViewController alloc] init];
    controller.optionSelectedDelegate = self;
    controller.preferredContentSize = CGSizeMake(120, 88);
    UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    if (!optionsPopoverController) {
        optionsPopoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        optionsPopoverController.delegate = self;
        optionsPopoverController.passthroughViews = @[btn];
        optionsPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        optionsPopoverController.wantsDefaultContentAppearance = NO;
        optionsPopoverController.theme.arrowBase = 16;
        optionsPopoverController.theme.arrowHeight = 8;
        [optionsPopoverController presentPopoverFromRect:btn.bounds
                                                  inView:btn
                                permittedArrowDirections:WYPopoverArrowDirectionAny
                                                animated:YES
                                                 options:WYPopoverAnimationOptionFadeWithScale];        
    }
}


#pragma mark - WYPopoverControllerDelegate

- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller{
    //NSLog(@"popoverControllerDidPresentPopover");
    
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    
    if (controller == optionsPopoverController)
    {
        optionsPopoverController.delegate = nil;
        optionsPopoverController = nil;
    }
    //NSLog(@"%@",[self inPagePlayerView].settingsButton.titleLabel.text);
    //NSLog(@"%@",[[SettingsManager sharedInstance] getStreamingQualityString]);
    
}

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController
{
    return YES;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 0; // set value to 0 if you want to avoid the popover to be moved
}

-(void) optionSelected:(DeliveryOptions)optionSelected{
    if (self.deliveryOptions!=optionSelected) {
        self.deliveryOptions=optionSelected;
        [self prepareView];
        [self setNavOptionButton];
    }
    [optionsPopoverController dismissPopoverAnimated:YES completion:^{
        [self popoverControllerDidDismissPopover:optionsPopoverController];
    }];
}


@end
