//
//  PropertyDetailsViewController.m
//  SmartOffice
//
//  Created by Vu Van Tiep on 4/26/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import "PropertyDetailsViewController.h"
#import "PropertyDetailsCell.h"
#import "AssetConfirmViewController.h"
#import "KTTSProcessor.h"
#import "KTTS_CancelStatus_VC_iPad.h"
#import "MZFormSheetController.h"

typedef NS_ENUM(NSInteger, Status) {
    isCancelStatus = 0,     // xác nhận
    isConfirmStatus = 1,    // hủy
    isAllStatus = 2         // xác nhận và hủy
};

@interface PropertyDetailsViewController () <UITableViewDataSource, UITableViewDelegate, TTNS_BaseNavViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *propertyDetailsTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelOrConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@property (nonatomic) Status status;

@end

@implementation PropertyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.typeKTTS == 1) {
        self.btnCancelOrConfirm.hidden = NO;
        self.btnCancel.hidden = NO;
        self.btnConfirm.hidden = NO;
        self.hightBtnCancelOrConfirm.constant = 50;
        self.hightBtnCancel.constant = 50;
        self.hightBtnConfirm.constant = 50;
    } else {
        self.btnCancelOrConfirm.hidden = YES;
        self.btnCancel.hidden = YES;
        self.btnConfirm.hidden = YES;
        self.hightBtnCancelOrConfirm.constant = 0;
        self.hightBtnCancel.constant = 0;
        self.hightBtnConfirm.constant = 0;
    }
    self.isColorButtonCopy = self.isColorButton;
    switch (self.isColorButton) {
        case isCancelStatus: {
            [self setColorCancel];
        }
            break;
        case isConfirmStatus: {
            [self setColorConfirm];
        }
            break;
        case isAllStatus: {
            self.btnCancelOrConfirm.hidden = YES;
            break;
        }
        default:
            break;
    }
    self.backTitle = @"Chi tiết tài sản";
    self.propertyDetailsTableView.estimatedRowHeight = 445;
    self.propertyDetailsTableView.rowHeight = UITableViewAutomaticDimension;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.value_status rangeOfString:@"KSD"].location != NSNotFound) {
            self.typeCancel = 3;
        } else if ([self.value_status rangeOfString:@"mất"].location != NSNotFound) {
            self.typeCancel = 1;
        } else if ([self.value_status rangeOfString:@"hỏng"].location != NSNotFound) {
            self.typeCancel = 2;
        } else {
            self.typeCancel = 0;
        }
    });
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(confirmSucessNotification:)
//                                                 name:@"ConfirmSucessNotification"
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(cancelSucessNotification:)
//                                                 name:@"CancelSucessNotification"
//                                               object:nil];
    
}

