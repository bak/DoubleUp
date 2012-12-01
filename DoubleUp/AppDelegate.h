//
//  AppDelegate.h
//  DoubleUp
//
//  Created by Ben Cullen-Kerney on 11/27/12.
//  Copyright (c) 2012 beancuke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *status_item;
    int shiftCount;
}

-(void) initializeState;
-(void) setUpUI;
-(void) monitorShift;
-(void) monitorNonShift;
-(void) toggleCaps;

@property (assign) IBOutlet NSMenu *menu;

@end
