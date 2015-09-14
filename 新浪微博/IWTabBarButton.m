//
//  IWTabBarButton.m
//  新浪微博
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "IWTabBarButton.h"
#define btnPer 0.6

@interface IWTabBarButton()
@property(weak,nonatomic)UIButton *btnBadge;
@end

@implementation IWTabBarButton

-(void)setItem:(UITabBarItem *)item
{
    _item=item;
    [self setTitle:item.title forState:UIControlStateNormal];
    // 设置默认状态的图片
    [self setImage:item.image forState:UIControlStateNormal];
    // 设置选中状态的图片
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    /**
     *  kvo
     */
    [_item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
}

/**
 *  kov
 *当监听对象的属性改变，调用这个方法
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    Log(@"kvo");
    
    NSString *val=self.item.badgeValue;
    
    if(val.integerValue)
    {
        self.btnBadge.hidden=NO;
    }
    
    if(val.integerValue==0)
    {
        self.btnBadge.hidden=YES;
    }
    
    if(val.integerValue>99)
    {
        val=@"n";
    }
    [self.btnBadge setTitle:self.item.badgeValue forState:UIControlStateNormal];
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*btnPer);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,contentRect.size.height*btnPer, contentRect.size.width, contentRect.size.height-(contentRect.size.height*btnPer));
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.imageView.contentMode=UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [self setupBadge];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.btnBadge.x=self.w-self.btnBadge.w-5;
    self.btnBadge.y=0;
}

-(void)setupBadge
{
    UIButton *btnBadge=[[UIButton alloc]init];
    [btnBadge setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    btnBadge.size=btnBadge.currentBackgroundImage.size;
    btnBadge.titleLabel.font=[UIFont systemFontOfSize:10];
    [self addSubview:btnBadge];
    self.btnBadge=btnBadge;
    btnBadge.hidden=YES;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}
@end
