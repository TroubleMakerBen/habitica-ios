#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Seeds.h"
#import "SeedsInterstitials.h"
#import "SeedsInterstitial.h"
#import "SeedsEvents.h"

FOUNDATION_EXPORT double SeedsSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char SeedsSDKVersionString[];

