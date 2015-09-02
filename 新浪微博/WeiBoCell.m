//
//  WeiBoCell.m
//  新浪微博
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoCell.h"


#import "WeiBoTopView.h"
#import "WeiBoToolBar.h"
#import "WeiBoFrame.h"
@interface WeiBoCell()

@property(weak,nonatomic) WeiBoTopView *topView;
@property(weak,nonatomic) WeiBoToolBar *toolBar;
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
        
        self.backgroundColor=[UIColor clearColor];
        
        [self setupTopView];
        [self setupBottomView];
    }
    return self;
}

-(void)setCellFrame:(WeiBoFrame *)cellFrame
{
    _cellFrame=cellFrame;
    self.topView.cellFrame=self.cellFrame;
    self.toolBar.frame=self.cellFrame.toolbarViewF;
    self.toolBar.data=self.cellFrame.data;
//    Log(@"**************************%@:%zd",self.cellFrame.data.text,self.cellFrame.data.reposts_count);
}

-(void)setupTopView
{
    WeiBoTopView *topView=[[WeiBoTopView alloc]init];
    [self.contentView addSubview:topView];
    self.topView=topView;
}
-(void)setupBottomView
{
    WeiBoToolBar *toolbar=[[WeiBoToolBar alloc]init];
    [self.contentView addSubview:toolbar];
    self.toolBar=toolbar;
}





@end
