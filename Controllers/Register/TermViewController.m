//
//  TermViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "TermViewController.h"

// --- Defines ---;
// TermViewController Class;
@interface TermViewController ()

@end

@implementation TermViewController

// Functions;
#pragma mark - TermViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Terms of Use" withExtension:@"docx"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [viewWeb loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [viewWeb stringByEvaluatingJavaScriptFromString:@"document.body.style.background = 'rgba(0,0,0,0)';"];
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
