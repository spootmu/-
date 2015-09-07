//
//  WeiBoTopView.m
//  新浪微博
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoTopView.h"
#import "WeiBoOriginalView.h"
#import "WeiBoRepostView.h"
#import "WeiBoFrame.h"
@interface WeiBoTopView()
@property(weak,nonatomic)WeiBoOriginalView *originalView;
@property(weak,nonatomic)WeiBoRepostView *repostView;
@end

@implementation WeiBoTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor whiteColor];
        self.image=[UIImage resizableImageWithName:@"timeline_card_top_background"];
        WeiBoOriginalView *originalView=[[WeiBoOriginalView alloc]init];
        [self addSubview: originalView];
        self.originalView=originalView;
        
        WeiBoRepostView *repostView=[[WeiBoRepostView alloc]init];
        [self addSubview:repostView];
        self.repostView=repostView;
        
        self.userInteractionEnabled=YES;
    }
    return self;
}

-(void)setCellFrame:(WeiBoFrame *)cellFrame
{
    _cellFrame=cellFrame;
    self.frame=self.cellFrame.topViewF;
    self.originalView.cellFrame=self.cellFrame;
    self.repostView.cellFrame=self.cellFrame;
}
@end
