#import "SpotifyWidget.h"
#import <Foundation/Foundation.h>
#import "../OverlayWidget.h"

@implementation SpotifyWidgetView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [NSColor colorWithRed:0.3 green:0.7 blue:0.3 alpha:0.8];
        self.isDraggable = NO;

        NSString *currentSongInfo = [self getCurrentSpotifyTrackInfo];
        if (currentSongInfo) {
            self.label = currentSongInfo;
        } else {
            self.label = @"Spotify Not Playing";
        }

        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(updateCurrentSong)
                                       userInfo:nil
                                        repeats:YES];
    }
    return self;
}

- (void)updateCurrentSong {
    NSString *songInfo = [self getCurrentSpotifyTrackInfo];
    if (songInfo) {
        self.label = songInfo;
    } else {
        self.label = @"Spotify Not Playing";
    }
    [self setNeedsDisplay:YES];
}

/* this was solved with AppleScript due to Apples amazing and easy to use api - and since its just a demo, i figured why not try :^)*/
- (NSString *)getCurrentSpotifyTrackInfo {
    NSString *scriptSource = @"tell application \"Spotify\"\n"
                            "    if it is running then\n"
                            "        try\n"
                            "            set currentArtist to artist of current track\n"
                            "            set currentTrack to name of current track\n"
                            "            return currentArtist & \" - \" & currentTrack\n"
                            "        on error\n"
                            "            return \"No Song Playing\"\n"
                            "        end try\n"
                            "    else\n"
                            "        return \"Spotify Not Running\"\n"
                            "    end if\n"
                            "end tell";

    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptSource];
    NSDictionary *error = nil;
    NSAppleEventDescriptor *result = [script executeAndReturnError:&error];

    if (error) {
        NSLog(@"AppleScript Error: %@", error);
        return nil;
    }

    if ([result descriptorType] == typeUnicodeText) {
        return [result stringValue];
    }

    return nil;
}

@end