//
//  GaanaFacebook.h
//  Gaana
//
//  Created by Manuj Porwal on 20/10/15.
//  Copyright © 2015 TimesInternet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GaanaFacebook : NSObject

+ (GaanaFacebook*)sharedInstance;

- (void) loginCallbackForFacebook:(void (^) (bool isLogin, id response)) completionBlock;

- (void) getFacebookUserProfileData:(void (^) (id response, NSError *error)) completionBlock;

- (void) logoutFbUser;

- (void) shareToFacebookonParentViewController:(UIViewController *)parentController withTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;

@end
