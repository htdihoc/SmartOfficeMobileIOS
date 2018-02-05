//
//  BottomButton.m
//  SmartOffice
//
//  Created by NguyenVanTu on 4/19/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import "BottomButton.h"

@implementation BottomButton
- (instancetype)initWithDefautRedColor:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        self.color = UIColorFromHex(0xf05253);
    }
    return self;
}
- (instancetype)initWithDefautBlueColor:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        self.color = UIColorFromHex(0x027eba);
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.title = title;
        self.color = color;
    }
    return self;
}
@end
