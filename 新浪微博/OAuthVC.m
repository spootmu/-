//
//  OAuthVC.m
//  新浪微博
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "OAuthVC.h"
#import "OAuthData.h"
#import "MainTabbarControl.h"
#import "Tools.h"
@interface OAuthVC ()<UIWebViewDelegate>
@property(nonatomic,weak)UIWebView *webOAuth;
@end

@implementation OAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *key=@"1616074629";
    NSString *backUrl=@"http://ios.itcast.cn";
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",key,backUrl]]];
    [self.webOAuth loadRequest:req];
}

-(void)loadView
{
    UIWebView *webOAuth=[[UIWebView alloc]init];
    self.view=webOAuth;
    self.webOAuth=webOAuth;
    self.webOAuth.delegate=self;
}

-(void)accessToken:(NSString *)token
{
//    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]];
//    req.HTTPMethod=@"POST";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //afn默认不支持text，需手动强制支持
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];

    parameters[@"client_id"]=@"1616074629";
    parameters[@"client_secret"]=@"2dbb29041db97f23b1502f0698a9dc07";
    parameters[@"grant_type"]=@"authorization_code";
    parameters[@"code"]=token;
    parameters[@"redirect_uri"]=@"http://ios.itcast.cn";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        
        
        OAuthData *account=[OAuthData OAuthDataWithDic:responseObject];
        Log(@"%@",account.access_token);
        [Tools WriteAccount:account];
        [UIApplication sharedApplication].keyWindow.rootViewController=[[MainTabbarControl alloc]init];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
    }];

}
#pragma 浏览器代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlstr=request.URL.absoluteString;
    NSRange rage=[urlstr rangeOfString:@"code="];
    if(rage.location!=NSNotFound)
    {
        NSString *code=[urlstr substringFromIndex:rage.location+rage.length];
        Log(@"code:%@,%@",code,[urlstr substringFromIndex:rage.location]);
        [self accessToken:code];
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载...不要猴急"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
