//
//  ResetWindow.m
//  CompactIdentityLogin
//
//  Created by Satendra Singh on 01/04/20.
//

#import "ResetWindow.h"

@implementation ResetWindow

- (void)awakeFromNib{
    [super awakeFromNib];
    mWebView.navigationDelegate = self;
}
-(void)loadWebURL:(NSString *)url{
    NSURL *nsurl=[NSURL URLWithString:url];
    
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [mWebView loadRequest:nsrequest];
}

-(void)showLoader{
    [loader startAnimation:nil];
    [loader.animator setHidden:NO];
}

-(void)hideLoader{
    [loader.animator setHidden:YES];
    [loader stopAnimation:nil];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [self showLoader];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self hideLoader];
}

@end
