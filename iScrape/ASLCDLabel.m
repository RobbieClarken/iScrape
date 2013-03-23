//
//  ASLCDLabel.m
//  iScrape
//
//  Created by Robbie Clarken on 24/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASLCDLabel.h"

static NSString *LCDFontName = @"DS-Digital";

@implementation ASLCDLabel
@synthesize text = _text;

- (void)awakeFromNib {
    self.font = [UIFont fontWithName:LCDFontName size:self.font.pointSize];
    [self setText:self.text];
}

- (void)setText:(NSString *)text {
    if (!text) {
        _text = text;
        return;
    }
    self.attributedText = [self lcdFontStringFromString:text withFontSize:self.font.pointSize];
}

- (NSAttributedString *)lcdFontStringFromString:(NSString *)string withFontSize:(CGFloat)fontSize {
    CGFloat lowerCaseFontSize = 0.6 * fontSize;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    UIFont *lowerCaseFont = [UIFont fontWithName:LCDFontName size:lowerCaseFontSize];
    
    NSRegularExpression *lowerCaseRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-z]+" options:0 error:nil];
    NSArray *matches = [lowerCaseRegularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult *match in matches) {
        [attributedString addAttribute:NSFontAttributeName value:lowerCaseFont range:match.range];
    }
    return attributedString;
}

@end
