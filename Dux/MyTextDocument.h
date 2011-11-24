//
//  MyTextDocument.h
//  Dux
//
//  Created by Abhi Beckert on 2011-08-23.
//  
//  This is free and unencumbered software released into the public domain.
//  For more information, please refer to <http://unlicense.org/>
//

#import <Cocoa/Cocoa.h>
#import "DuxTextView.h"
#import "DuxSyntaxHighlighter.h"
#import "DuxLanguageMenuItem.h"

@interface MyTextDocument : NSDocument {
  NSString *textContentToLoad; // text content to be loaded by -loadTextContentIntoStorage
}

@property (nonatomic, strong) NSTextStorage *textStorage;
@property (unsafe_unretained) IBOutlet DuxTextView *textView;
@property (nonatomic, strong) DuxSyntaxHighlighter *syntaxtHighlighter;

// Newline style to be used when inserting new text.
// The mask returned will only ever contain one of
// the possible DuxNewlineOptions options.
@property (nonatomic) DuxNewlineOptions activeNewlineStyle;

- (void)loadTextContentIntoStorage; // loads textContentToLoad into self.textStorage. Called in -readFromData, and in -windowControllerDidLoadNib. is a noop if !self.textStorage

- (void)documentWindowDidBecomeKey:(NSNotification *)notification;

- (void)updateSyntaxMenuStates;
- (void)updateNewlineStyleMenuStates;
- (void)updateLineEndingsInUseMenuItem;

- (IBAction)setDuxLanguage:(id)sender;
- (IBAction)setActiveNewlineStyleFromMenuItem:(NSMenuItem *)sender;
- (IBAction)convertToNewlineStyleFromMenuItem:(NSMenuItem *)sender;

@end