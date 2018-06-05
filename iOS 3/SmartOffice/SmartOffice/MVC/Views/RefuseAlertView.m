//
//  RefuseAlertView.m
//  SmartOffice
//
//  Created by Hiep Le Dinh on 5/24/18.
//  Copyright © 2018 ITSOL. All rights reserved.
//

#import "RefuseAlertView.h"
#import "KTTSProcessor.h"

@implementation RefuseAlertView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.typeScrollTextField = 1;
//    self.refuseTextView.delegate = self;
}

- (IBAction)confirmAction:(id)sender {
    if([self.refuseTextView.text  isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Đ/c chưa nhập lý do từ chối." delegate:nil cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
        [alert show];
    }else {
        
        NSDictionary *parameter = @{
                                    @"idBBBGTSCN": self.id_BBBG_detail,
                                    @"type": @"2",
                                    @"reason": self.refuseTextView.text
                                    };
        [KTTSProcessor postUPDATE_IN_HAN:parameter handle:^(id result, NSString *error) {
            NSString *reasonString = self.refuseTextView.text;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"RefuseActionNotification"
             object:reasonString];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Từ chối thành công." delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
            [alert show];
        } onError:^(NSString *Error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Có lỗi xảy ra. Vui lòng kiểm tra lại." delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
            [alert show];
            //        [self showAlertFailure:@"Có lỗi xảy ra. Vui lòng kiểm tra lại."];
        } onException:^(NSString *Exception) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Mất kết nối mạng" delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
            [alert show];
            //        [self showAlertFailure:@"Mất kết nối mạng"];
        }];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self removeFromSuperview];
}

- (IBAction)closeAction:(id)sender {
    [self removeFromSuperview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.typeScrollTextField == 1) {
        CGRect textFieldRect = [self.window convertRect:textField.bounds fromView:textField];
        CGRect viewRect = [self.window convertRect:self.bounds fromView:self];
        
        CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
        CGFloat numerator =
        midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
        CGFloat denominator =
        (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
        CGFloat heightFraction = numerator / denominator;
        
        if (heightFraction < 0.0)
        {
            heightFraction = 0.0;
        }
        else if (heightFraction > 1.0)
        {
            heightFraction = 1.0;
        }

        self.animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction) - 45;

        CGRect viewFrame = self.frame;
        viewFrame.origin.y -= self.animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [self setFrame:viewFrame];
        [UIView commitAnimations];
        self.typeScrollTextField = 2;
    }else {
        
    }
}

@end
