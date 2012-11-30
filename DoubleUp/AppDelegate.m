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
        count = 0;
        
        // Spec:
        // Detects two subsequent (within n seconds) keydowns of either Shift key, without intervening keyDown of any other key.
        // Strategy: increment a count that is reset to zero whenever:
        // 1. any other key is pressed
        // 2. n seconds pass
        // 3. Shift is pressed twice and the action is done
        [NSEvent addGlobalMonitorForEventsMatchingMask:(NSFlagsChangedMask) handler:^(NSEvent *event){
            // detect Shift
            if (([event keyCode] == 56) || ([event keyCode] == 60)) {
                // odd numbers are shift-key down, evens are up
                count++;
                if (count == 4) {
                    [self toggle];
                    count = 0;
                }
                NSLog(@"count: %i", count);
            }
        }];
    }

    -(void) toggle
    {
        NSLog(@"Did toggle");
    }

@end
