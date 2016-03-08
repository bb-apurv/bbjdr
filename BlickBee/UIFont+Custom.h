//
//  UIFont+Custom.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Custom)

+(UIFont*) getProximaNovaLightWithSize:(CGFloat)size;
+(UIFont*) getProximaNovaBoldWithSize:(CGFloat)size;
+(UIFont*) getProximaNovaSemiBoldWithSize:(CGFloat)size;
+(UIFont*) getRobotoThinWithSize:(CGFloat)size;
+(UIFont*) getRobotoCondensedWithSize:(CGFloat)size;
+(UIFont*) getRobotoLightWithSize:(CGFloat)size;
+(UIFont*) getRobotoBoldWithSize:(CGFloat)size;
+(UIFont*) getRobotoRegularWithSize:(CGFloat)size;
+(UIFont*) getRobotoMediumWithSize:(CGFloat)size;

@end
