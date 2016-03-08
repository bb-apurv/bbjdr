//
//  SocialShareManager.m
//  FrostedDemo
//
//  Created by Alok Ranjan on 19/02/14.
//  Copyright (c) 2014 Alok Ranjan. All rights reserved.
//

#import "SocialShareManager.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <GooglePlus/GooglePlus.h>
//#import "GenericFunctions.h"
#import "GaanaFacebook.h"

//#import "MoreOptionsConfigurator.h"

@interface SocialShareManager ()
@property (nonatomic,strong) ShareItem *shareItem;
@property (nonatomic,strong) MFMailComposeViewController *mailComposeView;
@property (nonatomic,strong) MFMessageComposeViewController *messageComposer;
@end


@implementation SocialShareManager
#pragma mark -
#pragma mark Singleton Methods
+ (SocialShareManager*)sharedInstance {
	static SocialShareManager *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[super allocWithZone:nil] init];
            // Application Data
        });
    }
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    
	return [self sharedInstance];
}


- (id)copyWithZone:(NSZone *)zone {
	return self;
}

#if (!__has_feature(objc_arc))

- (id)retain {
    
	return self;
}

- (unsigned)retainCount {
	return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release {
	//do nothing
}

- (id)autorelease {
    
	return self;
}
#endif

/*
#pragma mark -
#pragma mark Independent Sharing Objects
// Independent sharing on facebook
- (void) shareOnFacebookWithShareAttrTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext clientStateDict:(NSDictionary *) aClientStateDictionary onView:(UIViewController *)parentViewCont withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock{
    // Set the ViewController
    [self setFacebookItemForSharingonTitle:title descriptionText:textDescription artwork:artworklink withShareUrl:itemShareUrl withCaption:captiontext clientStateDict:aClientStateDictionary];
    // Do the facebook posting
    [self postOnFacebookonParentViewController:parentViewCont completionBlock:^(bool postSucessful, NSError *error) {
        completionBlock(postSucessful,error);
    }];
}
// Independent sharing on Twitter
- (void) shareOnTwitterWithTwitterShortUrl:(NSString *) shortUrl withDescriptionText:(NSString *) descriptionText onView:(UIViewController *)parentViewCont withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock{
    [self setTwitterShareItemWithShortUrl:shortUrl withDescription:descriptionText];
    [self shareTwitterFeedforView:parentViewCont withCompletionBlock:^(bool postSuccessful, NSError *error) {
        
    }];
}
// Independent Sharing on GooglePlus
//- (void) shareOnGooglePlusWithUrlToShare:(NSString *) urlToShareStr deepLinkId:(NSString *) deepLinkStr itemTitle:(NSString *) titleStr descriptionText:(NSString *) descriptonStr thumbNail:(NSString *) artworkUrlStr onView:(UIViewController *)parentViewCont withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock{
//    [self setGaanaPlusShareItem:urlToShareStr deepLinkId:deepLinkStr itemTitle:titleStr descriptionText:descriptonStr thumbNail:artworkUrlStr];
//    [self shareOnGoolePlusWithCompletionBlock:^(bool postSucessful, NSError *error) {
//        
//    }];
//}
// Independent Sharing on Email Client
//- (void) shareOnEMailWithSubject:(NSString *) mailSubjectStr withEmailBody:(NSString *) mailBodyStr isBodyContainsHTMl:(BOOL) isHtml onView:(UIViewController *)parentViewCont withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock{
//    [self setMailShareItemMailSubject:mailSubjectStr withEmailBody:mailBodyStr isBodyContainsHTMl:isHtml];
//    [self shareViaMailforView:parentViewCont completionBlock:^(bool postSucessful, NSError *error) {
//        completionBlock (postSucessful,error);
//    }];
//}
// Independent Sharing on Message Client

// Independent Sharing on ClipBoard

- (void) resetShareItem{
    _shareItem = nil;
    _fbShareItem = nil;
    _twitterShareItem = nil;
    _gPlusShareItem = nil;
    _mailShareItem = nil;
}
 */

- (void) setShareItem:(ShareItem *)shareItem {
    if (!_shareItem) {
        _shareItem = [[ShareItem alloc]init];
    }
    _shareItem = shareItem;
}

- (void) setSharingItemTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink itemUrl:(NSString *) itemUrlStr{
    //
    if (!_shareItem) {
        _shareItem = [[ShareItem alloc] init];
    }
    _shareItem.itemTitle = title;
    _shareItem.itemDescriptionText = textDescription;
    _shareItem.itemArtwork = artworklink;
    _shareItem.itemShareUrl = itemUrlStr;
}
// Override the Share object

/*
- (void) setFacebookItemForSharingonTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext clientStateDict:(NSDictionary *) aClientStateDictionary{
    if (!_fbShareItem) {
        _fbShareItem = [[FBShareItem alloc] init];
    }
    _fbShareItem.itemTitle = title;
    _fbShareItem.itemDescriptionText = textDescription;
    _fbShareItem.itemArtwork = artworklink;
    _fbShareItem.itemShareUrlWithText = itemShareUrl;
    _fbShareItem.captionText = captiontext;
    _fbShareItem.clienStateDictionary = aClientStateDictionary;
}

/*- (void) setTwitterItemForSharing:(NSString *) */

/*
 
 descriptionText = [self getShareText:aObject];
 
 urlString = [self getShareUrlwithAttributes:FALSE andObject:aObject];
 
 urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
 
 
 itemTitle = [self getObjectName:aObject];
 
 if ([[aObject artwork] isKindOfClass:[NSString class]]) {
 artworkUrl = [NSURL URLWithString:[aObject artwork]];
 }
 [shareBuilder setURLToShare:urlToShare];
 
 [shareBuilder setContentDeepLinkID:urlString];
 [shareBuilder setTitle:itemTitle description:descriptionText thumbnailURL:artworkUrl];
 
 [shareBuilder open];
 
 */

/*

- (void) setGaanaPlusShareItem:(NSString *) urlStrtoShare deepLinkId:(NSString *) deepLinkStr itemTitle:(NSString *) titleStr descriptionText:(NSString *) descriptonStr thumbNail:(NSString *) artworkUrlStr{
    if (!_gPlusShareItem) {
        _gPlusShareItem = [[GPlusShareItem alloc] init];
    }
    _gPlusShareItem.itemTitle = titleStr;
    _gPlusShareItem.itemDescriptionText = descriptonStr;
    _gPlusShareItem.itemArtwork = artworkUrlStr;
    _gPlusShareItem.itemUrl = urlStrtoShare;
    _gPlusShareItem.deepLinkId = deepLinkStr;
}

- (void) setTwitterShareItemWithShortUrl:(NSString *) shortUrlStr withDescription:(NSString *) descriptionText{
    if (!_twitterShareItem) {
        _twitterShareItem = [[TwitterShareItem alloc] init];
    }
    _twitterShareItem.itemUrl = shortUrlStr;
    _twitterShareItem.itemDescriptionText = descriptionText;
}

- (void) setMailShareItemMailSubject:(NSString *) mailSubjectStr withEmailBody:(NSString *) mailBodyStr isBodyContainsHTMl:(BOOL) isHtml{
    if (!_mailShareItem) {
        _mailShareItem = [[MailShareItem alloc] init];
    }
    _mailShareItem.mailItemSubject = mailSubjectStr;
    _mailShareItem.mailItemBody = mailBodyStr;
}
*/
#pragma mark - 
#pragma mark Social Action Handlers
- (void) shareViaFacebookOnView:(UIViewController *)parentViewCont completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion{
//    NSString *gastr;
//    if([_shareItem.itemTitle isEqualToString:APPLICATION_NAME])
//        gastr=@"FacebookAppShare";
//    else
//    gastr = [[NSString alloc]initWithFormat:@"%@/%@/FacebookShare",[[MarketManager sharedInstance] gaString],[[MarketManager sharedInstance] presentNews]];
//    NSString *gaEvent = [gastr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementGAEventwithevent:gaEvent action:@"action" label:gastr value:nil];
//    NSString *lotamestr = [[NSString alloc]initWithFormat:@"%@/FacebookShare",[[MarketManager sharedInstance] gaString]];
//    NSString *lotameEvent = [lotamestr stringByAppendingString:@" Tapped"];
//
//    [self postOnFacebookWithShareItem:_shareItem onParentViewController:parentViewCont completionBlock:^(bool postSucessful, NSError *error) {
//        onCompletion (postSucessful,error);
//    }];
}

- (void) shareViaGooglePlus:(void (^)(bool postSucessful, NSError *error))onCompletion {
//    NSString *gastr;
//    if([_shareItem.itemTitle isEqualToString:APPLICATION_NAME])
//        gastr=@"GooglePlusAppShare";
//    else
//    gastr = [[NSString alloc]initWithFormat:@"%@/%@/GooglePlusShare",[[MarketManager sharedInstance] gaString],[[MarketManager sharedInstance] presentNews]];
//    NSString *gaEvent = [gastr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementGAEventwithevent:gaEvent action:@"action" label:gastr value:nil];
//    NSString *lotamestr = [[NSString alloc]initWithFormat:@"%@/GooglePlusShare",[[MarketManager sharedInstance] gaString]];
//    NSString *lotameEvent = [lotamestr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementLotameEvent:lotameEvent];
//    [self postOnGoogleWithShareItem:_shareItem completionBlock:^(bool postSucessful, NSError *error) {
//        onCompletion (postSucessful,error);
//    }];
}

- (void) shareViaTwitterOnView:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion{
//    NSString *gastr;
//    if([_shareItem.itemTitle isEqualToString:APPLICATION_NAME])
//        gastr=@"TwitterAppShare";
//    else
//        gastr = [[NSString alloc]initWithFormat:@"%@/%@/TwitterShare",[[MarketManager sharedInstance] gaString],[[MarketManager sharedInstance] presentNews]];
//    NSString *gaEvent = [gastr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementGAEventwithevent:gaEvent action:@"action" label:gastr value:nil];
//    NSString *lotamestr = [[NSString alloc]initWithFormat:@"%@/TwitterShare",[[MarketManager sharedInstance] gaString]];
//    NSString *lotameEvent = [lotamestr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementLotameEvent:lotameEvent];
//    [self postOnTwitterWithShareItem:_shareItem onParentViewController:parentViewController completionBlock:^(bool postSucessful, NSError *error) {
//        onCompletion(postSucessful,error);
//    }];
}

- (void) shareViaSMSOnView:(UIViewController *)aParentView completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion{
//    NSString *gastr;
//    if([_shareItem.itemTitle isEqualToString:APPLICATION_NAME])
//        gastr=@"SMSAppShare";
//    else
//        gastr = [[NSString alloc]initWithFormat:@"%@/%@/SMSShare",[[MarketManager sharedInstance] gaString],[[MarketManager sharedInstance] presentNews]];
//    NSString *gaEvent = [gastr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementGAEventwithevent:gaEvent action:@"action" label:gastr value:nil];
//    NSString *lotamestr = [[NSString alloc]initWithFormat:@"%@/SMSShare",[[MarketManager sharedInstance] gaString]];
//    NSString *lotameEvent = [lotamestr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementLotameEvent:lotameEvent];
//    [self postOnSMSWithShareItem:_shareItem onParentViewController:aParentView completionBlock:^(bool postSucessful, NSError *error) {
//        onCompletion (postSucessful,error);
//    }];
}

- (void) shareViaMailOnView:(UIViewController *)aParentView completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion{
//    NSString *gastr;
//    if([_shareItem.itemTitle isEqualToString:APPLICATION_NAME])
//        gastr=@"MailAppShare";
//    else
//        gastr = [[NSString alloc]initWithFormat:@"%@/%@/MailShare",[[MarketManager sharedInstance] gaString],[[MarketManager sharedInstance] presentNews]];
//    NSString *gaEvent = [gastr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementGAEventwithevent:gaEvent action:@"action" label:gastr value:nil];
//    NSString *lotamestr = [[NSString alloc]initWithFormat:@"%@/MailShare",[[MarketManager sharedInstance] gaString]];
//    NSString *lotameEvent = [lotamestr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementLotameEvent:lotameEvent];
//    [self postOnMailWithShareItem:_shareItem onParentViewController:aParentView completionBlock:^(bool postSucessful, NSError *error) {
//        onCompletion(postSucessful,error);
//    }];
}

- (void) shareViaClipBoardWithcompletionBlock:(void (^)(bool, NSError *))onCompletion{
//    NSString *gastr;
//    if([_shareItem.itemTitle isEqualToString:APPLICATION_NAME])
//        gastr=@"ClipboardAppShare";
//    else
//        gastr = [[NSString alloc]initWithFormat:@"%@/%@/ClipboardShare",[[MarketManager sharedInstance] gaString],[[MarketManager sharedInstance] presentNews]];
//    NSString *gaEvent = [gastr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementGAEventwithevent:gaEvent action:@"action" label:gastr value:nil];
//    NSString *lotamestr = [[NSString alloc]initWithFormat:@"%@/ClipboardShare",[[MarketManager sharedInstance] gaString]];
//    NSString *lotameEvent = [lotamestr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementLotameEvent:lotameEvent];
//    [self postOnClipBoardWithShareItem:_shareItem completionBlock:^(bool postSucessful, NSError *error) {
//        
//    }];
}

- (void) shareViaWhatsappWithcompletionBlock:(void (^)(bool, NSError *))onCompletion{
//    NSString *gastr;
//    if([_shareItem.itemTitle isEqualToString:APPLICATION_NAME])
//        gastr=@"WhatsappAppShare";
//    else
//        gastr = [[NSString alloc]initWithFormat:@"%@/%@/WhatsappShare",[[MarketManager sharedInstance] gaString],[[MarketManager sharedInstance] presentNews]];
//    NSString *gaEvent = [gastr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementGAEventwithevent:gaEvent action:@"action" label:gastr value:nil];
//    NSString *lotamestr = [[NSString alloc]initWithFormat:@"%@/WhatsappShare",[[MarketManager sharedInstance] gaString]];
//    NSString *lotameEvent = [lotamestr stringByAppendingString:@" Tapped"];
//    [[MarketManager sharedInstance] implementLotameEvent:lotameEvent];
//    [self postOnWhatsappWithShareItem:_shareItem completionBlock:^(bool postSucessful, NSError *error) {
//        
//    }];
}

#pragma mark -
#pragma mark  Actions With Custom Share Items
- (void) postOnMailWithShareItem:(ShareItem *) shareItem onParentViewController:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
//    NSString *descriptionText = shareItem.itemDescriptionText;
//    NSString *urlString = shareItem.itemShareUrl;
//    NSURL *urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
//    NSDictionary *_myDict = [[MoreOptionsConfigurator class] getMoreOptionsFromPlistForKey:@"eEmailButton"];
//    NSString *_mailBodyStr = [_myDict objectForKey:@"mailBody"];
//    
//    BOOL isHtmlValue = [[_myDict objectForKey:@"isHtml"] boolValue];
//    
//    NSString *emailBodyStr =[NSString stringWithFormat:_mailBodyStr,descriptionText, urlToShare];
//    [self shareToEMailWithSubject:shareItem.itemTitle withEmailBody:emailBodyStr isBodyContainsHTMl:isHtmlValue onView:parentViewController withCompletionBlock:^(bool postSuccessful, NSError *error) {
//       
//    }];
    
}

