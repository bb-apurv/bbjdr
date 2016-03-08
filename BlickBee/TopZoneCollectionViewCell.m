//
//  TopZoneCollectionViewCell.m
//  gotg
//
//  Created by Kunal Chelani on 6/20/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import "TopZoneCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation TopZoneCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

-(void) bindItemData :(Offer*) itemData
{
    self.offer = itemData;
    [self bindImageFor:itemData.offerBanner];
}

-(void) bindImageFor:(NSString*) imageUrl
{
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [self.bgImageView setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"cardLayout.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [self.bgImageView setContentMode:UIViewContentModeScaleToFill];
        if (!request) // image was cached
            [self.bgImageView setImage:image];
        else
            [UIView transitionWithView:self.bgImageView
                              duration:1.0f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.bgImageView.image = image;
                                
                            } completion:NULL];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
}

@end
