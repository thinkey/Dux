//
//  DuxPHPBlockCommentElement.m
//  Dux
//
//  Created by Abhi Beckert on 2011-11-16.
//  
//  This is free and unencumbered software released into the public domain.
//  For more information, please refer to <http://unlicense.org/>
//

#import "DuxPHPBlockCommentElement.h"
#import "DuxPHPLanguage.h"

@implementation DuxPHPBlockCommentElement

static NSString *nextElementSearchString;
static NSColor *color;

+ (void)initialize
{
  [super initialize];
  
  nextElementSearchString = @"*/";
  
  color = [[DuxTheme currentTheme] colorForKey:@"comment.block.php"];
}

- (id)init
{
  return [self initWithLanguage:[DuxPHPLanguage sharedInstance]];
}

- (NSUInteger)lengthInString:(NSAttributedString *)string startingAt:(NSUInteger)startingAt nextElement:(DuxLanguageElement *__strong*)nextElement
{
  NSUInteger searchStartLocation = MIN(startingAt + 2, string.length);
  NSRange foundRange = [string.string rangeOfString:nextElementSearchString options:NSLiteralSearch range:NSMakeRange(searchStartLocation, string.string.length - searchStartLocation)];
  
  if (foundRange.location == NSNotFound)
    return string.string.length - startingAt;
  
  return (foundRange.location - startingAt + 2);
}

- (NSColor *)color
{
  return color;
}

@end