- (void) postOnSMSWithShareItem:(ShareItem *) shareItem onParentViewController:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
    [self shareToSMSforViewWithUrlString:shareItem.itemShareUrl withDescriptionText:shareItem.itemDescriptionText];
    completionBlock (YES,Nil);
}

- (void) postOnTwitterWithShareItem:(ShareItem *) shareItem onParentViewController:(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
    [self shareToTwitterforView:parentViewController withItemUrl:shareItem.itemShareUrl descriptionText:shareItem.itemDescriptionText withCompletionBlock:^(bool postSuccessful, NSError *error) {
        completionBlock (postSuccessful,error);
    }];
}

- (void) postOnFacebookWithShareItem:(ShareItem *) shareItem onParentViewController:
(UIViewController *) parentViewController completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
    //[self shareToFacebookonParentViewController:parentViewController withTitle:shareItem.itemTitle descriptionText:shareItem.itemDescriptionText artwork:shareItem.itemArtwork withShareUrl:shareItem.itemShareUrl withCaption:Nil clientStateDict:Nil completionBlock:^(bool postSucessful, NSError *error) {
    //    completionBlock (postSucessful,error);
    //}];
    
    [[GaanaFacebook sharedInstance] shareToFacebookonParentViewController:parentViewController withTitle:shareItem.itemTitle descriptionText:shareItem.itemDescriptionText artwork:shareItem.itemArtwork withShareUrl:shareItem.itemShareUrl withCaption:nil completionBlock:^(bool postSucessful, NSError *error) {
        completionBlock (postSucessful,error);
    }];

}

