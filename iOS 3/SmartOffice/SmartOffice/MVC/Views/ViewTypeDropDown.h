//
//  ViewTypeDropDown.h
//  SmartOffice
//
//  Created by Hiep Le Dinh on 5/2/18.
//  Copyright © 2018 ITSOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTypeDropDown : UIView

@property (weak, nonatomic) IBOutlet UIImageView *checkView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (assign, nonatomic) BOOL selected;

@end
