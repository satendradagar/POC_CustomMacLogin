//
//  ResetWindow.h
//  CompactIdentityLogin
//
//  Created by Satendra Singh on 01/04/20.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ResetWindow : NSWindow<WKNavigationDelegate>
{
    IBOutlet WKWebView *mWebView;
    IBOutlet NSProgressIndicator *loader;

}

-(void)loadWebURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
