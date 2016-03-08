//
//  ShareViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/29/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareItem.h"
#import "SocialShareManager.h"
#import "GaanaFacebook.h"
@interface ShareViewController ()
{
    NSMutableArray *shareArray;
    NSMutableArray *imagesArray;
    ShareItem *shareItem;
}
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    shareArray= [[NSMutableArray alloc] initWithObjects:@"Whatsapp",@"Facebook",@"Message",@"Copy Link",@"Mail",@"Twitter",@"Google Plus",nil];
    imagesArray= [[NSMutableArray alloc] initWithObjects:@"whatsapp",@"facebook",@"messages_icon",@"copy_link",@"email",@"twittericon",@"googleplus",nil];
    self.title=@"Share";
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
        [self.navigationItem.leftBarButtonItem setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        //swRevealVC.rearViewRevealWidth=270.0f;
        //[swRevealVC revealToggle:self];
        [swRevealVC revealToggleAnimated:YES];
    }
    shareItem = [[ShareItem alloc] init];
    shareItem.itemTitle=@"Blickbee";
    shareItem.itemDescriptionText=@"Hey there, Check this app out and get fresh fruits and vegetables right at your doorstep, at the most reasonable prices in town. http://bit.ly/blickbee";
    shareItem.itemShareUrl=@"http://bit.ly/blickbee";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return shareArray.count;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[shareArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        //Whatsapp
        [[SocialShareManager sharedInstance] shareToWhatsAppWithShareUrl:shareItem.itemDescriptionText completionBlock:^(bool postSucessful, NSError *error) {
            if (!postSucessful) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp error" message:@"WhatsApp is not installed."
                                                               delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
                [alert show];
                
            }
        }];
    }
    else if (indexPath.row==1) {
        //Facebook
        [[GaanaFacebook sharedInstance] shareToFacebookonParentViewController:self withTitle:shareItem.itemTitle descriptionText:shareItem.itemDescriptionText artwork:shareItem.itemArtwork withShareUrl:shareItem.itemShareUrl withCaption:shareItem.itemTitle completionBlock:^(bool postSucessful, NSError *error) {
            
        }];
    }
    else if (indexPath.row==2) {
        //Message
        [[SocialShareManager sharedInstance] shareToSMSforViewWithUrlString:nil withDescriptionText:shareItem.itemDescriptionText];

    }
    else if (indexPath.row==3) {
        //Copy Link
        [[SocialShareManager sharedInstance] shareToClipboardWithShareUrl:shareItem.itemDescriptionText completionBlock:^(bool postSucessful, NSError *error) {
            
        }];

    }
    else if (indexPath.row==4) {
        //Mail
        [[SocialShareManager sharedInstance] shareToEMailWithSubject:shareItem.itemTitle withEmailBody:shareItem.itemDescriptionText isBodyContainsHTMl:YES onView:self withCompletionBlock:^(bool postSuccessful, NSError *error) {
            
        }];
    }
    else if (indexPath.row==5) {
        //Twitter
        [[SocialShareManager sharedInstance] shareToTwitterforView:self withItemUrl:shareItem.itemShareUrl descriptionText:shareItem.itemDescriptionText withCompletionBlock:^(bool postSuccessful, NSError *error) {
            
            
            
        }];
    }
    else if (indexPath.row==6) {
        //Google Plus
        [[SocialShareManager sharedInstance] shareToGoolePlusWithTitle:shareItem.itemTitle descriptionText:shareItem.itemDescriptionText artwork:shareItem.itemArtwork withShareUrl:shareItem.itemShareUrl CompletionBlock:^(bool postSucessful, NSError *error) {
            
        }];

    }
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
