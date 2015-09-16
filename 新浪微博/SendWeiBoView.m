//
//  SendWeiBoView.m
//  新浪微博
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "SendWeiBoView.h"
#import "SendTV.h"
@implementation SendWeiBoView
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupNavButton];
    [self setupTxt];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //ios8下必须在这里设置按钮，否则无效
    self.navigationItem.rightBarButtonItem.enabled=false;
}

-(void)setupTxt
{
    SendTV *tvmsg=[[SendTV alloc]init];
    tvmsg.w=[UIScreen mainScreen].bounds.size.width;
    tvmsg.h=200;
    tvmsg.x=0;
    tvmsg.y=0;
    
    [self.view addSubview:tvmsg];
}

-(void)setupNavButton
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.title=@"发微博";
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send
{
    
}
@end
