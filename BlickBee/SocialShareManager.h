//
//  SocialShareManager.h
//  FrostedDemo
//
//  Created by Alok Ranjan on 19/02/14.
//  Copyright (c) 2014 Alok Ranjan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GaanaFacebook.h"
#import "ShareItem.h"
@interface SocialShareManager : NSObject
+ (SocialShareManager*)sharedInstance;

// Setting Sharing Obejct
- (void) setShareItem:(ShareItem *)shareItem;
- (void) setSharingItemTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink itemUrl:(NSString *) itemUrlStr;
// Sharing option for default Sharing Item
- (void) shareViaFacebookOnView:(UIViewController *)parentViewCont completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion;
- (void) shareOnFacebook:(UIViewController *)parentController withTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext clientStateDict:(NSDictionary *) aClientStateDictionary completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;

- (void) shareViaGooglePlus:(void (^)(bool, NSError *error))onCompletion;
- (void) shareViaTwitterOnView:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion;
- (void) shareViaSMSOnView:(UIViewController *)aParentView completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion;
- (void) shareViaMailOnView:(UIViewController *)aParentView completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion;
- (void) shareViaClipBoardWithcompletionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion;
- (void) shareViaWhatsappWithcompletionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion;

// Custom Setting Sharing options + Sharing
- (void) postOnMailWithShareItem:(ShareItem *) shareItem onParentViewController:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;
- (void) postOnSMSWithShareItem:(ShareItem *) shareItem onParentViewController:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;
- (void) postOnTwitterWithShareItem:(ShareItem *) shareItem onParentViewController:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;
- (void) postOnFacebookWithShareItem:(ShareItem *) shareItem onParentViewController:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;
- (void) postOnGoogleWithShareItem:(ShareItem *)shareItem  completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;

- (void) postOnClipBoardWithShareItem:(ShareItem *)shareItem completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion;





// Direct Sharing options with Social Manager id done to accomodate the need to make SocialShareManager standalone can be used in across the App.
- (void) shareToGoolePlusWithTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl CompletionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;

- (void) shareToSMSforViewWithUrlString:(NSString *) aUrlToShareStr withDescriptionText:(NSString *) aDescriptionStr;

- (void) shareToEMailWithSubject:(NSString *) mailSubjectStr withEmailBody:(NSString *) mailBodyStr isBodyContainsHTMl:(BOOL) isHtml onView:(UIViewController *)parentViewCont withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock;

- (void) shareToTwitterforView:(UIViewController *) parentController withItemUrl:(NSString *) itemUrl descriptionText:(NSString *) descriptionStr  withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock;

//- (void) shareToFacebookonParentViewController:(UIViewController *)parentController withTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext clientStateDict:(NSDictionary *) aClientStateDictionary completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;

- (void) shareToClipboardWithShareUrl:(NSString *) aUrlString completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;

- (void) shareToWhatsAppWithShareUrl:(NSString *) message completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock;


/*
 
 UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
 NSString *urlString = [self getShareUrlwithAttributes:FALSE andObject:aItemObject];
 pasteboard.string = urlString;
 
 */


@end