//- (void) confirmSucessNotification:(NSNotification *) notification
//{
////    isCancelStatus = 0,     // xác nhận
////    isConfirmStatus = 1,    // hủy
////    isAllStatus = 2         // xác nhận và hủy
//
//
//    if(self.isColorButton == 0){
//        self.isColorButton = 2;
//    }else if(self.isColorButton == 2){
//        self.isColorButton = 2;
//    }
//
//        switch (self.isColorButton) {
//            case isCancelStatus: {
//                [self setColorCancel];
//            }
//                break;
//            case isConfirmStatus: {
//                [self setColorConfirm];
//            }
//                break;
//            case isAllStatus: {
//                self.btnCancelOrConfirm.hidden = YES;
//                break;
//            }
//            default:
//                break;
//        }
//
//}
//
//- (void) cancelSucessNotification:(NSNotification *) notification
//{
//
//    switch (self.isColorButton) {
//        case isCancelStatus: {
//            [self setColorCancel];
//        }
//            break;
//        case isConfirmStatus: {
//            [self setColorConfirm];
//        }
//            break;
//        case isAllStatus: {
//            self.btnCancelOrConfirm.hidden = YES;
//            break;
//        }
//        default:
//            break;
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PropertyDetailsCell *cell = (PropertyDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"propertyDetailsCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PropertyDetailsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.value_commodity_code.text = self.value_commodity_code;
    cell.value_commodity_name.text = self.value_commodity_name;
    cell.value_unit.text = self.value_unit;
    cell.value_number.text = [NSString stringWithFormat:@"%@.0", self.value_number];
    cell.value_serial.text = self.value_serial;
    cell.value_manufacturer.text = self.value_manufacturer;
    cell.value_aspect.text = self.value_aspect;
    cell.value_expiry_date.text = [NSString stringWithFormat:@"%@ tháng", self.value_expiry_date];
    cell.value_asset_type.text = self.value_asset_type;
    cell.value_use_time.text = self.value_use_time;
    cell.value_price.text = self.value_price;
    
    
    if (self.typeKTTS == 1) {
        cell.tittleStatusLabel.hidden = NO;
        cell.value_status.hidden = NO;
        cell.heightStatusConstrain.constant = 22;
        cell.tittleStatusLabel.text = @"Mã trạm";
        cell.value_status.text = self.value_asset_type;
    } else {
        if(self.stt == 0){
            cell.tittleStatusLabel.hidden = YES;
            cell.value_status.hidden = YES;
            cell.heightStatusConstrain.constant = 0;
        }else {
            cell.tittleStatusLabel.hidden = NO;
            cell.value_status.hidden = NO;
            cell.heightStatusConstrain.constant = 22;
            cell.value_status.text = self.value_status;
        }
    }
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)btnCancelOrConfirmAction:(id)sender {
    switch (self.isColorButton) {
        case isCancelStatus:
        {
            [self actionShowCancelStatusVC];
        }
            break;
        case isConfirmStatus:
        {
            [self pushConfirmViewController];
        }
            break;
        default:
            break;
    }
}

- (void)actionShowCancelStatusVC {
    
    if ((([self.value_status rangeOfString:@"KSD"].location != NSNotFound) && ([self.value_status rangeOfString:@"mất"].location == NSNotFound) && ([self.value_status rangeOfString:@"hỏng"].location == NSNotFound)) || (([self.value_status rangeOfString:@"KSD"].location == NSNotFound) && ([self.value_status rangeOfString:@"mất"].location != NSNotFound) && ([self.value_status rangeOfString:@"hỏng"].location == NSNotFound)) || (([self.value_status rangeOfString:@"KSD"].location == NSNotFound) && ([self.value_status rangeOfString:@"mất"].location == NSNotFound) && ([self.value_status rangeOfString:@"hỏng"].location != NSNotFound))) {

        NSString *messageString1 = @"'không sử dụng'";
        NSString *messageString2 = @"'đã mất'";
        NSString *messageString3 = @"'đã hỏng'";
        NSString *message = [NSString stringWithFormat:@"Đ/c có chắc chắn muốn hủy thông báo %@ đối với tài sản này?", messageString2];

        if ([self.value_status rangeOfString:@"KSD"].location != NSNotFound) {
            message = [NSString stringWithFormat:@"Đ/c có chắc chắn muốn hủy thông báo %@ đối với tài sản này?", messageString1];
        } else if ([self.value_status rangeOfString:@"mất"].location != NSNotFound) {
            message = [NSString stringWithFormat:@"Đ/c có chắc chắn muốn hủy thông báo %@ đối với tài sản này?", messageString2];
        } else if ([self.value_status rangeOfString:@"hỏng"].location != NSNotFound) {
            message = [NSString stringWithFormat:@"Đ/c có chắc chắn muốn hủy thông báo %@ đối với tài sản này?", messageString3];
        } else {

        }

        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Xác nhận"
                                     message:message
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Xác nhận"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        NSDictionary *parameter = @{
                                                                    @"merEntityId": IntToString(self.merEntityId),
                                                                    @"type": IntToString(self.typeCancel)
                                                                    };
                                        [KTTSProcessor postKTTS_CANCEL_TTTS:parameter handle:^(id result, NSString *error) {
                                            [[NSNotificationCenter defaultCenter]
                                             postNotificationName:@"CancelSucessNotification"
                                             object:self];
                                            [alert dismissViewControllerAnimated:NO completion:nil];
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Hủy thành công." delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
                                            [alert show];
                                        } onError:^(NSString *Error) {
                                            [alert dismissViewControllerAnimated:NO completion:nil];
                                            [self showAlertFailure:@"Có lỗi xảy ra. Vui lòng kiểm tra lại."];
                                        } onException:^(NSString *Exception) {
                                            [alert dismissViewControllerAnimated:NO completion:nil];
                                            [self showAlertFailure:@"Mất kết nối mạng"];
                                        }];
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Đóng"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action) {
                                       //
                                   }];
        [noButton setValue:[UIColor grayColor] forKey:@"titleTextColor"];
        [alert addAction:noButton];
        [alert addAction:yesButton];
        alert.preferredAction = yesButton;
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        KTTS_CancelStatus_VC_iPad *vc = NEW_VC_FROM_NIB(KTTS_CancelStatus_VC_iPad, @"KTTS_CancelStatus_VC_iPad");
        vc.merEntityId = IntToString(self.merEntityId);
        vc.strStatus = self.value_status;
    
        MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
        formSheet.presentedFormSheetSize = CGSizeMake(SCREEN_HEIGHT_LANDSCAPE-40, 200);
        //    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromTop;
        formSheet.shadowRadius = 2.0;
        formSheet.shadowOpacity = 0.3;
        formSheet.cornerRadius = 12;
        formSheet.shouldDismissOnBackgroundViewTap = NO;
        formSheet.shouldCenterVertically = YES;
        formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
        [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        }];
    }
}

