//
//  SendWeiBoView.m
//  新浪微博
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "SendWeiBoView.h"
#import "SendTV.h"
#import "Tools.h"
#import "SendToolBar.h"
#import "SendImgContant.h"
@interface SendWeiBoView()<UITextViewDelegate,SendToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(weak,nonatomic)SendTV *tvmsg;
@property(weak,nonatomic)SendToolBar *toolbar;
@property(weak,nonatomic) SendImgContant *imgContant;
@end

@implementation SendWeiBoView
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupNavButton];
    [self setupTxt];
    [self setupToolBar];
    [self setupKeyBoard];
    self.tvmsg.delegate=self;
    self.toolbar.delegate=self;
    self.view.backgroundColor=[UIColor grayColor];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    Log(@"%@",info[UIImagePickerControllerOriginalImage]);
    
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    UIImageView *imgview=[[UIImageView alloc]init];
//    imgview.image=img;
//    imgview.w=70;
//    imgview.h=70;
//    imgview.x=0;
//    imgview.y=44;
    
    [self.imgContant addImage:img];
}
/**
 *  打开图片选择器
 */
-(void)openPicture
{
    UIImagePickerController *imgpick=[[UIImagePickerController alloc]init];
    imgpick.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    imgpick.allowsEditing=YES;
    imgpick.delegate=self;
    
    [self presentViewController:imgpick animated:YES completion:nil];
}

-(void)sendToolBar:(SendToolBar *)stb didClick:(ToolBarButtonType)btn
{
    switch (btn) {
        case ToolBarButtonTypeCamera:
            
            break;
        case ToolBarButtonTypePicture:
                Log(@"%zd",ToolBarButtonTypePicture);
            [self openPicture];
            break;
        case ToolBarButtonTypeEmotion:
            
            break;
        case ToolBarButtonTypeMention:
            
            break;
        case ToolBarButtonTypeTrend:
            
            break;
            
        default:
            break;
    }
}

-(void)setupKeyBoard
{
    [self.tvmsg becomeFirstResponder];
}

-(void)setupToolBar
{
    SendToolBar *toolbar=[[SendToolBar alloc]init];
//    toolbar.backgroundColor=[UIColor blackColor];
    toolbar.w=[UIScreen mainScreen].bounds.size.width;
    toolbar.h=40;
    toolbar.y=[UIScreen mainScreen].bounds.size.height-40;
    toolbar.x=0;
    [self.view addSubview:toolbar];
    self.toolbar=toolbar;
    
    //键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)dealloc
{
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardWillShow:(NSNotification *)note
{
    Log(@"%@",note.userInfo);
    
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform=CGAffineTransformMakeTranslation(0, -rect.size.height);
    }];
}

-(void)keyboardWillHide:(NSNotification *)note
{
    Log(@"%@",note.userInfo);
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:duration animations:^{
        //回到初始位置
        self.toolbar.transform=CGAffineTransformIdentity;
    }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length>0)
        self.navigationItem.rightBarButtonItem.enabled=YES;
    else
    {
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
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
    tvmsg.placeholder=@"在这里输入文字...";
//    tvmsg.placeholdercolor=[UIColor redColor];
    tvmsg.w=[UIScreen mainScreen].bounds.size.width;
    tvmsg.h=self.view.h;
    tvmsg.x=0;
    tvmsg.y=0;
//设置文本框默认可以滚动
    tvmsg.alwaysBounceVertical=YES;
    [self.view addSubview:tvmsg];
    self.tvmsg=tvmsg;
    
    SendImgContant *imgContant=[[SendImgContant alloc]init];
    imgContant.w=tvmsg.w;
    imgContant.x=0;
    imgContant.y=100;
    imgContant.h=tvmsg.h;
    imgContant.backgroundColor=[UIColor orangeColor];
    [self.tvmsg addSubview:imgContant];
    self.imgContant=imgContant;
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
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=[Tools ReadAccount].access_token;
    parameters[@"status"]=self.tvmsg.text;
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
