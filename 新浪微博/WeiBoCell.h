//
//  WeiBoCell.h
//  新浪微博
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiBoData;
@class WeiBoFrame;
@interface WeiBoCell : UITableViewCell
@property(nonatomic,strong) WeiBoData *data;
@property(nonatomic,strong) WeiBoFrame *cellFrame;
+(instancetype)WeiBoCellWithTableView:(UITableView *)tableView;
@end
