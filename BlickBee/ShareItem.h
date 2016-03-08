//
//  ShareItem.h
//  FrostedDemo
//
//  Created by Alok Ranjan on 19/02/14.
//  Copyright (c) 2014 Alok Ranjan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareItem : NSObject
@property (nonatomic,strong) NSString *itemTitle;
@property (nonatomic,strong) NSString *itemDescriptionText;
@property (nonatomic,strong) NSString *itemArtwork;
@property (nonatomic,strong) NSString *itemShareUrl;
@end
