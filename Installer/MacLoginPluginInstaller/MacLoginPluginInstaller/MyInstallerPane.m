//
//  MyInstallerPane.m
//  MacLoginPluginInstaller
//
//  Created by Satendra Singh on 28/03/20.
//  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.
//
#import "URLValidator.h"
#import "MyInstallerPane.h"
#import "URLStorageManager.h"
#import "ChangeInputMethod.h"

@interface MyInstallerPane()<NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *resetPasswordURLField;

@property (weak) IBOutlet NSTextField *resetPasswordTitleField;

@end

@implementation MyInstallerPane

- (NSString *)title
{
    return [[NSBundle bundleForClass:[self class]] localizedStringForKey:@"PaneTitle" value:nil table:nil];
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)willEnterPane:(InstallerSectionDirection)dir
{
    NSLog(@"****** ---%@", @"willEnterPane");
}

- (void)didEnterPane:(InstallerSectionDirection)dir
{
    NSLog(@"****** +++%@", @"didEnterPane");

    self.resetPasswordURLField.delegate = self;
    self.resetPasswordTitleField.delegate = self;

//    [self.resetPasswordURLField becomeFirstResponder];
    [self validateContent];

}

- (BOOL)shouldExitPane:(InstallerSectionDirection)dir{
    [URLStorageManager saveUrl:self.resetPasswordURLField.stringValue andTitle:self.resetPasswordTitleField.stringValue];
    self.resetPasswordURLField.delegate = nil;
    self.resetPasswordTitleField.delegate = nil;

//    [ChangeInputMethod updatePluginNameInLogin];
    return YES;
}


//- (IBAction)quitInstaller:(id)sender
//{
//    system("killall -9 \"Installer\"");
//    //[NSApp terminate:nil];
//}

- (void)controlTextDidChange:(NSNotification *) obj{
    [self validateContent];
}

-(void)validateContent{
    if ([URLValidator validateUrlString:_resetPasswordURLField.stringValue] && [URLValidator validateTitle:_resetPasswordTitleField.stringValue]) {
        self.nextEnabled = YES;
    }
    else{
        self.nextEnabled = NO;

    }
}

@end
