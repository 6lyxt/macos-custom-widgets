#import <iostream>
#import <vector>
#import <AppKit/AppKit.h>
#import "OverlayWidget.h"
#import "OverlayView.h"
#import "examples/SpotifyWidget.h"

std::vector<OverlayWidget> widgets;

void runNormalExample() {
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
}

void runSpotifyWidgetExample() {
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

    NSView *contentView = [mainWindow contentView];

    NSRect spotifyFrame = NSMakeRect(screenRect.size.width - 220, screenRect.size.height - 60, 200, 40);
    OverlayWidget spotifyWidgetData = {spotifyFrame, [NSColor colorWithRed:0.3 green:0.7 blue:0.3 alpha:0.8], "Loading...", false};

    SpotifyWidgetView *spotifyWidgetView = [[SpotifyWidgetView alloc] initWithFrame:spotifyWidgetData.frame];
    spotifyWidgetView.isDraggable = true;
    [contentView addSubview:spotifyWidgetView];

    [NSApp run];
}

int main(int argc, const char * argv[]) {
    std::cout << "Choose an example:" << std::endl;
    std::cout << "1: Normal Example (draggable and clickable widgets)" << std::endl;
    std::cout << "2: Spotify Widget Example (current song)" << std::endl;
    std::cout << "Enter your choice (1 or 2): ";

    int choice;
    std::cin >> choice;

    if (choice == 1) {
        runNormalExample();
    } else if (choice == 2) {
        runSpotifyWidgetExample();
    } else {
        std::cout << "Invalid choice. Exiting." << std::endl;
    }

    return 0;
}