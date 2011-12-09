//
//  AppController.h
//  RaiseMan
//
//  Created by Adam Preble on 9/19/11.
//  Copyright (c) 2011 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PreferenceController;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
	IBOutlet NSPanel *aboutPanel;
}
- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)showAboutPanel:(id)sender;

@end
