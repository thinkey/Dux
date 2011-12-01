//
//  DuxXMLLanguage.m
//  Dux
//
//  Created by Abhi Beckert on 2011-11-20.
//  
//  This is free and unencumbered software released into the public domain.
//  For more information, please refer to <http://unlicense.org/>
//

#import "DuxXMLLanguage.h"
#import "DuxXMLBaseElement.h"

@implementation DuxXMLLanguage

+ (void)load
{
  [DuxLanguage registerLanguage:[self class]];
}

- (DuxLanguageElement *)baseElement
{
  return [DuxXMLBaseElement sharedInstance];
}

- (void)wrapCommentsAroundRange:(NSRange)commentRange ofTextView:(NSTextView *)textView
{
  NSString *existingString = [textView.textStorage.string substringWithRange:commentRange];
  NSString *commentedString = [NSString stringWithFormat:@"<!-- %@ -->", existingString];
  
  [textView insertText:commentedString replacementRange:commentRange];
}

- (void)removeCommentsAroundRange:(NSRange)commentRange ofTextView:(NSTextView *)textView
{
  NSMutableString *newString = [[textView.textStorage.string substringWithRange:commentRange] mutableCopy];
  
  NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"^<!\\-\\- ?" options:0 error:NULL];
  [expression replaceMatchesInString:newString options:0 range:NSMakeRange(0, newString.length) withTemplate:@""];
  
  expression = [NSRegularExpression regularExpressionWithPattern:@" ?\\-\\->$" options:0 error:NULL];
  [expression replaceMatchesInString:newString options:0 range:NSMakeRange(0, newString.length) withTemplate:@""];
  
  [textView insertText:[newString copy] replacementRange:commentRange];
  [textView setSelectedRange:NSMakeRange(commentRange.location, newString.length)];
}

+ (BOOL)isDefaultLanguageForURL:(NSURL *)URL textContents:(NSString *)textContents
{
  static NSArray *extensions = nil;
  if (!extensions) {
    extensions = [NSArray arrayWithObjects:@"xml", nil];
  }
  
  if (URL && [extensions containsObject:[URL pathExtension]])
    return YES;
  
  if (textContents.length >= 5 && [[textContents substringToIndex:5] isEqualToString:@"<?xml"])
    return YES;
  
  return NO;
}

@end
