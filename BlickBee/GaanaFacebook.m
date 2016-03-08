//
//  GaanaFacebook.m
//  Gaana
//
//  Created by Manuj Porwal on 20/10/15.
//  Copyright © 2015 TimesInternet. All rights reserved.
//

#import "GaanaFacebook.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareDialog.h>
#import <FBSDKShareKit/FBSDKShareLinkContent.h>

@interface GaanaFacebook()<FBSDKSharingDelegate>

@property(nonatomic, strong) FBSDKLoginManager *loginManager;
@property (nonatomic, copy) void (^shareCompletionBlock)(bool postSucessful, NSError *error);

@end

@implementation GaanaFacebook

#pragma mark -
#pragma mark - Singleton

+ (GaanaFacebook *)sharedInstance
{
    static GaanaFacebook *gaanaFacebook = nil;
    
    @synchronized (self){
        
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            gaanaFacebook = [[GaanaFacebook alloc] init];
            gaanaFacebook.loginManager = [[FBSDKLoginManager alloc] init];
        });
    }
    
    return gaanaFacebook;
}


- (void) loginCallbackForFacebook:(void (^) (bool isLogin, id response)) completionBlock{

    if ([FBSDKAccessToken currentAccessToken]) {
        
        [FBSDKAccessToken refreshCurrentAccessToken:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {

            if (!error) {
                [[NSUserDefaults standardUserDefaults] setObject:[FBSDKAccessToken currentAccessToken].tokenString forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:[FBSDKAccessToken currentAccessToken].expirationDate forKey:@"exp_date"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                completionBlock(true,result);
            }
            else{
                completionBlock(false,error);
            }
            
        }];
        return;
    }
    
    [self.loginManager logInWithReadPermissions: @[@"email",@"user_birthday",@"public_profile"]
     fromViewController:nil
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
             completionBlock(false,error);
             
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
             completionBlock(false,[NSDictionary dictionaryWithObject:@"Facebook authentication cancelled, please try logging in again." forKey:@"Error"]);
             
         } else {
             NSLog(@"Logged in");
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,email,birthday,gender"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      
                      if (!error) {
                          [[NSUserDefaults standardUserDefaults] setObject:[FBSDKAccessToken currentAccessToken].tokenString forKey:@"access_token"];
                          [[NSUserDefaults standardUserDefaults] setObject:[FBSDKAccessToken currentAccessToken].expirationDate forKey:@"exp_date"];
                          [[NSUserDefaults standardUserDefaults] synchronize];
                          
                          completionBlock(true,result);
                      }
                      else{
                          completionBlock(false,error);
                      }
                      
                      
                  }];
             }
         }
     }];
}

- (void) getFacebookUserProfileData:(void (^) (id response, NSError *error)) completionBlock{
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,email,birthday,gender"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         
         if (!error) {
             [[NSUserDefaults standardUserDefaults] setObject:[FBSDKAccessToken currentAccessToken].tokenString forKey:@"access_token"];
             [[NSUserDefaults standardUserDefaults] setObject:[FBSDKAccessToken currentAccessToken].expirationDate forKey:@"exp_date"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             completionBlock(result,error);
         }
         else{
             completionBlock(nil,error);
         }
     }];
}

- (void) logoutFbUser{
    [self.loginManager logOut];
}

- (void) shareToFacebookonParentViewController:(UIViewController *)parentController withTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
    
    self.shareCompletionBlock = completionBlock;
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    [content setContentTitle:title];
    [content setContentDescription:textDescription];
    [content setImageURL:[NSURL URLWithString:artworklink]];
    [content setContentURL:[NSURL URLWithString:itemShareUrl]];

    if ([FBSDKAccessToken currentAccessToken]) {
        [FBSDKShareDialog showFromViewController:parentController withContent:content delegate:self];
    }
    else{
        [self loginCallbackForFacebook:^(bool isLogin, id response) {
            if (isLogin) {
                [FBSDKShareDialog showFromViewController:parentController withContent:content delegate:self];
            }
            
        }];
    }
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    if (results && [results isKindOfClass:[NSDictionary class]] && [results objectForKey:@"postId"] && [[results objectForKey:@"postId"] isKindOfClass:[NSString class]] && [[results objectForKey:@"postId"] length]) {
        self.shareCompletionBlock(YES, nil);
    }
    else{
        self.shareCompletionBlock(NO, nil);
    }

    self.shareCompletionBlock = nil;
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    self.shareCompletionBlock(NO, error);
    self.shareCompletionBlock = nil;
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    self.shareCompletionBlock(NO, nil);
    self.shareCompletionBlock = nil;
}



@end