- (void) showAlertFailure:(NSString *)mess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message: mess delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1:
        {
            [self cancelNotification];
        }
            break;
            
        default:
            break;
    }
}

// TO DO ...
- (void) cancelNotification {
    //    NSDictionary *parameter = @{
    //                                @"merEntityId": IntToString(self.merEntityId),
    //                                @"type": IntToString(self.count)
    //                                };
    //    [KTTSProcessor postCancelNotification:parameter handle:^(id result, NSString *error) {
    //
    //    }];
}

// red
- (void) setColorCancel {
    self.status = isConfirmStatus;
    self.btnCancelOrConfirm.backgroundColor = RGB(240, 82, 83);
    [self.btnCancelOrConfirm setTitle:@"Hủy thông báo" forState:UIControlStateNormal];
}

// blue
- (void) setColorConfirm {
    self.status = isCancelStatus;
    self.btnCancelOrConfirm.backgroundColor = RGB(14, 133, 188);
    [self.btnCancelOrConfirm setTitle:@"Xác nhận tài sản" forState:UIControlStateNormal];
}

- (void) pushConfirmViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AssetConfirm" bundle:nil];
    AssetConfirmViewController *assetConfirm = (AssetConfirmViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AssetConfirmViewController"];
    assetConfirm.merEntityId = self.merEntityId;
    assetConfirm.value_commodity_code = self.value_commodity_code;
    assetConfirm.value_commodity_name = self.value_commodity_name;
    assetConfirm.value_unit = self.value_unit;
    assetConfirm.value_number = self.value_number;
    assetConfirm.value_serial = self.value_serial;
    assetConfirm.value_manufacturer = self.value_manufacturer;
    assetConfirm.value_aspect = self.value_aspect;
    assetConfirm.value_expiry_date = self.value_expiry_date;
    assetConfirm.value_asset_type = self.value_asset_type;
    assetConfirm.value_use_time = self.value_use_time;
    assetConfirm.value_price = self.value_price;
    assetConfirm.value_status = self.value_status;
    assetConfirm.count = self.count;
    assetConfirm.typeKTTS = self.typeKTTS;
    [self.navigationController pushViewController:assetConfirm animated:YES];
}

- (IBAction)cancelAction:(id)sender {
    [self actionShowCancelStatusVC];
}

- (IBAction)confirmAction:(id)sender {
    [self pushConfirmViewController];
}

- (void)didTapBackButton {
    [self popToMoreRoot];
}

@end

