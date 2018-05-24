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
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"AcceptOrRefuseActionNotification"
             object:self];
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

@end
