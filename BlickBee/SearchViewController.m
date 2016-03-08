//
//  SearchViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 12/28/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "SearchViewController.h"
#import "BaseTableView.h"
#import "CartViewController.h"
#import "ProductsServiceClient.h"
@interface SearchViewController ()<UISearchBarDelegate,chngValForFlotingBtn>
{
    BaseTableView *productTableView;
    UISearchBar *navSearchBar;
    NSString *searchedStr;
    NSMutableArray *prodsArray;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor=RGBA(246, 71, 17, 1);
    productTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, getScreenWidth(), getScreenHeight()) andProductsArray:nil];
    productTableView.separatorColor=[UIColor clearColor];
    productTableView.backgroundColor=RGBA(225, 225, 225, 1);
    productTableView.changeFlotingBtnDelegate=self;
    [self.view addSubview:productTableView];
    [self.view bringSubviewToFront:self.floatingBtn];
    [self.floatingBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[[BlickbeeAppManager sharedInstance]selectedProducts].count] forState:UIControlStateNormal];
    searchedStr=@"Search";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareNavView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (navSearchBar) {
        [navSearchBar removeFromSuperview];
    }
    [[BlickbeeAppManager sharedInstance] archiveSelectedProducts];
}
-(void) prepareNavView{
    navSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 0, getScreenWidth()-80, 44)];
    navSearchBar.delegate=self;
    navSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    [navSearchBar setBackgroundColor:[UIColor clearColor]];
    [navSearchBar setBarTintColor:[UIColor clearColor]];
    [navSearchBar setPlaceholder:searchedStr];
    [navSearchBar setImage:[UIImage imageNamed:@"search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *searchField = [navSearchBar valueForKey:@"_searchField"];
    searchField.textColor = [UIColor whiteColor];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.navigationController.navigationBar addSubview:navSearchBar];
    [navSearchBar becomeFirstResponder];
}

-(void) prepareView{
    
    productTableView.productArray=prodsArray;
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

#pragma mark UISearchBar Delegetes

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    searchedStr=searchBar.text;
    if (![searchedStr isEqualToString:@""]) {
        if (navSearchBar) {
            [navSearchBar resignFirstResponder];
        }
        ProductsServiceClient *client = [[ProductsServiceClient alloc] init];
        [client fetchProductRepoForSearchedString:searchedStr WithSuccess:^(NSMutableArray *repo) {
            if (repo && repo.count>0) {
                repo = [[BlickbeeAppManager sharedInstance] updateWithNewSearchedArray:repo];
                prodsArray=repo;
                [self prepareView];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"" message:@"No product found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
/*
-(NSMutableArray*) checkProductsRepoForSelectedProductQuantity:(NSMutableArray*) repo{
    NSArray *repoCopy = [NSArray arrayWithArray:repo];
    for (int i=0; i<repoCopy.count; i++) {
        Product *product = [repoCopy objectAtIndex:i];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productId = %@",product.productId];
        NSArray *foundArray = [[BlickbeeAppManager sharedInstance].selectedProducts filteredArrayUsingPredicate:predicate];
        if (foundArray && [foundArray count]) {
            Product *selectedProduct = [foundArray objectAtIndex:0];
            selectedProduct.productPrice = product.productPrice;
            repo[i]=selectedProduct;
        }
    }
    return repo;
}
*/

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}

-(void)changeValOfFloatingBtn{
    
    [self.floatingBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[[BlickbeeAppManager sharedInstance]selectedProducts].count] forState:UIControlStateNormal];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
