//
//  HomeViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/4/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "TopZoneView.h"
#import "ProductsServiceClient.h"
#import "TopZoneCollectionViewCell.h"
#import "ProductViewController.h"
#import "BlickbeePrefix.pch"
#import "UserInfoServiceClient.h"
#import "AddAddressServiceClient.h"
#import "BlickbeeAppManager.h"
#import "Product.h"
#import "UserInfoViewController.h"
#import "SearchViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ProductsServiceClient *client = [[ProductsServiceClient alloc] init];
    [client fetchProdctRepoWithSuccess:^(ProductRepo *repo) {
        //NSArray* reversedArray = [[startArray reverseObjectEnumerator] allObjects];
        repo.offersArray = [NSMutableArray arrayWithArray:[[repo.offersArray reverseObjectEnumerator] allObjects]];
        self.productRepo=repo;
        //            [[BlickbeeAppManager sharedInstance] matchSelectedProductsWithNewProductRepo:repo];
        NSString *test = [[repo.popupDict objectForKey:@"status"] stringValue];
       // NSLog(@"%@ Status of popup",test);
        
        if([test isEqualToString:@"1"]){
        
        
        NSString *msg = [repo.popupDict objectForKey:@"description"];
        //NSLog(@"%@",msg);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BlickBee" message:msg delegate:self cancelButtonTitle:@"START SHOPPING" otherButtonTitles:nil, nil];
        [alertView show];
        }
        [self.homeTableView reloadData];
        //if([test isEqualToString:@"1"]){
        
       
        // }
        
        //}
        //FOR POPUP
        //NSString *title = [repo.popupDict objectForKey:@"title"];
        
        //if (![title isEqualToString:@""]) {
        
        
    } failure:^(NSError *error) {
        
    }];
    
    SWRevealViewController *swRevealVC = self.revealViewController;
    if(swRevealVC){
        UIImage *image =[UIImage imageNamed:@"menu.png"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, image.size.width-40, image.size.height-40);
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
        [btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:image forState:UIControlStateNormal];
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        [self.navigationItem.leftBarButtonItem setTarget: self.revealViewController];
//        [self.navigationItem.leftBarButtonItem setAction: @selector( revealToggle: )];
        self.navigationItem.leftBarButtonItem = menuButton;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        self.revealViewController.panGestureRecognizer.delegate=self;
        self.navigationController.navigationBar.barTintColor=RGBA(246, 71, 17, 1);
        [self.homeTableView registerNib:[UINib nibWithNibName:@"TopZoneCollectionViewCell" bundle:nil] forCellReuseIdentifier:@"TopZoneCollectionViewCell"];
       /* ProductsServiceClient *client = [[ProductsServiceClient alloc] init];
        [client fetchProdctRepoWithSuccess:^(ProductRepo *repo) {
            //NSArray* reversedArray = [[startArray reverseObjectEnumerator] allObjects];
            repo.offersArray = [NSMutableArray arrayWithArray:[[repo.offersArray reverseObjectEnumerator] allObjects]];
            self.productRepo=repo;
//            [[BlickbeeAppManager sharedInstance] matchSelectedProductsWithNewProductRepo:repo];
            NSString *test = [repo.popupDict objectForKey:@"status"];
            NSLog(@"%@",test);
            //if([[repo.popupDict objectForKey:@"status"] isEqualToString:@"0"]){
                              //}
            

            
            [self.homeTableView reloadData];
            //if([test isEqualToString:@"1"]){
  
            NSString *msg = [repo.popupDict objectForKey:@"description"];
            //NSLog(@"%@",msg);
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BlickBee" message:msg delegate:self cancelButtonTitle:@"START SHOPPING" otherButtonTitles:nil, nil];
            [alertView show];
           // }
            
            //}
            //FOR POPUP
            //NSString *title = [repo.popupDict objectForKey:@"title"];
            
            //if (![title isEqualToString:@""]) {
                
            
        } failure:^(NSError *error) {
            
        }];
     */
        UserInfoServiceClient *userClient = [[UserInfoServiceClient alloc] init];
        [userClient updateCustomerInfo:^{
            
        } failure:^(NSError *error) {
            
        }];

        AddAddressServiceClient *addressClient = [[AddAddressServiceClient alloc] init];
        [addressClient getNearestAreasWithSuccess:^(NSMutableArray *areasArray) {
            
        } failure:^(NSError *error) {
            
        }];

        
    }
    self.title = @"BlickBee";
    
    [BlickbeeAppManager sharedInstance].homeViewController=self;
}

