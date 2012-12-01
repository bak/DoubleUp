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
        [self setUpUI];
        [self initializeState];
        [self monitorShift];
        [self monitorNonShift];
    }

    -(void) initializeState
    {
        shiftCount = 0;
    }

    -(void) monitorShift
    {
        // Using NSFlagsChangedMask instead of NSShiftKeyMask so we
        // can catch all other modifier flags, and reset the count.
        [NSEvent addGlobalMonitorForEventsMatchingMask:(NSFlagsChangedMask) handler:^(NSEvent *event){
            // increment count for subsequent Shifts, reset for anything else
            NSLog(@"code: %hu", [event keyCode]);
            if (([event keyCode] == 56) || ([event keyCode] == 60)) {
                
                shiftCount++;
                
                // Does not discern between keyup and keydown,
                // odd numbers are shift-key down, evens are up.
                if (shiftCount == 4) {
                    [self toggleCaps];
                } else if (shiftCount > 4) { // ?
                    shiftCount = 0;
                }
            } else {
                shiftCount = 0;
            }
        }];
    }

    -(void) monitorNonShift;
    {
        // Force shiftCount to zero for all non-Shifts.
        [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask) handler:^(NSEvent *otherEvent) {
            shiftCount = 0;
        }];
    }

    -(void) toggleCaps
    {
        
        CGEventSourceRef eventSource = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
        if (eventSource != NULL) {

            NSLog(@"toggling");
            
            CGEventRef eventDown = CGEventCreateKeyboardEvent(eventSource, (CGKeyCode)57, YES);
            CGEventPost(kCGSessionEventTap, eventDown);
            CFRelease(eventDown);
            
            CGEventRef eventUp = CGEventCreateKeyboardEvent(eventSource, (CGKeyCode)57, NO);
            CGEventPost(kCGSessionEventTap, eventUp);
            CFRelease(eventUp);
            
            CFRelease(eventSource);
        }
        shiftCount = 0;
    }

    -(void) setUpUI
    {
        NSStatusBar *status_bar = [NSStatusBar systemStatusBar];
        status_item = [status_bar statusItemWithLength:NSVariableStatusItemLength];
        NSImage *inactive_icon = [NSImage imageNamed:@"inactive"];
        NSImage *active_icon = [NSImage imageNamed:@"active"];
        [status_item setImage:inactive_icon];
        [status_item setAlternateImage:active_icon];
        [status_item setHighlightMode:YES];
        [status_item setMenu:menu];
    }

@end
