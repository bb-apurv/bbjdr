//
//  TopZoneView.m
//  demoPolling
//
//  Created by Kunal Chelani on 5/10/15.
//  Copyright (c) 2015 Kunal Chelani. All rights reserved.
//

#import "TopZoneView.h"
#import "TopZoneCollectionViewCell.h"
@implementation TopZoneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id) initWithFrame: (CGRect)frame andItems:(NSArray *)productArray
{
    self=[super initWithFrame:frame];
    if (self) {
        self.noOfItems=productArray.count;
        self.productsArray=productArray;
        [self initCollectionView];
        [self initPageControl];
    }
    return self;
}

-(void) initCollectionView
{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.topZoneCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    [self.topZoneCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.topZoneCollectionView.delegate=self;
    self.topZoneCollectionView.dataSource=self;
    self.topZoneCollectionView.backgroundColor=[UIColor whiteColor];
    self.topZoneCollectionView.showsHorizontalScrollIndicator = NO;
    self.topZoneCollectionView.pagingEnabled = YES;
    [self.topZoneCollectionView registerNib:[UINib nibWithNibName:@"TopZoneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TopZoneCollectionViewCell"];
    [self addSubview:self.topZoneCollectionView];
}

-(void) initPageControl
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    // Set up the page control
    CGRect frame = CGRectMake(0, h - 60, w, 60);
    self.pageControl = [[UIPageControl alloc]
                        initWithFrame:frame
                        ];
    
    // Add a target that will be invoked when the page control is
    // changed by tapping on it
    [self.pageControl
     addTarget:self
     action:@selector(pageControlChanged:)
     forControlEvents:UIControlEventValueChanged
     ];
    
    // Set the number of pages to the number of pages in the paged interface
    // and let the height flex so that it sits nicely in its frame
    self.pageControl.numberOfPages = self.productsArray.count;
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageControl];
}

- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.topZoneCollectionView.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
    [self.topZoneCollectionView setContentOffset:scrollTo animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.topZoneCollectionView.frame.size.width;
    self.pageControl.currentPage = self.topZoneCollectionView.contentOffset.x / pageWidth;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.productsArray.count;
}

- (UIViewController *)getViewController {
    UIResponder *nextResponderView = [self nextResponder];
    while (![nextResponderView isKindOfClass:[UIViewController class]]) {
        nextResponderView = [nextResponderView nextResponder];
        if (nil == nextResponderView) {
            break;
        }
    }
    return (UIViewController *)nextResponderView;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}




- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


/*
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath;
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath; // called when the user taps on an already-selected item in multi-select mode
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
 
 - (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
 */

// Method to Overrite
- (TopZoneCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopZoneCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"TopZoneCollectionViewCell"
                                              forIndexPath:indexPath];//    [cell setBackgroundColor:[UIColor redColor]];
    [cell bindItemData:[self.productsArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
