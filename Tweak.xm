#import "../PS.h"
#import <UIKit/UITextInputTraits+Private.h>

%hook UIKeyboardImpl

%group iOS10Up

- (BOOL)predictionForTraitsWithForceEnable: (BOOL)force {
    UITextInputTraits *traits = MSHookIvar<UITextInputTraits *>(self, "m_traits");
    BOOL wasNo1 = traits.autocorrectionType == UITextAutocorrectionTypeNo;
    BOOL wasNo2 = traits.disablePrediction;
    if (wasNo1)
        traits.autocorrectionType = UITextAutocorrectionTypeYes;
    if (wasNo2)
        traits.disablePrediction = NO;
    BOOL orig = %orig;
    if (wasNo1)
        traits.autocorrectionType = UITextAutocorrectionTypeNo;
    if (wasNo2)
        traits.disablePrediction = YES;
    return orig;
}

%end

%group preiOS10

- (BOOL)predictionForTraits {
    UITextInputTraits *traits = MSHookIvar<UITextInputTraits *>(self, "m_traits");
    BOOL wasNo1 = traits.autocorrectionType == UITextAutocorrectionTypeNo;
    BOOL wasNo2 = traits.disablePrediction;
    if (wasNo1)
        traits.autocorrectionType = UITextAutocorrectionTypeYes;
    if (wasNo2)
        traits.disablePrediction = NO;
    BOOL orig = %orig;
    if (wasNo1)
        traits.autocorrectionType = UITextAutocorrectionTypeNo;
    if (wasNo2)
        traits.disablePrediction = YES;
    return orig;
}

%end

%end

%ctor {
    if (isiOS10Up) {
        %init(iOS10Up);
    } else {
        %init(preiOS10);
    }
}