- (void) postOnGoogleWithShareItem:(ShareItem *)shareItem  completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
    [self shareToGoolePlusWithTitle:shareItem.itemTitle descriptionText:shareItem.itemDescriptionText artwork:shareItem.itemArtwork withShareUrl:shareItem.itemShareUrl CompletionBlock:^(bool postSucessful, NSError *error) {
        
    }];
}

- (void) postOnClipBoardWithShareItem:(ShareItem *)shareItem completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion{
    [self shareToClipboardWithShareUrl:shareItem.itemShareUrl completionBlock:^(bool postSucessful, NSError *error) {
    }];
}

- (void) postOnWhatsappWithShareItem:(ShareItem *)shareItem completionBlock:(void (^) (bool postSucessful, NSError *error)) onCompletion{

    //    NSString *shareText = [NSString stringWithFormat:@"whatsapp://send?text=ET Markets:%@ - %@",_shareItem.itemTitle,[self encodeTheURLString:_shareItem.itemShareUrl]];
    //
    //     shareText = [shareText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //   NSURL *whatsappURL = [NSURL URLWithString:shareText];

    NSURL *whatsappURL = [NSURL URLWithString:[[NSString stringWithFormat:@"whatsapp://send?text=%@ - %@",_shareItem.itemTitle, _shareItem.itemShareUrl] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];

    
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp error" message:@"WhatsApp is not installed."
                                                       delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];

        [alert show];
    }
}

