//
//  TopZoneView.h
//  demoPolling
//
//  Created by Kunal Chelani on 5/10/15.
//  Copyright (c) 2015 Kunal Chelani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopZoneView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *topZoneCollectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (assign, nonatomic) NSInteger noOfItems;
@property (nonatomic,strong) NSArray* productsArray;
-(id) initWithFrame: (CGRect)frame andItems: (NSArray*) productArray;

@end
