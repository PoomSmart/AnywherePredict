#import "../PS.h"

%hook UIKeyboardImpl

- (BOOL)predictionForTraits
{
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

%ctor
{
	%init;
}