连连支付Pay送货信息配置指南
===
> 在最新的Pay SDK中，可以看到以下信息



```
/** 送货信息的key */
extern NSString * const LLAPPayNeedShipping;

/** 需要sdk返回的用户信息 */
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

+ (NSString *)valueWithShippingMessages: (NSArray *)shippingMessages
                        shippingMethods: (NSArray *)shippingMethods
                           summaryItems: (NSArray *)summaryItems
                            postalPrice: (NSString *)postalPrice;                          
@optional
- (void)paymentSucceededWithShippingMessages: (NSDictionary *)shippingMessages;
                       
```


### 打开送货信息的方法
---
只需要在原有的traderInfo中加一个字段（LLAPPayNeedShipping）即可，字段的值中包含了商户需要sdk返回的**用户信息**，**送货方式**，**邮费**，以及**商品详情**

该字段LLAPPayNeedShipping 的value值可以通过已有方法获取：

```
/**
 *  配置送货信息
 *
 *  @param shippingMessages 需要回传的用户信息
 *  @param shippingMethods  送货方式
 *  @param summaryItems     商品详情
 *  @param postalPrice      邮费
 *
 *  @return 返回LLAPPayNeedShipping字段的value值
 */
+ (NSString *)valueWithShippingMessages: (NSArray *)shippingMessages
                        shippingMethods: (NSArray *)shippingMethods
                           summaryItems: (NSArray *)summaryItems
                            postalPrice: (NSString *)postalPrice;
```
**注意**：LLAPPayNeedShipping此字段不参与签名
方法中的四个参数都可以为nil，表示不显示或者不回传各自信息

> 👇👇👇👇👇👇下面有具体参数的配置方法

配置完在traderInfo中加入字段再调用支付即可


```
traderInfo[LLAPPayNeedShipping] = [LLAPPaySDK valueWithShippingMessages:requiredShippingMessages
                                                        shippingMethods:shippingMethods
                                                           summaryItems:summaryItems
                                                            postalPrice:@"5"];
```


### 1. 需要回传的用户信息
---

Pay有6种用户信息可以获取如下表

|用户信息								|说明|
|----------							|-----------|
|LLShippingMessageName				|用户名（地址中包含姓名）|
|LLShippingMessageAddress			|用户地址	|
|LLShippingMessagePhone				|用户手机号|
|LLShippingMessageEmail				|用户邮箱	|
|LLShippingMessagePostalCode		|邮政编码	|
|LLShippingMessageShippingMethod	|送货方式，需要商户传入送货方式才有|

如果商户需要哪些信息，请将需要的用户信息放在一个数组中.
比如：需要用户的地址,姓名和手机号

```
NSArray *requiredShippingMessages = @[LLShippingMessageAddress,LLShippingMessagePhone];
//由于LLShippingMessageAddress中包含了LLShippingMessageName
//所以不需要将LLShippingMessageName放在数组中,传了也可以
//当然，如果只需要名字不需要地址，那么LLShippingMessageName是需要放在数组中的
```

传入后，Pay会在界面中提示用户输入相应的信息，如果支付成功了会通过回调返回

##### 回调方法
```
- (void)paymentSucceededWithShippingMessages: (NSDictionary *)shippingMessages;
```

shippingMessages这个字典中的key值就是商户传入的几个字段LLShippingMessageAddress，LLShippingMessagePhone

比如上面的requiredShippingMethods，回调后可以获取用户的地址姓名和手机

```
- (void)paymentSucceededWithShippingMessages: (NSDictionary *)shippingMessages {
	NSString *name = shippingMessages[LLShippingMessageName];
	NSString *address = shippingMessages[LLShippingMessageAddress];
	NSString *phone =  shippingMessages[LLShippingMessagePhone];
}                                                                                     
```



### 2. 送货方式
---
商户可以配置在Pay的界面显示的送货方式
每一个送货方式都有两个字段，value值请勿传nil

- LLShippingMethodName 送货方式的名称如@"圆通快递"、@"申通快递"、@"顺丰快递"等 NSString类型
- LLShippingMethodDetail 送货的详情如@"2-4天到达"等 NSString类型

如果需要显示送货方式，送货方式的数组形式如下：

```
NSArray *shippingMethods = @[@{LLShippingMethodName:@"申通快递",LLShippingMethodDetail:@"2-4天送达"},@{@{LLShippingMethodName:@"圆通快递",LLShippingMethodDetail:@"3-5天送达"},@{@{LLShippingMethodName:@"顺丰快递",LLShippingMethodDetail:@"1-2天送达"}];

```
> 界面中默认选中数组中第一个送货方式,即申通快递

**注意**：传入了送货方式要在需要返回的信息的数组中传入LLShippingMessageShippingMethod才会回传用户最后选择的送货方式

### 3. 价格详情
---
商户可以在Pay的界面显示商品价格的详情信息，比如原价，折扣，邮费

注意：邮费**不可变**，没传邮费默认免邮

#### **请确保 商品价格 + 折扣（负数） + 邮费 = 最终支付金额（money_order字段）**
每一个商品的价格详情也都有两个字段，value值请勿传nil

- LLSummaryItemName 	详情名如@"酸菜鱼 * 1"，@"满减优惠" NSString
- LLSummaryItemPrice	商品价格@"40" @"-5"	NSString

如果需要显示商品的价格详情，价格详情的数组形式如下(邮费请不要放在这个数组中):

```
NSArray *summaryItems = @[	@{	LLSummaryItemName:@"酸菜鱼 * 1",
								LLSummaryItemPrice:@"40"},
							@{	LLSummaryItemName:@"满减优惠",
								LLSummaryItemPrice:@"-5"},
							@{	LLSummaryItemName:@"酸菜鱼 * 1",
								LLSummaryItemPrice:@"40"},];
```

### 4. 邮费
---
商户可配置邮费信息，显示在送货信息及商品详情界面，如果传入了送货信息，邮费请单独传，**不传就不会显示**，且默认免邮
邮费只需要传一个NSString类型的字符串
> **注意**: 如果传入邮费（必须为正），请务必传入商品价格详情
