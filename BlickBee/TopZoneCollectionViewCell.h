//
//  TopZoneCollectionViewCell.h
//  gotg
//
//  Created by Kunal Chelani on 6/20/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
@interface TopZoneCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) Offer *offer;

-(void) bindItemData :(Offer*) itemData;


@end
