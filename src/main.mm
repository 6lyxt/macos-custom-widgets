#import <iostream>
#import <vector>
#import <AppKit/AppKit.h>
#import "OverlayWidget.h"
#import "OverlayView.h"

std::vector<OverlayWidget> widgets;

int main() {
    [NSApplication sharedApplication];

    NSRect screenRect = [[NSScreen mainScreen] frame];

    NSWindow *mainWindow = [[NSWindow alloc] initWithContentRect:screenRect
                                                       styleMask:NSWindowStyleMaskBorderless
                                                         backing:NSBackingStoreBuffered
                                                           defer:NO];
    [mainWindow setBackgroundColor:[NSColor clearColor]];
    [mainWindow setOpaque:NO];
    [mainWindow setHasShadow:NO];
    [mainWindow setLevel:NSStatusWindowLevel];
    [mainWindow makeKeyAndOrderFront:nil];

    OverlayWidget widget1 = {NSMakeRect(50, screenRect.size.height - 150, 100, 50), [NSColor colorWithRed:0.2 green:0.6 blue:0.8 alpha:0.7], "moveable widget", true};
    OverlayWidget widget2 = {NSMakeRect(200, screenRect.size.height - 80, 80, 30), [NSColor colorWithRed:0.9 green:0.4 blue:0.4 alpha:0.8], "clickable widget", false};

    widgets.push_back(widget1);
    widgets.push_back(widget2);

    NSView *contentView = [mainWindow contentView];

    for (size_t i = 0; i < widgets.size(); ++i) {
        OverlayWidget& widgetData = widgets[i];
        OverlayView *overlayView = [[OverlayView alloc] initWithFrame:widgetData.frame];
        overlayView.backgroundColor = widgetData.backgroundColor;
        overlayView.label = [NSString stringWithUTF8String:widgetData.label.c_str()];
        overlayView.widgetIndex = i;
        overlayView.isDraggable = widgetData.isDraggable;
        [contentView addSubview:overlayView];
    }

    [NSApp run];

    return 0;
}