#pragma mark - Sharing Logic
#pragma mark Google Plus Handling
#pragma mark Google Plus Share
- (void) shareToGoolePlusWithTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl CompletionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
    NSString *descriptionText = textDescription;
    NSString *urlString = itemShareUrl;
    NSURL *urlToShare;
    NSString *itemTitle = title;

    NSURL *artworkUrl;
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;

    id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
//    [GPPShare sharedInstance].delegate = self;
    
    //    if (!aObject) {
    //        //descriptionText = @"";
    //        return;
    //    }
    
//    descriptionText = _gPlusShareItem.itemDescriptionText;
//    
//    urlString = _gPlusShareItem.itemShareUrlWithText;
//
    
//    urlString = @"http://developers.google.com/+/mobile/ios/";
   // urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    urlToShare = [[NSURL alloc]initWithString:urlString];
    
    
    if ([artworklink isKindOfClass:[NSString class]]) {
        artworkUrl = [NSURL URLWithString:artworklink];
    }
    [shareBuilder setURLToShare:urlToShare];
    
    [shareBuilder setContentDeepLinkID:urlString];
    [shareBuilder setTitle:itemTitle description:descriptionText thumbnailURL:artworkUrl];
    
    [shareBuilder open];
}

- (void)finishedSharingWithError:(NSError *)error {
    NSString *text;
    
    if (!error) {
        text = @"Success";
    } else if (error.code == kGPPErrorShareboxCanceled) {
        text = @"Canceled";
    } else {
        text = [NSString stringWithFormat:@"Error (%@)", [error localizedDescription]];
    }
    
    //NSLog(@"Status: %@", text);
}

