//
//  DuxShellCommentElement.m
//  Dux
//
//  Created by Abhi Beckert on 2012-03-07.
//  
//  This is free and unencumbered software released into the public domain.
//  For more information, please refer to <http://unlicense.org/>
//

#import "DuxShellCommentElement.h"
#import "DuxShellLanguage.h"

@implementation DuxShellCommentElement

static NSCharacterSet *nextElementCharacterSet;
static NSColor *color;

+ (void)initialize
{
  [super initialize];
  
  nextElementCharacterSet = [NSCharacterSet newlineCharacterSet];
  
  color = [[DuxTheme currentTheme] colorForKey:@"comment.shell"];
}

- (id)init
{
  return [self initWithLanguage:[DuxShellLanguage sharedInstance]];
}

- (NSUInteger)lengthInString:(NSAttributedString *)string startingAt:(NSUInteger)startingAt nextElement:(DuxLanguageElement *__strong*)nextElement
{
  NSRange foundRange = [string.string rangeOfCharacterFromSet:nextElementCharacterSet options:NSLiteralSearch range:NSMakeRange(startingAt, string.string.length - startingAt)];
  
  if (foundRange.location == NSNotFound)
    return string.string.length - startingAt;
  
  return foundRange.location - startingAt;
}

- (NSColor *)color
{
  return color;
}

- (BOOL)isComment
{
  return YES;
}

@end
