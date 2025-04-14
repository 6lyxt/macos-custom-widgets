#import "OverlayView.h"
#import "OverlayWidget.h"
#include <vector>

@implementation OverlayView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
        isDragging = NO;
        self.isDraggable = NO;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    if (self.backgroundColor) {
        [self.backgroundColor set];
        NSRectFill(self.bounds);
    }

    if (self.label) {
        NSColor *textColor = [NSColor blackColor];
        NSDictionary *attributes = @{NSFontAttributeName: [NSFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName: textColor};
        NSSize textSize = [self.label sizeWithAttributes:attributes];
        NSPoint textOrigin = NSMakePoint((self.bounds.size.width - textSize.width) / 2,
                                        (self.bounds.size.height - textSize.height - 2) / 2);
        [self.label drawAtPoint:textOrigin withAttributes:attributes];
    }
}

- (void)mouseDown:(NSEvent *)event {
    NSPoint eventLocation = [event locationInWindow];
    NSPoint viewLocation = [self convertPoint:eventLocation fromView:nil];

    if (NSPointInRect(viewLocation, self.bounds)) {
        if (self.isDraggable) {
            isDragging = YES;
            dragOffset = NSMakePoint(viewLocation.x, viewLocation.y);
        } else {
            NSLog(@"Widget %ld clicked", (long)self.widgetIndex);
        }
    }
}

- (void)mouseDragged:(NSEvent *)event {
    if (isDragging) {
        NSPoint currentMouseLocationInWindow = [event locationInWindow];
        CGFloat newX = currentMouseLocationInWindow.x - dragOffset.x;
        CGFloat newY = currentMouseLocationInWindow.y - dragOffset.y;

        [self setFrameOrigin:NSMakePoint(newX, newY)];

        extern std::vector<OverlayWidget> widgets;
        if (self.widgetIndex >= 0 && self.widgetIndex < widgets.size()) {
            widgets[self.widgetIndex].frame = self.frame;
        }
    }
}

- (void)mouseUp:(NSEvent *)event {
    isDragging = NO;
}

@end