#pragma mark -
#pragma Message Handling
- (void) shareToSMSforViewWithUrlString:(NSString *) aUrlToShareStr withDescriptionText:(NSString *) aDescriptionStr{
    if (![MFMessageComposeViewController canSendText]){
        // Show Alert !! mail is not configured
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:GAANA_APP_MANAGER_SMS_NOTCONFIGURED
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSMutableDictionary* navBarTitleAttributes = [[UINavigationBar appearance] titleTextAttributes].mutableCopy;
    UIFont* navBarTitleFont = navBarTitleAttributes[UITextAttributeFont];
    navBarTitleAttributes[UITextAttributeFont] = [UIFont systemFontOfSize:navBarTitleFont.pointSize];
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleAttributes];
    MFMessageComposeViewController *_smsController = [[MFMessageComposeViewController alloc] init];
    //    self.smsController = _smsController1;
    
    _messageComposer = _smsController;
    NSString *descriptionText = aDescriptionStr;
    
    if (aUrlToShareStr && [aUrlToShareStr isKindOfClass:[NSString class]]) {
        NSString *string = aUrlToShareStr;

        //        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
            //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSString *message= [NSString stringWithFormat:@"%@ here: %@",descriptionText, string];
            _smsController.body = message;
            _smsController.messageComposeDelegate=self;
            _smsController.wantsFullScreenLayout = TRUE;
            
            UIWindow* window = [UIApplication sharedApplication].keyWindow;
            if (!window) {
                window = [[UIApplication sharedApplication].windows objectAtIndex:0];
                
            }
            [window addSubview:_messageComposer.view];
            _smsController.navigationBar.barStyle = UIBarStyleDefault;
            //    _smsController.navigationBar.tintColor = RGBA(249, 162,28, 1);
            navBarTitleAttributes[UITextAttributeFont] = navBarTitleFont;
            [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleAttributes];
        //  }];
        
    }
    else{

        _smsController.body = descriptionText;
        _smsController.messageComposeDelegate=self;
        _smsController.wantsFullScreenLayout = TRUE;
        
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        if (!window) {
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
            
        }
        [window addSubview:_messageComposer.view];
        _smsController.navigationBar.barStyle = UIBarStyleDefault;
        //    _smsController.navigationBar.tintColor = RGBA(249, 162,28, 1);
        navBarTitleAttributes[UITextAttributeFont] = navBarTitleFont;
        [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleAttributes];
        
    }

   // NSURL *urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [_messageComposer.view removeFromSuperview];
    switch (result) {
        case MessageComposeResultCancelled:
        case MessageComposeResultSent:
            break;
        case MessageComposeResultFailed:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:GAANA_APP_MANAGER_SENDMESSAGE_COMPOSEFAILED
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 
#pragma mark Mail Handling
- (void) shareToEMailWithSubject:(NSString *) mailSubjectStr withEmailBody:(NSString *) mailBodyStr isBodyContainsHTMl:(BOOL) isHtml onView:(UIViewController *)parentViewCont withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock{
    if (![MFMailComposeViewController canSendMail]){
        // Show Alert !! mail is not configured
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:GAANA_APP_MANAGER_SENDMESSAGE_NOTCONFIGURED
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary* navBarTitleAttributes = [[UINavigationBar appearance] titleTextAttributes].mutableCopy;
    UIFont* navBarTitleFont = navBarTitleAttributes[UITextAttributeFont];
    navBarTitleAttributes[UITextAttributeFont] = [UIFont systemFontOfSize:navBarTitleFont.pointSize];
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleAttributes];
    MFMailComposeViewController *_mailController = [[MFMailComposeViewController alloc] init];
    _mailComposeView = _mailController;
//    self.mailController = _mailController1;
    
    //Sample body :------ Body: "Listen to [SONG X] from the album [ALBUM Y] on Gaana. [new paragraph] [URL] [new paragraph] Sent from Gaana on iPhone. Visit Gaana.com from your phone to download the app."
    
//    NSString *descriptionText = _mailShareItem.itemDescriptionText;
//    
//    NSString *urlString = _mailShareItem.itemShareUrl;
    
//    NSURL *urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    [_mailController setSubject:mailSubjectStr];
    
//    NSString *emailBody = [NSString stringWithFormat:@"%@ on Gaana. </p>%@</p>Sent from Gaana. Visit Gaana.com from your phone to download the app.",descriptionText, urlToShare];
    
    NSString *emailBody = mailBodyStr;
    
    [_mailController setMessageBody:emailBody isHTML:isHtml]; // HTML is also possible
    _mailController.mailComposeDelegate=self;
   _mailController.wantsFullScreenLayout = TRUE;
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        
    }
    [window addSubview:_mailComposeView.view];
    _mailController.navigationBar.barStyle = UIBarStyleDefault;
    _mailController.navigationBar.backgroundColor = RGBA(9, 59, 80, 1);
    _mailController.navigationBar.tintColor = RGBA(9, 59, 80, 1);
    navBarTitleAttributes[UITextAttributeFont] = navBarTitleFont;
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleAttributes];
    //    [_mailController release];
}
// Delegate Method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [_mailComposeView.view removeFromSuperview];
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Mail cancelled"
            //                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //            [alert show];
            //            [alert release];
        }
            break;
        case MFMailComposeResultSaved:
        {
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Mail saved successfully"
            //                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //            [alert show];
            //            [alert release];
        }
            break;
        case MFMailComposeResultSent:
        {
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Mail sent successfully"
            //                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //            [alert show];
            //            [alert release];
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:GAANA_APP_MANAGER_SENDMESSAGE_COMPOSEFAILED
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            //[alert release];
        }
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:GAANA_APP_MANAGER_SENDMESSAGE_UNKNOWN_ERROR
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            //[alert release];
        }
            
            break;
    }
    //[self hideCurrentViewController];
	// [self dismissModalViewControllerAnimated:YES];
	//[parentView dismissModalViewControllerAnimated:YES];
    
	//[parentView dismissModalViewControllerAnimated:YES];
    //[mailController.view removeFromSuperview];
}

