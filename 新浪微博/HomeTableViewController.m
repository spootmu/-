//
//  HomeTableViewController.m
//  新浪微博
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "HomeTableViewController.h"
#import "TitleButton.h"
#import "PopView.h"
#import "Tools.h"
@interface HomeTableViewController ()<PopViewDelegate>
@property(nonatomic,weak) TitleButton *btnTitle;
@property(nonatomic,strong) NSMutableArray *WeiboData;
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
    
    [self setupBarButton];
    [self setupTitleButton];
    [self loadWeiBoData];
    
    [self setupRefresh];
}


-(void)setupRefresh
{
    UIRefreshControl *refresh=[[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview: refresh];
    
}
-(void)refreshData:(UIRefreshControl*)refresh
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    WeiBoData *firstData=[self.WeiboData firstObject];
    parameters[@"access_token"]=[Tools ReadAccount].access_token;
    parameters[@"since_id"]=firstData.idstr;
    parameters[@"count"]=@(30);
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *arrTemp=[NSMutableArray array];
        [arrTemp addObjectsFromArray:[WeiBoData objectArrayWithKeyValuesArray:responseObject[@"statuses"]]];
        [arrTemp addObjectsFromArray:self.WeiboData];
       
        self.WeiboData=arrTemp;
        [self.tableView reloadData];
        [refresh endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [refresh endRefreshing];
    }];
}
-(NSMutableArray *)WeiboData
{
    if(!_WeiboData)
    {
        _WeiboData=[NSMutableArray array];
    }
    return _WeiboData;
}
-(void)loadWeiBoData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    
    parameters[@"access_token"]=[Tools ReadAccount].access_token;
    parameters[@"count"]=@(30);
    
    WeiBoData *firstData=[self.WeiboData firstObject];
    if(firstData)
    {
        parameters[@"since_id"]=firstData.idstr;
    }

    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        [arrTemp addObjectsFromArray:[WeiBoData objectArrayWithKeyValuesArray:responseObject[@"statuses"]]];
        
        self.WeiboData=arrTemp;
        NSLog(@"%@",responseObject[@"statuses"]);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Log(@"%@",error);
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

    return self.WeiboData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"homeCell"];
    }
    
    
//    profile_image_url
    WeiBoData *dic=self.WeiboData[indexPath.row];
   
    cell.detailTextLabel.text=dic.text;
    cell.textLabel.text=dic.user.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc=[[UIViewController alloc]init];
    vc.view.backgroundColor=[UIColor redColor];
    vc.title=[NSString stringWithFormat:@"row of %zd",indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
