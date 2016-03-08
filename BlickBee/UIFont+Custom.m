//
//  UIFont+Custom.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "UIFont+Custom.h"

@implementation UIFont (Custom)

/*
 "ProximaNova-Light",
 "ProximaNova-Bold",
 "ProximaNova-Semibold"
 "Roboto-Thin",
 "Roboto-Condensed",
 "Roboto-Light",
 "Roboto-Bold",
 "Roboto-Regular",
 "Roboto-Medium"
 */


+(UIFont*) getProximaNovaLightWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"ProximaNova-Light" size:size];
}
+(UIFont*) getProximaNovaBoldWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"ProximaNova-Bold" size:size];
}
+(UIFont*) getProximaNovaSemiBoldWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
}
+(UIFont*) getRobotoThinWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"Roboto-Thin" size:size];
}
+(UIFont*) getRobotoCondensedWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"Roboto-Condensed" size:size];
}
+(UIFont*) getRobotoLightWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"Roboto-Light" size:size];
}
+(UIFont*) getRobotoBoldWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"Roboto-Bold" size:size];
}
+(UIFont*) getRobotoRegularWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"Roboto-Regular" size:size];
}
+(UIFont*) getRobotoMediumWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"Roboto-Medium" size:size];
}


@end