-(void)setRightNavigationItem{
    UIImage *image =[UIImage imageNamed:@"user icon.png"];
    UIImage *searchBtnImage = [UIImage imageNamed:@"search.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(userIconTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, image.size.width-45, image.size.height-45);
    searchBtn.bounds = CGRectMake(0, 0, image.size.width-45, image.size.height-45);
    btn.imageEdgeInsets=UIEdgeInsetsMake(0, 5, 0, -5);
    searchBtn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]init];
    [searchBtn addTarget:self action:@selector(searchIconTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [searchBtn setImage:searchBtnImage forState:UIControlStateNormal];
    UIBarButtonItem *userIconButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //UIBarButtonItem *userIconButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:userIconButton,searchButton, nil] animated:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


-(void)searchIconTapped:(id)responder{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *cont = [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self.navigationController pushViewController:cont animated:YES];
//    UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController:cont];
//    [self.navigationController presentViewController:navCont animated:YES completion:^{
//        
//    }];
    
}


-(void)userIconTapped:(id)responder{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *swRevealVC = self.revealViewController;
    UserInfoViewController *userInfoVC= [storyBoard instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
//    UINavigationController *NVC = [[UINavigationController alloc]initWithRootViewController:userInfoVC];
    [self.navigationController pushViewController:userInfoVC animated:YES];
//    NVC.navigationBar.barTintColor=RGBA(247, 71, 17, 1);
    //[swRevealVC revealToggle:NVC];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightNavigationItem];
    [self.view bringSubviewToFront:self.floatingBtn];
    [self.floatingBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[[BlickbeeAppManager sharedInstance]selectedProducts].count] forState:UIControlStateNormal];
    //self.navigationItem.leftBarButtonItem=[UIBarButtonItem alloc]init
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

        if (indexPath.section==0) {
            TopZoneView *topZoneView = [[TopZoneView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, getScreenWidth()*288.0/720.0) andItems:self.productRepo.offersArray];
            [cell addSubview:topZoneView];
        }
        else if(indexPath.section==1){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, getScreenWidth()*192/320)];
            [imgView setContentMode:UIViewContentModeScaleAspectFit];
            imgView.image = [UIImage imageNamed:@"fruits_vector"];
            [cell addSubview:imgView];
        }
        else if(indexPath.section==2){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, getScreenWidth()*192/320)];
            [imgView setContentMode:UIViewContentModeScaleAspectFit];
            imgView.image = [UIImage imageNamed:@"veg_vector"];
            [cell addSubview:imgView];
        }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *idx= indexPath;
   // NSLog(@"%ld",(long)idx.section);
    if (indexPath.row==0) {
        if(indexPath.section==1){
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProductViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"ProductViewController"];
            //        ProductViewController *vc = [[ProductViewController alloc]init];
            vc.productRepo=self.productRepo;
            vc.deliveryOptions=kFruits;
            //        vc.productArray=self.productRepo.fruitsArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.section==2){
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProductViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"ProductViewController"];
            vc.productRepo=self.productRepo;
            vc.deliveryOptions=kVegetables;
            //        vc.productArray=self.productRepo.vegetablesArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section==0)
            return getScreenWidth()*288.0/720.0 +8;
        else if(indexPath.section==1)
            return getScreenWidth()*192.0/320.0 +8;
        else
            return getScreenWidth()*192.0/320.0;
}

@end
