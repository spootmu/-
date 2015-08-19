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
@interface HomeTableViewController ()<PopViewDelegate>
@property(nonatomic,weak) TitleButton *btnTitle;
//@property(nonatomic,strong) UIImageView *imgPop;
@end

@implementation HomeTableViewController

//-(UIImageView *)imgPop
//{
//    if(!_imgPop)
//    {
//        UIImageView *imgPop=[[UIImageView alloc]init];
//        imgPop.image=[UIImage resizableImageWithName:@"popover_background"];
//        imgPop.w=200;
//        imgPop.h=200;
//        imgPop.cx=self.view.cx;
//        imgPop.y=50;
//        _imgPop=imgPop;
//    }
//    return _imgPop;
//}

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

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCell"];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"row of %zd",indexPath.row];
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