#pragma mark Twitter Handling
#pragma mark Twitter Share
- (void) shareToTwitterforView:(UIViewController *) parentController withItemUrl:(NSString *) itemUrl descriptionText:(NSString *) descriptionStr  withCompletionBlock:(void (^) (bool postSuccessful, NSError *error)) completionBlock{
    NSString *descriptionText = descriptionStr;
    NSString *urlString =  itemUrl;
    //NSURL *urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSURL *urlToShare = nil;
    
    if (urlString) {
        urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }

    SLComposeViewController *composerVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [composerVC setInitialText:descriptionText];

    if (urlToShare) {
        [composerVC addURL:urlToShare];
    }

    if (composerVC && parentController && [parentController isKindOfClass:[UIViewController class]]) {
        [parentController presentViewController:composerVC animated:YES completion:nil];
    }

}


#pragma mark-
#pragma mark Facebook Handling
// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
//    FBSessionState sessionState = [FBSession activeSession].state;
//    if (FBSession.activeSession.isOpen) {
//        if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
//            // if we don't already have the permission, then we request it now
//            [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
//                                                  defaultAudience:FBSessionDefaultAudienceFriends
//                                                completionHandler:^(FBSession *session, NSError *error) {
//                                                    if (!error) {
//                                                        action();
//                                                    }
//                                                    //For this example, ignore errors (such as if user cancels).
//                                                }];
//        } else {
//            action();
//        }
//    }else{
//        // Session Not Open
//        FBSession *fbSession = [[FBSession alloc] init];
//        [fbSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
//            if (!error) {
//                [[FBWrapper sharedInstance] setFbSession:session];
////                action();
//            }
//        }];
//    }
}

