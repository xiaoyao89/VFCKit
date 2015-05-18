//
//  VFCTutorialViewController.m
//  VFCKit

#import "VFCTutorialViewController.h"

#pragma mark - VFCTutorialView

#pragma mark - Private Interface

@interface VFCTutorialView : UIView
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *label;
@end

#pragma mark - Private Implementation

@implementation VFCTutorialView

#pragma mark Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        UIImageView *imageView = [UIImageView newAutoLayoutView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView = imageView;
        [self addSubview:imageView];
        
        UILabel *label = [UILabel newAutoLayoutView];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:17.0];
        label.numberOfLines = 2;
        self.label = label;
        [self addSubview:label];
        
        [UIView autoSetPriority:999.0 forConstraints:^{
            [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            [imageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
            [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
            
            [label autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            [label autoPinEdgeToSuperviewEdge:ALEdgeRight];
            [label autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            
            [imageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:label];
        }];
    }
    return self;
}

@end

#pragma mark - VFCTutorialViewController

#pragma mark - Private Interface

@interface VFCTutorialViewController () <UIScrollViewDelegate>
@property (nonatomic, strong, readwrite) NSArray *tutorialPages;
@property (nonatomic, strong, readwrite) UIPageControl *pageControl;
@end

#pragma mark - Public Implementation

@implementation VFCTutorialViewController

#pragma mark Lifestyle

- (instancetype)initWithArray:(NSArray *)pageDictionaries {
    self = [super init];
    if (self) {
        _tutorialPages = pageDictionaries;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [UIScrollView newAutoLayoutView];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    for (NSDictionary *tutorialDict in self.tutorialPages) {
        VFCTutorialView *tutorialView = [VFCTutorialView newAutoLayoutView];
        tutorialView.label.text = tutorialDict[@"text"];
        tutorialView.imageView.image = [UIImage imageNamed:tutorialDict[@"imageName"]];
        [scrollView addSubview:tutorialView];
    }
    
    UIPageControl *pageControl = [UIPageControl newAutoLayoutView];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.numberOfPages = self.tutorialPages.count;
    pageControl.currentPage = 0;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
    UIButton *button = [UIButton newAutoLayoutView];
    [button setTitleColor:[UIColor interactiveColor] forState:UIControlStateNormal];
    [button setTitle:@"DISMISS" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:button];
    
    [UIView autoSetPriority:999.0 forConstraints:^{
        [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [scrollView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        NSArray *subviews = scrollView.subviews;
        for (VFCTutorialView *tutorialView in subviews) {
            [tutorialView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:scrollView];
            [tutorialView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:scrollView];
        }
        
        [subviews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0.0 insetSpacing:NO matchedSizes:YES];
        
        [pageControl autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [pageControl autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [pageControl autoSetDimension:ALDimensionHeight toSize:30.0];
        
        [button autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [button autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [button autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [button autoSetDimension:ALDimensionHeight toSize:30.0];
        
        [scrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:pageControl withOffset:-15.0];
        [pageControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:button];
    }];
}

#pragma mark Private

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint offset = *targetContentOffset;
    NSInteger page = (offset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = page;
}

@end
