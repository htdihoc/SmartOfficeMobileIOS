//
//  AssetConfirmViewController.m
//  SmartOffice
//
//  Created by Vu Van Tiep on 4/28/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import "AssetConfirmViewController.h"
#import "BBBGAssetCell.h"
#import "AssetConfirmCell.h"
#import "KPDropMenu.h"
#import "KTTSProcessor.h"
#import "UIAlertView+Blocks.h"

@interface AssetConfirmViewController () <TTNS_BaseNavViewDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, BBBGAssetCellDelegate> {
    BBBGAssetCell *bbbgCell;
    AssetConfirmCell *assetConfirmCell;
}

@property (weak, nonatomic) IBOutlet UITableView *assetconfirmTableView;

@end

@implementation AssetConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backTitle = @"Xác nhận tài sản";
    self.assetconfirmTableView.estimatedRowHeight = 190;
    self.assetconfirmTableView.rowHeight = UITableViewAutomaticDimension;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [assetConfirmCell.view_type closeAllComponentsAnimated:YES];
}

- (void) dismissKeyboard {
    [self.view endEditing:YES];
    [assetConfirmCell.view_type closeAllComponentsAnimated:YES];
    [assetConfirmCell.datePicker removeFromSuperview];
}

- (void) customCell:(BBBGAssetCell *)cell button1Pressed:(UIButton *)btn{
    [self didTapBackButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        bbbgCell = (BBBGAssetCell *)[tableView dequeueReusableCellWithIdentifier:@"bBBGAssetCell"];
        if (bbbgCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BBBGAssetCell" owner:self options:nil];
            bbbgCell = [nib objectAtIndex:0];
        }
        bbbgCell.btn_view_detail.tag = indexPath.row;
        bbbgCell.delegate = self;
        bbbgCell.value_goods_name.text = self.value_commodity_name;
        bbbgCell.value_number.text = self.value_number;
        bbbgCell.value_serial.text = self.value_serial;
        bbbgCell.value_status.text = self.value_status;
        
        bbbgCell.selectionStyle = UIAccessibilityTraitNone;
        return bbbgCell;
    } else {
        assetConfirmCell = (AssetConfirmCell *)[tableView dequeueReusableCellWithIdentifier:@"assetConfirmCell"];
        if (assetConfirmCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AssetConfirmCell" owner:self options:nil];
            assetConfirmCell = [nib objectAtIndex:0];
        }
        assetConfirmCell.text_number_not_used.text = self.value_number;
        assetConfirmCell.selectionStyle = UIAccessibilityTraitNone;
        return assetConfirmCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return UITableViewAutomaticDimension;
    } else {
        return 480;
    }
}
    