//- (void) shareToFacebookonParentViewController:(UIViewController *)parentController withTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext clientStateDict:(NSDictionary *) aClientStateDictionary completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
//    FBSessionState sessionState = [FBSession activeSession].state;
//    if (!FBSession.activeSession.isOpen) {
//        // Check if the Token Loaded
//        if (sessionState == FBSessionStateCreatedTokenLoaded) {
//            [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
//                                                                 FBSessionState status,
//                                                                 NSError *error) {
//                // we recurse here, in order to update buttons and labels
//                if (!error) {
//                    [[FBWrapper sharedInstance] setFbSession:session];
//                    [self shareToFacebookonParentViewController:parentController withTitle:title descriptionText:textDescription artwork:artworklink withShareUrl:itemShareUrl withCaption:captiontext clientStateDict:aClientStateDictionary completionBlock:^(bool postSucessful, NSError *error) {
//                        if (error == nil) {
//                            completionBlock (YES,error);
//                        }else{
//                            completionBlock (FALSE,error);
//                        }
//                    }];
//                }
////                [self postFacebookwithObject:parentController andObject:aObject];
//            }];
//            return;
//        }else{
//            [FBSession openActiveSessionWithAllowLoginUI:NO];
//        }
//    }
//    NSString *_descriptionText = textDescription;
//    NSString *_itemTitle = title;
//    NSString *urlString = itemShareUrl;
//    
//    NSURL *urlToShare = nil;
//    
//    if (urlString) {
//        urlToShare = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
//    }
//
//    // If it is available, we will first try to post using the share dialog in the Facebook app
//    NSURL *artworkUrl = nil;
//    if ([artworklink isKindOfClass:[NSString class]]) {
//        artworkUrl = [NSURL URLWithString:artworklink];
//    }
//    FBAppCall *appCall = [FBDialogs presentShareDialogWithLink:urlToShare
//                                                          name:_itemTitle
//                                                       caption:captiontext
//                                                   description:_descriptionText
//                                                       picture:artworkUrl
//                                                   clientState:nil
//                                                       handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//                                                           // Need to Handle the response
//                                                           if (error == nil) {
//                                                               completionBlock (YES,error);
//                                                           }else{
//                                                               completionBlock (false,error);
//                                                           }
//
//                                                           //NSLog(@"%@:",[error localizedDescription]);
//                                                       }];
//    if (!appCall) {
//        // Next try to post using Facebook's iOS6 integration
//        BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:parentController
//                                                                              initialText:_descriptionText
//                                                                                    image:nil
//                                                                                      url:urlToShare
//                                                                                  handler:nil];
//        //        BOOL displayedNativeDialog = FALSE;
//        if (!displayedNativeDialog){
//            [self performPublishAction:^{
//                NSString *_sharingUrl = itemShareUrl;
//                [FBRequestConnection startForPostStatusUpdate:_sharingUrl
//                                            completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                                                //NSLog(@"Error Option:%@",[error localizedDescription]);
//                                                if (error == nil) {
//                                                    completionBlock (YES,error);
//                                                }else{
//                                                    completionBlock (false,error);
//                                                }
//                                            }];
//            }];
//        }
//    }
//}

