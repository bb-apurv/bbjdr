//
//  BaseServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseServiceClient.h"

@implementation BaseServiceClient

-(NSURL*) getBaseURL{
    
    return [NSURL URLWithString:BASE_URL_STRING];
}
-(void) printApi:(NSURL*)url{
    NSLog(@"API --- %@",url.absoluteString);
    
}
-(void) showNoNetworkAlert
{
    [[[UIAlertView alloc] initWithTitle:@"Network not available." message:@"Please check your network connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}
- (NSError *) returnErrorWithString:(NSString *) aErrorMessage{
    NSMutableDictionary *_dictionary = [NSMutableDictionary dictionary];
    if (aErrorMessage) {
        [_dictionary setObject:aErrorMessage forKey:NSLocalizedDescriptionKey];
    }
    NSError *error = [NSError errorWithDomain:@"com.gaana.localerror" code:500 userInfo:_dictionary];
    return error;
}

- (NSError *) returnErrorWithString:(NSString *) aErrorMessage andCode:(NSInteger) code {
    NSMutableDictionary *_dictionary = [NSMutableDictionary dictionary];
    [_dictionary setObject:aErrorMessage forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"com.gaana.localerror" code:code userInfo:_dictionary];
    return error;
}
- (void) showAlertWithErrorMsg :(NSString*)msg{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

@end
