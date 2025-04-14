## macos-custom-widgets

create click- & draggable widgets on macos

### building (including example)
```zsh
$ g++ -o OverlayApp src/main.mm src/OverlayView.mm src/examples/SpotifyWidget.mm -framework Cocoa -framework QuartzCore
```

### usage (demo)
```zsh
$ ./CustomWidgets
```

### usage (devs)
ExampleWidget.mm:
```objective-c
// ExampleWidget.mm
#import "OverlayView.h"

@implementation ExampleWidget

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [[NSColor colorWithWhite:0.2 alpha:0.8] CGColor];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    NSString *text = @"Hello Widget!";
    NSDictionary *attributes = @{
        NSFontAttributeName: [NSFont systemFontOfSize:16],
        NSForegroundColorAttributeName: [NSColor whiteColor]
    };
    [text drawAtPoint:NSMakePoint(10, 10) withAttributes:attributes];
}

@end
```

main.mm:
```objective-c
ExampleWidget *widget = [[MyWidget alloc] initWithFrame:NSMakeRect(100, 100, 200, 100)];
[window.contentView addSubview:widget];
```

