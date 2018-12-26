//
//  LLPaySdk.h
//  LLPaySdk
//
//  Created by xuyf on 14-4-23.
//  Copyright (c) 2014年 LianLianPay. All rights reserved.
//

#import "LLPay.h"

extern const NSString* const kLLPStdSDKVersion;

/*
 ========== Apple Pay =================
 */
#pragma mark - Apple Pay SDK

/** 送货信息的key */
extern NSString * const LLAPPayNeedShipping;

/** 需要sdk返回的用户信息，也是代理方法中shippingMessages的key值 */
extern NSString * const LLShippingMessageName;
extern NSString * const LLShippingMessageAddress;
extern NSString * const LLShippingMessagePhone;
extern NSString * const LLShippingMessageEmail;
extern NSString * const LLShippingMessagePostalCode;
extern NSString * const LLShippingMessageShippingMethod;

/** 送货信息，快递名称和详情 */
extern NSString * const LLShippingMethodName;
extern NSString * const LLShippingMethodDetail;

/** 商品详情，详情名称和价格 */
extern NSString * const LLSummaryItemName;
extern NSString * const LLSummaryItemPrice;

typedef enum : NSUInteger {
    kLLAPPayDeviceSupport,                  // 完全支持
    kLLAPPayDeviceNotSupport,               // 设备无法支持，无法绑卡，原因是机型不支持，或者系统版本太低
    kLLAPPayDeviceVersionTooLow,            // 设备无法支持银联卡支付，需要iOS9.2以上
    kLLAPPayDeviceNotBindChinaUnionPayCard, // 设备支持，用户未绑卡
} LLAPPaySupportStatus;


@interface LLAPPaySDK : NSObject

/**
 *  单例
 *
 *  @return 返回APSdk的单例对象
 */
+ (LLAPPaySDK*)sharedSdk;

/** LLAPPaySDK代理 */
@property (nonatomic, assign) NSObject<LLPStdSDKDelegate> *sdkDelegate;

/**
 *  消费
 *
 *  @param traderInfo     交易信息
 *  @param viewController 推出ApplePay界面的VC
 */
- (void)payWithTraderInfo:(NSDictionary *)traderInfo
         inViewController:(UIViewController *)viewController;


/**
 *  预授权支付，供酒店商旅等行业，进行预授权支付使用
 *
 *  @param traderInfo     交易信息
 *  @param viewController 推出ApplePay界面的VC
 */
- (void)preauthWithTraderInfo:(NSDictionary *)traderInfo
             inViewController:(UIViewController *)viewController;



/**
 *  判断是否能使用 Apple Pay
 *
 *  @return 返回支持与否的枚举值LLAPPaySupportStatus
 */
+ (LLAPPaySupportStatus)canDeviceSupportApplePayPayments;

/** 跳转wallet系统app进行绑卡 */
+ (void)showWalletToBindCard;

/**
 *  组织送货信息LLAPPayNeedShipping的value值
 *
 *  @param shippingMessages 需要的用户信息
 *  @param shippingMethods  送货方式
 *  @param summaryItems     详情信息
 *  @param postalPrice      邮费
 *
 *  @return 返回LLAPPayNeedShipping的value值
 */
+ (NSString *)valueWithShippingMessages: (NSArray *)shippingMessages
                        shippingMethods: (NSArray *)shippingMethods
                           summaryItems: (NSArray *)summaryItems
                            postalPrice: (NSString *)postalPrice;
@end

