//
//  LLViewController.m
//  LLAPPaySDK
//
//  Created by LLPayiOSDev on 11/28/2017.
//  Copyright (c) 2017 LLPayiOSDev. All rights reserved.
//

#import "LLViewController.h"
#import <LLAPPaySDK/LLAPPaySDK.h>

@interface LLViewController () <LLPaySdkDelegate>

@end

@implementation LLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)apPay:(id)sender {
    [LLAPPaySDK sharedSdk].sdkDelegate = self;
    [[LLAPPaySDK sharedSdk] payWithTraderInfo:[self createOrder] inViewController:self];
}

- (IBAction)apPreAuthPay:(id)sender {
    [LLAPPaySDK sharedSdk].sdkDelegate = self;
    [[LLAPPaySDK sharedSdk] preauthWithTraderInfo:[self createOrder] inViewController:self];
}

- (IBAction)checkSupportStatus:(id)sender {
    LLAPPaySupportStatus status = [LLAPPaySDK canDeviceSupportApplePayPayments];
    switch (status) {
        case kLLAPPayDeviceSupport:
            [self llAlertWithTitle:@"提示" andMsg:@"完全支持"];
            break;
        case kLLAPPayDeviceNotSupport:
            [self llAlertWithTitle:@"提示" andMsg:@"机型不支持，或者系统版本太低"];
            break;
        case kLLAPPayDeviceVersionTooLow:
            [self llAlertWithTitle:@"提示" andMsg:@"设备无法支持银联卡支付，需要iOS9.2以上"];
            break;
        case kLLAPPayDeviceNotBindChinaUnionPayCard:
            [self llAlertWithTitle:@"提示" andMsg:@"用户未绑卡"];
            break;
        default:
            break;
    }
}

- (IBAction)bindCardForAPPay:(id)sender {
    [LLAPPaySDK showWalletToBindCard];
}

- (IBAction)showSDKVersion:(id)sender {
    NSString *version = [NSString stringWithFormat:@"BuildVersion: %@\nVersion:%@",kLLPaySDKBuildVersion, kLLPaySDKVersion];
    [self llAlertWithTitle:@"SDKVersion" andMsg:version];
}

/**
 创建订单

 @return 返回订单
 */
- (NSDictionary *)createOrder {
    NSString *timeStamp = [LLPayUtil timeStamp];
    NSMutableDictionary *order = [NSMutableDictionary dictionary];
    //基本参数
    order[@"oid_partner"] = @"201601250000011008";
    //此处仅为Demo演示方便， 商户接入时请务必使用RSA， 并将签名操作放在商户服务端， 防止商户私密数据泄露， 造成资产损失
    order[@"sign_type"] = @"MD5";
    order[@"ap_merchant_id"] = @"merchant.com.OpenplatSz.ap";
    
    //业务参数
    order[@"busi_partner"] = @"101001";
    order[@"no_order"] = [@"LL" stringByAppendingString:timeStamp];
    order[@"dt_order"] = timeStamp;
//    order[@"name_goods"] = @"连连iOS测试商品";
//    order[@"info_order"] = @"用于测试";
    order[@"money_order"] = @"0.01";
    order[@"notify_url"] = @"http://test.yintong.com.cn:80/apidemo/API_DEMO/notifyUrl.htm";
//    order[@"valid_order"] = @"30";//订单有效时间
    order[@"risk_item"] = [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130",
                                                  @"cinema_name":@"大电影院",
                                                  @"book_phone":@"18857133222"}];
    order[@"user_id"] = [@"lluser" stringByAppendingString:timeStamp];
    
    /*
     签名操作， 请注意⚠️
     Demo中为了方便演示， 所以将加签过程以及密钥放在本地
     但是在真实APP中， 请务必⚠️将privateKey和加签过程放在商户服务端⚠️
     以防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险"
     */
    LLPayUtil *util = [[LLPayUtil alloc] init];
    NSDictionary *paymentInfo = [util signedOrderDic:order andSignKey:@"201601250000011007_1"];//签名
    
    return paymentInfo;
}

- (void)llAlertWithTitle: (NSString *)title andMsg: (NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Delegate

- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic {
    NSLog(@"%@",[LLPayUtil jsonStringOfObj:dic]);
    NSString *msg = nil;
    switch (resultCode) {
        case kLLPayResultSuccess:
            msg = @"成功";
            break;
        case kLLPayResultFail:
            msg = @"失败";
            break;
        case kLLPayResultCancel:
            msg = @"取消";
            break;
        case kLLPayResultInitError:
            msg = @"初始化异常";
            break;
        case kLLPayResultInitParamError:
            msg = dic[@"ret_msg"];
            break;
        case kLLPayResultRequestingCancel:
            msg = @"支付中取消";
        default:
            msg = @"异常";
            break;
    }
    [self llAlertWithTitle:msg andMsg:[LLPayUtil jsonStringOfObj:dic]];
}

- (void)paymentSucceededWithShippingMessages:(NSDictionary *)shippingMessages {
    NSLog(@"%@",shippingMessages);
}

@end
