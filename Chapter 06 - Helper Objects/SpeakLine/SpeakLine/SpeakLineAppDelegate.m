//
//  SpeakLineAppDelegate.m
//  SpeakLine
//
//  Created by Adam Preble on 9/9/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import "SpeakLineAppDelegate.h"

@implementation SpeakLineAppDelegate

@synthesize textField = _textField;
@synthesize stopButton = _stopButton;
@synthesize speakButton = _speakButton;
@synthesize tableView = _tableView;
@synthesize window = _window;

- (id)init {
    self = [super init];
    if (self) {
        // Logs can help the beginner understand what
        // is happening and hunt down bugs.
        NSLog(@"init");
        // Create a new instance of NSSpeechSynthesizer
        // with the default voice.
        _speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
		
		[_speechSynth setDelegate:self];
		
		_voices = [NSSpeechSynthesizer availableVoices];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (IBAction)sayIt:(id)sender {
	NSString *string = [_textField stringValue];
    // Is the string zero-length?
    if ([string length] == 0) {
        NSLog(@"string from %@ is of zero-length", _textField);
		return; }
    [_speechSynth startSpeakingString:string];
    NSLog(@"Have started to say: %@", string);
	
	[_stopButton setEnabled:YES];
	[_speakButton setEnabled:NO];
	[_tableView setEnabled:NO];
}

- (IBAction)stopIt:(id)sender {
	NSLog(@"stopping");
    [_speechSynth stopSpeaking];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
	return (NSInteger)[_voices count];
}


- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSString *v = [_voices objectAtIndex:row];
	NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
	return [dict objectForKey:NSVoiceName];
}

#pragma mark - NSTableViewDelegate

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	NSInteger row = [_tableView selectedRow];
	if (row == -1)
		return;
	NSString *selectedVoice = [_voices objectAtIndex:row];
	[_speechSynth setVoice:selectedVoice];
	NSLog(@"New voice = %@", selectedVoice);
}

#pragma mark - NSSpeechSynthesizerDelegate

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
		didFinishSpeaking:(BOOL)finishedSpeaking
{
	NSLog(@"finishedSpeaking = %d", finishedSpeaking);
	[_stopButton setEnabled:NO];
	[_speakButton setEnabled:YES];
	[_tableView setEnabled:YES];
}

@end
