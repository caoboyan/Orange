//
//  WelcomeViewController.m
//  Candy2
//
//  Created by Aiwa on 12/24/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "WelcomeViewController.h"



//#import "SsettingEngine.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
{
    UIView* _welcomeView;
    UIScrollView* _scrollView;
    UIPageControl* _page;
    UIButton* _closeBtn;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

-(void) initViews
{
    _welcomeView = [[UIView alloc] initWithFrame:self.view.bounds];
    _welcomeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_welcomeView];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_W, K_SCREEN_H)];
    _scrollView.contentSize = CGSizeMake(K_SCREEN_W*3, K_SCREEN_H);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    for (int i=0; i<3; i++) {
        UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(K_SCREEN_W*i, 0, K_SCREEN_W, K_SCREEN_H)];
        img.backgroundColor = [UIColor orangeColor];
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%d",i+1]];
        [_scrollView addSubview:img];
    }
    UIButton* submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.titleLabel.font = [UIFont systemFontOfSize:13];
    submit.frame = CGRectMake(K_SCREEN_W*2 + (K_SCREEN_W-157)/2, 0, 157, 36);
    submit.wbtBottom = K_SCREEN_H-77;
    submit.backgroundColor = [UIColor orangeColor];
    [submit setTitle:@"Welcome to Oranger" forState:UIControlStateNormal];
    submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius = 7.0f;
    [_scrollView addSubview:submit];
    _scrollView.delegate = self;
    [submit addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, K_SCREEN_H-40, K_SCREEN_W, 20)];
    _page.pageIndicatorTintColor = [UIColor wbt_colorWithHexValue:0xBBBBBB alpha:1];
    _page.currentPageIndicatorTintColor = [UIColor wbt_colorWithHexValue:0x7C7C7C alpha:1];
    _page.numberOfPages = 3;
    [self.view addSubview:_page];
    
    _page.currentPage = 0 ;
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
     [_welcomeView setHidden:NO];
}




-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int idx = scrollView.contentOffset.x/K_SCREEN_W;
    _page.currentPage = idx;
}


-(void) closePage
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KEY_WELCOME_MODIFY" object:@{@"flag":@"over"}];
}

@end
