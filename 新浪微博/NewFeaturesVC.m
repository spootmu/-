//
//  NewFeaturesVC.m
//  新浪微博
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "NewFeaturesVC.h"
#import "MainTabbarControl.h"
#import "OAuthVC.h"
#import "OAuthData.h"
@interface NewFeaturesVC ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *sv;
@property(nonatomic,strong)NSMutableArray *imgList;
@property(nonatomic,weak)UIPageControl *page;

@end

@implementation NewFeaturesVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupScrollView];
    [self setupPageControl];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)setupPageControl
{
    //不需要设置大小，此控件大小自动
    UIPageControl *page=[[UIPageControl alloc]init];
    page.cx=self.view.cx;
    page.cy=self.view.h-30;
    page.pageIndicatorTintColor=[UIColor greenColor];
    page.currentPageIndicatorTintColor=[UIColor redColor];
    page.numberOfPages=4;
    [self.view addSubview:page];
    self.page=page;
}
-(void)setupScrollView
{
    CGFloat imgW=[UIScreen mainScreen].bounds.size.width;
    CGFloat imgH=[UIScreen mainScreen].bounds.size.height;
    CGFloat imgY=0;
    
    UIScrollView *sv=[[UIScrollView alloc]init];
    sv.backgroundColor=[UIColor redColor];
    sv.frame=self.view.bounds;
    sv.delegate=self;
    sv.pagingEnabled=YES;
    sv.showsHorizontalScrollIndicator=NO;
    sv.bounces=NO;
    [self.view addSubview:sv];
    self.sv=sv;
    
    for (int i=0; i<4; i++) {
        NSString *imgName=[NSString stringWithFormat:@"new_feature_%d",i+1];
        CGFloat imgX=imgW*i;
        UIImageView *imgv=[[UIImageView alloc]init];
        imgv.image=[UIImage imageNamed:imgName];
        imgv.frame=CGRectMake(imgX, imgY, imgW, imgH);
        [self.sv addSubview:imgv];
        if(i==3)
        {
            imgv.userInteractionEnabled=YES;
            [self setupLastPage:imgv];
        }
    }
    self.sv.contentSize=CGSizeMake(imgW*4, imgH);
}


-(void)setupLastPage:(UIImageView *)iv
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setTitle:@"开始使用" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    btn.w=100;
    btn.h=35;
    btn.cx=self.view.cx;
    btn.cy=self.view.h-100;
    [iv addSubview:btn];
    [btn addTarget:self action:@selector(goIndex) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnCheck=[[UIButton alloc]init];
    [btnCheck setTitle:@"分享给大家" forState:UIControlStateNormal];
    [btnCheck setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCheck setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [btnCheck setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    btnCheck.w=120;
    btnCheck.h=35;
    btnCheck.cx=self.view.cx;
    btnCheck.cy=self.view.h-150;
    [iv addSubview:btnCheck];
    [btnCheck addTarget:self action:@selector(cheSel:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)cheSel:(UIButton*)btn
{
    if(btn.selected)
    {
        btn.selected=NO;
    }
    else
    {
        btn.selected=YES;
    }
}
-(void)goIndex
{
    NSString *path=AccountFile;
    OAuthData *account= [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if(account)
    {
        [UIApplication sharedApplication].keyWindow.rootViewController=[[MainTabbarControl alloc]init];
    }
    else{
        OAuthVC *oauth=[[OAuthVC alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController=oauth;
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page=scrollView.contentOffset.x/scrollView.frame.size.width;
    self.page.currentPage=page;
    Log(@"%zd",page);
}


@end
