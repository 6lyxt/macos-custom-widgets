#ifndef OVERLAYVIEW_H
#define OVERLAYVIEW_H

#import <AppKit/AppKit.h>

@interface OverlayView : NSView {
    bool isDragging;
    NSPoint dragOffset;
}

@property (nonatomic, strong) NSColor *backgroundColor;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, assign) NSInteger widgetIndex;
@property (nonatomic, assign) bool isDraggable;

@end

#endif