- (IBAction)confirmAction:(id)sender {
    NSDate *dateFromString = [NSDate new];
    NSTimeInterval timeInMiliseconds = [dateFromString timeIntervalSince1970]*1000;
    NSInteger dateNowInteger = timeInMiliseconds;
    
    if([IntToString(assetConfirmCell.type) isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn chưa chọn loại tài sản" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Đồng ý", nil];
        [alert show];
        [assetConfirmCell.view_type becomeFirstResponder];
        return;
    }else if ([assetConfirmCell.text_number_not_used.text integerValue] > [self.value_number integerValue] || [assetConfirmCell.text_number_not_used.text integerValue] == 0){
        NSString *stringTextDropdown = @"";
        if([assetConfirmCell.textDropDown.text isEqual: @"Báo mất"]){
            stringTextDropdown = @"báo mất";
        }else if([assetConfirmCell.textDropDown.text isEqual: @"Báo hỏng"]){
            stringTextDropdown = @"báo hỏng";
        }else if([assetConfirmCell.textDropDown.text isEqual: @"Báo không sử dụng"]){
            stringTextDropdown = @"báo không sử dụng";
        }
        NSString *typeString = [NSString stringWithFormat:@"Đ/c phải nhập số lượng tài sản %@ nhỏ hơn hoặc bằng số lượng đang có.", stringTextDropdown];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:typeString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Đồng ý", nil];
        [alert show];
        [assetConfirmCell.text_number_not_used becomeFirstResponder];
        return;
    }else if(assetConfirmCell.date > dateNowInteger){
        NSString *stringTextDropdown = @"";
        if([assetConfirmCell.textDropDown.text isEqual: @"Báo mất"]){
            stringTextDropdown = @"báo mất";
        }else if([assetConfirmCell.textDropDown.text isEqual: @"Báo hỏng"]){
            stringTextDropdown = @"báo hỏng";
        }else if([assetConfirmCell.textDropDown.text isEqual: @"Báo không sử dụng"]){
            stringTextDropdown = @"báo không sử dụng";
        }
        NSString *typeString = [NSString stringWithFormat:@"Đ/c phải nhập ngày %@ nhỏ hơn hoặc bằng ngày hiện tại.", stringTextDropdown];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:typeString delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Đồng ý", nil];
        [alert show];
        [assetConfirmCell.dateTextField becomeFirstResponder];
        return;
    }else if([assetConfirmCell.tv_reason.text isEqual: @""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Đ/c chưa nhập nguyên nhân." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Đồng ý", nil];
        [alert show];
        [assetConfirmCell.tv_reason becomeFirstResponder];
        return;
    }else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Xác nhận" message:@"Đ/c chắn chắn muốn gửi xác nhận này?" delegate:self cancelButtonTitle:@"Hủy" otherButtonTitles:@"Gửi", nil];
//        alert.delegate = self;
//        [alert show];
        
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Xác nhận"
                                                                      message:@"Đ/c chắn chắn muốn gửi xác nhận này?"
                                                               preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Gửi"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        NSLog(@"you pressed Yes, please button");
                                        [self sendConfirmAction];
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"Hủy"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                                   {
                                       NSLog(@"you pressed No, thanks button");
                                   }];
        
        [noButton setValue:[UIColor grayColor] forKey:@"titleTextColor"];
        [alert addAction:noButton];
        [alert addAction:yesButton];
        alert.preferredAction = yesButton;
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1:
            [self sendConfirmAction];
            break;
        default:
            break;
    }
}

- (void) sendConfirmAction {
    [[Common shareInstance] showCustomHudInView:self.view];
    NSDictionary *parameter = @{
                                @"merEntityId": IntToString(_merEntityId),
                                @"count": assetConfirmCell.text_number_not_used.text,
                                @"date": IntToString(assetConfirmCell.date),
                                @"type": IntToString(assetConfirmCell.type),
                                @"reason": assetConfirmCell.tv_reason.text
                                };
    [KTTSProcessor postKTTS_CONFIRM_TTTS:parameter handle:^(id result, NSString *error) {
        [self hideCustomHUB];
        if (self.delegate) {
            [self.delegate successAssetConfirmVC];
        }
    } onError:^(NSString *Error) {
        [self hideCustomHUB];
        [UIAlertView showWithTitle:@"Thông báo" message:Error style:UIAlertViewStyleDefault cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
            //close alert
            DLog(@"Alert button index: %ld", buttonIndex);
            if (self.delegate) {
                [self.delegate errorAssetConfirmVC];
            }
        }];
    } onException:^(NSString *Exception) {
        [self hideCustomHUB];
        [UIAlertView showWithTitle:@"Thông báo" message:LocalizedString(@"Mất kết nối mạng") style:UIAlertViewStyleDefault cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
            //close alert
            DLog(@"Alert button index: %ld", buttonIndex);
            if (self.delegate) {
                [self.delegate errorAssetConfirmVC];
            }
        }];
    }];
}

- (void) hideCustomHUB {
    [[Common shareInstance] dismissCustomHUD];
}

- (void)confirmAssetWithType:(NSInteger)type number:(NSInteger)number date:(NSInteger)date reason:(NSString *)reason {
    
}

- (void)didTapBackButton {
    [assetConfirmCell.view_type closeAllComponentsAnimated:YES];
    [self popToMoreRoot];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
