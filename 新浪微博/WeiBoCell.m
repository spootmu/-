//
//  WeiBoCell.m
//  新浪微博
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoCell.h"
#import "WeiBoFrame.h"
#import "WeiBoData.h"
#import "user.h"
@interface WeiBoCell()
@property(weak,nonatomic) UIView *topView;
@property(weak,nonatomic) UIImageView *imgHead;
@property(weak,nonatomic) UIImageView *imgVip;
@property(weak,nonatomic) UILabel *lblName;
@property(weak,nonatomic) UILabel *lblTime;
@property(weak,nonatomic) UILabel *lblSource;
@property(weak,nonatomic) UILabel *lblContext;
@property(weak,nonatomic) UIView *toolBar;
@property(weak,nonatomic) UIButton *btnZF;
@end
@implementation WeiBoCell

+(instancetype)WeiBoCellWithTableView:(UITableView *)tableView
{
    WeiBoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    
    if(!cell)
    {
        cell=[[WeiBoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"homeCell"];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
        [self setupBottomView];
    }
    return self;
}

-(void)setupData
{
    WeiBoData *data=self.cellFrame.data;
    user *userinfo=data.user;
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:userinfo.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.lblName.text=userinfo.name;
    self.lblTime.text=data.created_at;
    self.lblSource.text=data.source;
    
    self.lblContext.text=data.text;
    
}
-(void)setupFrame
{
    self.imgHead.frame=self.cellFrame.iconViewF;
    self.lblName.frame=self.cellFrame.nameLableF;
    self.imgVip.frame=self.cellFrame.vipViewF;
    self.lblTime.frame=self.cellFrame.timeLabelF;
    self.lblSource.frame=self.cellFrame.sourceViewF;
    self.lblContext.frame=self.cellFrame.contextViewF;
    self.topView.frame=self.cellFrame.topViewF;
    self.toolBar.frame=self.cellFrame.toolbarViewF;
    
}
-(void)setCellFrame:(WeiBoFrame *)cellFrame
{
    _cellFrame=cellFrame;
    [self setupData];
    [self setupFrame];
}
-(void)setupContentView
{
    UIView *topView=[[UIView alloc]init];
    [self.contentView addSubview:topView];
    self.topView=topView;
    
    UIImageView *imgHead=[[UIImageView alloc] init];
    [topView addSubview:imgHead];
    self.imgHead=imgHead;
    
    UIImageView *imgVip=[[UIImageView alloc]init];
    [topView addSubview:imgVip];
    self.imgVip=imgVip;
    
    UILabel *lblName=[[UILabel alloc]init];
    lblName.font=nameFont;
    
    [topView addSubview:lblName];
    self.lblName=lblName;
    
    UILabel *lblTime=[[UILabel alloc]init];
    lblTime.font=timeFont;
    [topView addSubview:lblTime];
    self.lblTime=lblTime;
    
    UILabel *lblSource=[[UILabel alloc]init];
    lblSource.font=sourceFont;
    [topView addSubview:lblSource];
    self.lblSource=lblSource;
    
    UILabel *lblContext=[[UILabel alloc]init];
    lblContext.numberOfLines=0;
    lblContext.font=contextFont;
    [topView addSubview:lblContext];
    self.lblContext=lblContext;
    
    UIView *toolBar=[[UIView alloc]init];
    [self.contentView addSubview:toolBar];
    self.toolBar=toolBar;
}

-(void)setupBottomView
{
    UIView *toolbar=[[UIView alloc]init];
    toolbar.backgroundColor=[UIColor blueColor];
    [self.contentView addSubview:toolbar];
    self.toolBar=toolbar;
}
@end
