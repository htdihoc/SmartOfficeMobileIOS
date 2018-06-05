//
//  RefuseAlertView.h
//  SmartOffice
//
//  Created by Hiep Le Dinh on 5/24/18.
//  Copyright © 2018 ITSOL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEYBOARD_ANIMATION_DURATION     0.3f
#define MINIMUM_SCROLL_FRACTION         0.2f
#define MAXIMUM_SCROLL_FRACTION         0.8f
#define PORTRAIT_KEYBOARD_HEIGHT        216

@interface RefuseAlertView : UIView<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextView *refuseTextView;
@property (strong, nonatomic) NSString *id_BBBG_detail;
@property (nonatomic, assign) float animatedDistance;
@property (nonatomic, assign) NSInteger typeScrollTextField;

@end
