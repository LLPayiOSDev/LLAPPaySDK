//
//  LLPayUtil.h
//  DemoPay
//
//  Created by xuyf on 15/4/16.
//  Copyright (c) 2015年 llyt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kLLPaySignMethodMD5 = 0,
    kLLPaySignMethodRSA,
} LLPaySignMethod;


#define kLLPayUtilNeedRSASign

@interface LLPayUtil : NSObject

@property (nonatomic, retain) NSArray *signKeyArray;
/*!
 // 签名工具
 // signKey 在 md5时是md5key，rsa是rsa私钥。
 Demo中为了方便演示， 所以将加签过程以及密钥放在本地,但是在真实APP中，
 请务必⚠️将privateKey和加签过程放在商户服务端⚠️
 以防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险
 */
- (NSDictionary*)signedOrderDic:(NSDictionary*)orderDic
                     andSignKey:(NSString*)signKey;

// 其他工具
// 转换dic成string
+ (NSString*)jsonStringOfObj:(NSDictionary*)dic;
+ (NSString *)timeStamp;
+ (NSString *)LLURLEncodedString:(NSString*)str;
+ (NSString *)LLURLDecodedString:(NSString*)str;
@end
