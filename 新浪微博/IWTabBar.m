//
//  IWTabBar.m
//  新浪微博
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"
@interface IWTabBar()
@property(nonatomic,weak) UIButton *btnCenter;
@property(nonatomic,strong) NSMutableArray *arrBtns;
@property(nonatomic,weak) IWTabBarButton *btnSelNow;
@end
@implementation IWTabBar

-(NSMutableArray *)arrBtns
{
    if(!_arrBtns)
    {
        _arrBtns=[NSMutableArray array];
    }
    return _arrBtns;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        
    }
    return self;
}
-(void)addTabBarButton:(UITabBarItem *)item
{
    IWTabBarButton *btn=[[IWTabBarButton alloc]init];
    btn.item=item;
    [self addSubview:btn];
//    btn.tag=self.arrBtns.count;
    [self.arrBtns addObject:btn];
    
    [btn addTarget:self action:@selector(btnOther_Click:) forControlEvents:UIControlEventTouchDown];
    
    //必须在这设置选中
    if(self.arrBtns.count==1)
    {
        [self btnOther_Click:btn];
    }
    
}
-(void)btnOther_Click:(IWTabBarButton*)btn
{
    if([self.delegate respondsToSelector:@selector(IWTabBar:selectButtonTagFrom:selectButtonTagTo:)])
    {
        [self.delegate IWTabBar:self selectButtonTagFrom:self.btnSelNow.tag selectButtonTagTo:btn.tag];
    }
    self.btnSelNow.selected=NO;
    btn.selected=YES;
    self.btnSelNow=btn;
}
-(void)setupCenterBtn
{
     UIButton *btnCenter=[[UIButton alloc]init];
    [btnCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btnCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    [btnCenter setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [btnCenter setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    [self addSubview:btnCenter];
    self.btnCenter=btnCenter;
}

-(void)setupCenterBtnFrame
{
    CGSize btnSize=self.btnCenter.currentBackgroundImage.size;
    self.btnCenter.w=btnSize.width;
    self.btnCenter.h=btnSize.height;
    self.btnCenter.cx=self.w*0.5;
    self.btnCenter.cy=self.h*0.5;
}

-(UIButton *)btnCenter
{
    if (_btnCenter == nil) {
        UIButton *btnCenter = [[UIButton alloc] init];
        // 1.2.设置背景图片
        [btnCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btnCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 1.3.设置图标
        [btnCenter setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btnCenter setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        // 1.4.添加
        [self addSubview:btnCenter];
        _btnCenter = btnCenter;
        
    }
    return _btnCenter;
}
-(void)setupOtherBtnFrame
{
    for (int i=0; i<self.arrBtns.count; i++) {
        IWTabBarButton *btn=self.arrBtns[i];
        btn.w=self.w/(self.arrBtns.count+1);
        btn.h=self.h;
        btn.y=0;
        btn.tag=i;
        if(i>=self.arrBtns.count/2)
        {
            btn.x=(i+1)*btn.w;
        }
        else
        {
            btn.x=i*btn.w;
        }
        
//        if(i==0)
//        {
//            [self btnOther_Click:btn];
//        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setupCenterBtnFrame];
    [self setupOtherBtnFrame];
}
@end
