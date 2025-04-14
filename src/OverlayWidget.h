#ifndef OVERLAYWIDGET_H
#define OVERLAYWIDGET_H

#include <string>
#include <AppKit/AppKit.h>

struct OverlayWidget {
    NSRect frame;
    NSColor *backgroundColor;
    std::string label;
    bool isDraggable;
};

#endif