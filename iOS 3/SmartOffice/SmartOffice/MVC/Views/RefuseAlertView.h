//
//  RefuseAlertView.h
//  SmartOffice
//
//  Created by Hiep Le Dinh on 5/24/18.
//  Copyright © 2018 ITSOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefuseAlertView : UIView

@property (nonatomic, weak) IBOutlet UITextView *refuseTextView;
@property (strong, nonatomic) NSString *id_BBBG_detail;

@end
