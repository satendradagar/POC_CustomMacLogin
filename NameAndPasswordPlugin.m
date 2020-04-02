/*

File: NameAndPasswordPlugin.m

Abstract: SFAuthorizationPluginView subclass

Version: 1.1 improved by skycocker

Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
Computer, Inc. ("Apple") in consideration of your agreement to the
following terms, and your use, installation, modification or
redistribution of this Apple software constitutes acceptance of these
terms.  If you do not agree with these terms, please do not use,
install, modify or redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and
subject to these terms, Apple grants you a personal, non-exclusive
license, under Apple's copyrights in this original Apple software (the
"Apple Software"), to use, reproduce, modify and redistribute the Apple
Software, with or without modifications, in source and/or binary forms;
provided that if you redistribute the Apple Software in its entirety and
without modifications, you must retain this notice and the following
text and disclaimers in all such redistributions of the Apple Software. 
Neither the name, trademarks, service marks or logos of Apple Computer,
Inc. may be used to endorse or promote products derived from the Apple
Software without specific prior written permission from Apple.  Except
as expressly stated in this notice, no other rights or licenses, express
or implied, are granted by Apple herein, including but not limited to
any patent rights that may be infringed by your derivative works or by
other works in which the Apple Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

Copyright � 2006 Apple Computer, Inc., All Rights Reserved

*/

#import "NameAndPasswordPlugin.h"
#import <Security/AuthorizationTags.h>
#import "URLStorageManager.h"

@implementation EXNameAndPassword
{
    NSString *url;
    NSString *title;

}

- (void)awakeFromNib{
    [super awakeFromNib];
//    [self setButton:SFButtonTypeOK enabled:NO];

}

-(void)loadUserSetup{
    NSDictionary *savedDetails = [URLStorageManager savedInfo];
    url = savedDetails[URL_KEY];
    url = [[url stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"] retain];
    title = [savedDetails[URL_TITLE_KEY] retain];
    NSLog(@"URL:\%@",url);
    NSLog(@"TITLE:\%@",title);
    if (title.length > 0) {
        [mmIdentityResetButton updateButtonTitle:title];
        [mmPasswordResetButton updateButtonTitle:title];
    }

}
- (void)buttonPressed:(SFButtonType)inButtonType
{
    NSString *userNameString;
    NSString *passwordString;
    // check which type of view was asked for
    if (mUseIPView)
    {
        // it was the Identity and Credentials view so use the name field to get the user's identity
        userNameString = [mNameTextField stringValue];
        passwordString = [mIPPasswordSecureTextField stringValue];
    }
    else
    {
        // it was just the Credentials view so use the existing user name
        userNameString = mUserName;
        passwordString = [mPPasswordSecureTextField stringValue];
    }
    
    // if the OK button was pressed, write the identity and credentials and allow authorization,
    // otherwise, if the cancel button was pressed, cancel the authorization
    
    if (inButtonType == SFButtonTypeOK)
    {
        const char *userName = [userNameString UTF8String];
        const char *password = [passwordString UTF8String];
        
        AuthorizationValue userNameValue = { strlen(userName) + 1, (char*)userName };
        AuthorizationValue userPasswordValue = { strlen(password) + 1, (char*)password };
        
        // add the username and password to the context values
        [self callbacks]->SetContextValue([self engineRef], kAuthorizationEnvironmentUsername, 1, &userNameValue);
        [self callbacks]->SetContextValue([self engineRef], kAuthorizationEnvironmentPassword, 1, &userPasswordValue);
        
        // allow authorization
        [self callbacks]->SetResult([self engineRef], kAuthorizationResultAllow);
    }
    else if (inButtonType == SFButtonTypeCancel)
    {
        // cancel authorization
        [self callbacks]->SetResult([self engineRef], kAuthorizationResultUserCanceled); 
    }
}

- (NSView *)firstKeyView
{
	// return the appropriate view depending on whether or not identity and credentials
	// or just credentials are being asked for

    if (mUseIPView)
		return mNameTextField;
	else
		return mPPasswordSecureTextField;
}

- (NSView *)firstResponderView
{
	NSView					*view;
	// return the appropriate view depending on whether or not identity and credentials
	// or just credentials are being asked for
    if (mUseIPView)
	{
		// if the name field doesn't already has a user name, then return the name text field view
		// otherwise, return the password secure text field
		if ([[mNameTextField stringValue] length] == 0)
		{
			view = mNameTextField;
		}
		else
		{
			view = mIPPasswordSecureTextField;
		}
	}
	else
	{
		view = mPPasswordSecureTextField;
	}
	
	return view;
}

- (NSView *)lastKeyView
{
	// return the appropriate view depending on whether or not identity and credentials
	// or just credentials are being asked for
    if (mUseIPView)
		return mIPPasswordSecureTextField;
	else
		return mPPasswordSecureTextField;
}

- (void)setEnabled:(BOOL)inEnabled
{
	// enable or disable the text fields as appropriate
	[mNameTextField setEnabled: inEnabled];
	[mIPPasswordSecureTextField setEnabled: inEnabled];
	[mPPasswordSecureTextField setEnabled: inEnabled];
}

- (void)willActivateWithUser:(NSDictionary *)inUserInformation
{
	// save the user name and set the name text field
	mUserName = [[inUserInformation objectForKey: SFAuthorizationPluginViewUserShortNameKey] retain];
    [self loadUserSetup];
	if (mUserName)
	{
		[mNameTextField setStringValue: mUserName];
	}
//    [self setButton:SFButtonTypeOK enabled:NO];

}

- (NSView*)viewForType:(SFViewType)inType
{
	NSView *view = nil;
    
	// return the appropriate view for the type of view being requested
	if (inType == SFViewTypeIdentityAndCredentials)
	{
		view = mIdentityAndPasswordView;
		mUseIPView = YES;
	}
	else if (inType == SFViewTypeCredentials)
	{
		view = mPasswordView;
		mUseIPView = NO;
	}
	
	return view;
}

// --------------------------------------------------------------------------------
- (id)initWithCallbacks:(const AuthorizationCallbacks *)callbacks andEngineRef:(AuthorizationEngineRef)engineRef
{
	self = [super initWithCallbacks: callbacks andEngineRef: engineRef];
	if (self)
	{
		// do any additional initialization
	}
	return self;
}

- (void)dealloc
{
	[mUserName release];
	[super dealloc];
}

-(IBAction)didClickedLink:(id)sender{
    [self attachWebView];
}

-(IBAction)didClickedOK:(id)sender{
    [self buttonPressed:SFButtonTypeOK];
}

-(void) attachWebView{
    NSView *view = nil;
    if (mUseIPView)
        view =  mIdentityAndPasswordView;
    else
        view =  mPasswordView;

    [view.window addChildWindow:mWindowToShow ordered:NSWindowAbove];

//    NSURL *nsurl=[NSURL URLWithString:@"http://www.apple.com"];
//    NSURL *nsurl=[NSURL URLWithString:@"https://compact-29.compactidentityqa2.com/CIDSaas/default/user/resetpassword"];
//    NSURL *nsurl=[NSURL URLWithString:url];
//
//    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
//    [mWebView loadRequest:nsrequest];
    [mWindowToShow makeKeyAndOrderFront:nil];
    [mWindowToShow loadWebURL:url];

}


@end