- (void) shareOnFacebook:(UIViewController *)parentController withTitle:(NSString *) title descriptionText:(NSString *) textDescription artwork:(NSString *) artworklink withShareUrl:(NSString *) itemShareUrl withCaption:(NSString *) captiontext clientStateDict:(NSDictionary *) aClientStateDictionary completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{

//    FBSessionState sessionState = [FBSession activeSession].state;
//    if (!FBSession.activeSession.isOpen) {
//        // Check if the Token Loaded
//        if (sessionState == FBSessionStateCreatedTokenLoaded) {
//            [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
//                                                                 FBSessionState status,
//                                                                 NSError *error) {
//                // we recurse here, in order to update buttons and labels
//                if (!error) {
//                    [[FBWrapper sharedInstance] setFbSession:session];
//                    [self shareOnFacebook:parentController withTitle:title descriptionText:textDescription artwork:artworklink withShareUrl:itemShareUrl withCaption:captiontext clientStateDict:aClientStateDictionary completionBlock:^(bool postSucessful, NSError *error) {
//                        if (error == nil) {
//                            completionBlock (YES,error);
//                        }else{
//                            completionBlock (FALSE,error);
//                        }
//                    }];
//                }
//            }];
//            return;
//        }else{
//            //[FBSession openActiveSessionWithAllowLoginUI:NO];
//            
//            [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
//                
//                if (!error) {
//                    [FBRequestConnection startForPostStatusUpdate:textDescription
//                        completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                            if (!error) {
//                                completionBlock (YES,error);
//                            } else {
//                                completionBlock (FALSE,error);
//                            }
//                        }];
//                }
//                else{
//                    completionBlock (FALSE,error);
//                }
//            }];
//        }
//    }
//    else {
//        [FBRequestConnection startForPostStatusUpdate:textDescription
//                                    completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                                        if (!error) {
//                                            completionBlock (YES,error);
//                                        } else {
//                                            completionBlock (FALSE,error);
//                                        }
//                                    }];
//        
//    }
//    
//    
}


- (void) shareToClipboardWithShareUrl:(NSString *) aUrlString completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *urlString = aUrlString;
    pasteboard.string = urlString;
    
    completionBlock (YES,nil);
}

- (void) shareToWhatsAppWithShareUrl:(NSString *) message completionBlock:(void (^) (bool postSucessful, NSError *error)) completionBlock{

    NSURL *whatsappURL = [NSURL URLWithString:[[NSString stringWithFormat:@"whatsapp://send?text=%@",message] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        completionBlock (YES,nil);

        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
    else{
        completionBlock (NO,nil);
    }
}


- (NSString *) encodeTheURLString : (NSString*) url {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[url UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"%20"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}


@end
