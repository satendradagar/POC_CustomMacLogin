//
//  SSHyperLinkButton.m
//  Halloween Fonts
//
//  Created by Satendra Singh on 27/03/20.
//  Copyright © 2020 128 Bit Technologies LLC. All rights reserved.
//

#import "SSHyperLinkButton.h"

@implementation SSHyperLinkButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self updateButtonTitle:self.title];
}


- (void)resetCursorRects {
    [self addCursorRect:[self bounds] cursor:[NSCursor pointingHandCursor]];
}

-(void)updateButtonTitle:(NSString *)title{
    self.title = title;
        self.bordered = NO;
        [self setBezelStyle:NSRegularSquareBezelStyle]; [self setButtonType:NSMomentaryChangeButton];
        
    //    NSURL *url = [NSURL URLWithString:@"https://www.google.com/?client=safari"];
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.alignment = NSTextAlignmentCenter;
    //url, NSLinkAttributeName,
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:NSUnderlineStyleSingle], NSUnderlineStyleAttributeName,  [self font], NSFontAttributeName, [NSColor whiteColor], NSForegroundColorAttributeName,paragraphStyle, NSParagraphStyleAttributeName, nil];
        self.attributedTitle = [[NSAttributedString alloc] initWithString:self.title attributes:attributes];

}

@end
