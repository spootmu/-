//
//  HomeTableViewController.m
//  新浪微博//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "HomeTableViewController.h"
#import "TitleButton.h"
#import "PopView.h"

#import "Tools.h"
#import "WeiBoCell.h"
#import "WeiBoFrame.h"
@interface HomeTableViewController ()<PopViewDelegate>
@property(nonatomic,weak) TitleButton *btnTitle;
@property(nonatomic,strong) NSMutableArray *WeiboDataFrame;
@property(nonatomic,weak)UIRefreshControl *refresh;
@end

@implementation HomeTableViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self setupBarButton];
    [self setupTitleButton];
    [self loadWeiBoData];
    [self setupRefresh];
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 10, 0);
    
    
}


-(void)setupRefresh
{
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadWeiBoData)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/**
 *  More
 */
-(void)loadMoreData
{
    /**
     *  重置badge
     */
    self.tabBarItem.badgeValue=@"0";
    
    //设置app提醒数字
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    WeiBoFrame *lastData=[self.WeiboDataFrame lastObject];
    
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=[Tools ReadAccount].access_token;
    parameters[@"count"]=@(30);
    parameters[@"max_id"]=@(lastData.data.idstr.longLongValue-1);
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *dicArray=responseObject[@"statuses"];
        NSArray *newData=[WeiBoData objectArrayWithKeyValuesArray:dicArray];
        NSMutableArray *arrFrame=[NSMutableArray arrayWithCapacity:newData.count];
        
        for (WeiBoData *data in newData) {
            WeiBoFrame *frame=[[WeiBoFrame alloc]init];
            frame.data=data;
            [arrFrame addObject:frame];
        }
        
        [self.WeiboDataFrame addObjectsFromArray:arrFrame];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}

-(NSMutableArray *)WeiboDataFrame
{
    if(!_WeiboDataFrame)
    {
        _WeiboDataFrame=[NSMutableArray array];
    }
    return _WeiboDataFrame;
}

-(void)loadWeiBoData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    
    parameters[@"access_token"]=[Tools ReadAccount].access_token;
    parameters[@"count"]=@(30);
    
    WeiBoFrame *firstData=[self.WeiboDataFrame firstObject];
    if(firstData)
    {
        parameters[@"since_id"]=firstData.data.idstr;
    }

    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *dicArray=responseObject[@"statuses"];
//        Log(@"%@",dicArray);
        NSArray *newData=[WeiBoData objectArrayWithKeyValuesArray:dicArray];
        
        NSMutableArray *arrTemp=[NSMutableArray array];
        
        NSMutableArray *arrFrame=[NSMutableArray arrayWithCapacity:newData.count];
        
        for (WeiBoData *data in newData) {
            WeiBoFrame *frame=[[WeiBoFrame alloc]init];
            frame.data=data;
            [arrFrame addObject:frame];
        }
        
        [arrTemp addObjectsFromArray:arrFrame];
        [arrTemp addObjectsFromArray:self.WeiboDataFrame];
        self.WeiboDataFrame=arrTemp;
//        NSLog(@"%@",responseObject[@"statuses"]);
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
        //提示
        [self showStatusCount:arrFrame.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        Log(@"%@",error);
        [self.tableView.header endRefreshing];
    }];
}

-(void)showStatusCount:(NSInteger) count
{
    UILabel *lblInfo=[[UILabel alloc]init];
    [lblInfo setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]]];
    lblInfo.w=[UIScreen mainScreen].bounds.size.width;
    lblInfo.h=35;
    lblInfo.x=0;
    lblInfo.y=64-lblInfo.h;
    lblInfo.textAlignment=NSTextAlignmentCenter;
    lblInfo.textColor=[UIColor whiteColor];
    lblInfo.alpha=0;
    if(count>0)
    {
        lblInfo.text=[NSString stringWithFormat:@"更新了%zd条新消息",count];
    }
    else
    {
        lblInfo.text=@"暂无新消息";
    }
    [self.navigationController.view insertSubview:lblInfo belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.5 animations:^{
        lblInfo.alpha=1;
        lblInfo.transform=CGAffineTransformMakeTranslation(0, lblInfo.h);
    } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
                lblInfo.transform=CGAffineTransformIdentity;
                lblInfo.alpha=0;
            } completion:^(BOOL finished) {
                [lblInfo removeFromSuperview];
            }];
        }];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.btnTitle setSelected:NO];
//    [self.imgPop removeFromSuperview];
}
-(void)setupTitleButton
{
    TitleButton *tb=[[TitleButton alloc]init];
    [tb setTitle:@"xxdddddx" forState:UIControlStateNormal];
    [tb setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [tb setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];

    [tb addTarget:self action:@selector(TitleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=tb;
    self.btnTitle=tb;
}
-(void)TitleButtonClick
{
    [self.btnTitle setSelected:YES];
    self.tableView.scrollEnabled=NO;
    
    PopView *popv=[[PopView alloc]initWithContentView:[[UISwitch alloc]init]];
    [popv showWithRect:CGRectMake(self.view.center.x-100, 50, 200, 200)];
    popv.delegate=self;
}

-(void)PopViewdidDismiss:(PopView *)popMenu
{
    [self.btnTitle setSelected:NO];
    self.tableView.scrollEnabled=YES;
}

-(void)LeftClick
{
    [self.btnTitle setTitle:@"weiwiewieiweisddfffsw" forState:UIControlStateNormal];
}
-(void)RightClick
{
    
}
-(void)setupBarButton
{
    
   UIBarButtonItem *itemLeft= [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_friendsearch" highlightImageName:@"navigationbar_friendsearch_highlighted" target:self sel:@selector(LeftClick)];
    
    UIBarButtonItem *itemRight= [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_pop" highlightImageName:@"navigationbar_pop_highlighted" target:self sel:@selector(RightClick)];

    self.navigationItem.leftBarButtonItem=itemLeft;
    self.navigationItem.rightBarButtonItem=itemRight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.WeiboDataFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiBoFrame *dic=self.WeiboDataFrame[indexPath.row];
    WeiBoCell *cell=[WeiBoCell WeiBoCellWithTableView:tableView];
    cell.cellFrame=dic;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc=[[UIViewController alloc]init];
    vc.view.backgroundColor=[UIColor redColor];
    vc.title=[NSString stringWithFormat:@"row of %zd",indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiBoFrame *cellFrame=self.WeiboDataFrame[indexPath.row];
    return cellFrame.cellHeght;
}

-(void)tabRefreshClick
{
    if(self.tabBarItem.badgeValue.integerValue>0)
       [self.tableView.header beginRefreshing];
}

@end
