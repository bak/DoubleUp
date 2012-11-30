//
//  AppDelegate.m
//  DoubleUp
//
//  Created by Ben Cullen-Kerney on 11/27/12.
//  Copyright (c) 2012 beancuke. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

    @synthesize menu;

    - (void)applicationDidFinishLaunching:(NSNotification *)aNotification
    {
        NSStatusBar *status_bar = [NSStatusBar systemStatusBar];
        status_item = [status_bar statusItemWithLength:NSVariableStatusItemLength];
        NSImage *inactive_icon = [NSImage imageNamed:@"inactive"];
        NSImage *active_icon = [NSImage imageNamed:@"active"];
        [status_item setImage:inactive_icon];
        [status_item setAlternateImage:active_icon];
        [status_item setHighlightMode:YES];
        [status_item setMenu:menu];
        
        [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask) handler:^(NSEvent *event){
//            [self keyWasPressedFunction: event];
        }];
    }

@end
