//
//  ViewController.m
//  TestJSExport
//
//  Created by zyjk_iMac-penghe on 2017/5/4.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "ViewController.h"
#import "JavaScriptObject.h"
@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *myWebView;
@property (nonatomic, strong)JavaScriptObject *javaScriptObj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _myWebView.delegate = self;
    [self.view addSubview:_myWebView];
    //测试网址（本地HTML文件）
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [_myWebView loadHTMLString:htmlCont baseURL:baseURL];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _javaScriptObj = [[JavaScriptObject alloc] init];
    context[@"iOS"] = _javaScriptObj;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
