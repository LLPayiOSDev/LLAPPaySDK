# LLAPPaySDK

[![Version](https://img.shields.io/cocoapods/v/LLAPPaySDK.svg?style=flat)](http://cocoapods.org/pods/LLAPPaySDK)
[![License](https://img.shields.io/cocoapods/l/LLAPPaySDK.svg?style=flat)](http://cocoapods.org/pods/LLAPPaySDK)
[![Platform](https://img.shields.io/cocoapods/p/LLAPPaySDK.svg?style=flat)](http://cocoapods.org/pods/LLAPPaySDK)

## 简介
[连连支付开放平台](https://apple.lianlianpay.com/OpenPlatform/index.jsp)

Apple Pay，是苹果公司在2014苹果秋季新品发布会上发布的一种基于NFC的手机支付功能，于2014年10月20日正式上线。目前仅支持在安装 iOS 9.2 或更高版本系统的 iPhone 6、iPhone 6 Plus、iPhone 6S、iPad Air 2、iPad mini 3 等更新设备上运行。另外需要确保使用Mac 已经安装最新版本的 Xcode。 开发者通过集成连连支付手机sdk方式，商户即可组合设计支付交互页面，为用户提供体验一致，安全可靠的支付应用场景。

example 文件夹里面是一个简单的接入示例，该示例仅供参考。

## 版本要求
iOS SDK 要求 iOS 9.2 以上系统

## 接入方法
#### 使用CocoaPods

1. LLAPPaySDK 可通过 [CocoaPods](http://cocoapods.org)安装。 只需在Podfile里添加一行：

	```ruby
	pod 'LLAPPaySDK'
	```
2.  运行 pod install
3. 使用 .xcworkspace 打开项目
4. 如果在工程中 TARGETS - Capabilities 里没有打开 ApplePay 开关， 请打开， 勾选配置的merchantID
5. 导入头文件，调用 SDK 方法


	```
	#import <LLAPPaySDK/LLAPPaySDK.h>
	```

#### 手动导入

1. 下载SDK

	LLAPPaySDK 文件夹里是 SDK 相关文件
2. 将 SDK 添加到工程中

	确保 Target -- build phases -- Link Binary With Libraries 中有 libLLAPPaySDK.a 静态库
3. 如果在工程中 TARGETS - Capabilities 里没有打开 ApplePay 开关， 请打开， 勾选配置的merchantID
4. 导入头文件， 调用SDK

	```
	#import "LLAPPaySDK.h"
	```
	

## 注意事项
- 在创建 MerchantID 证书时， CSR 文件需要使用在[连连支付开放平台](https://apple.lianlianpay.com/OpenPlatform/index.jsp)上下载的 CSR 文件。
- 在创建 MerchantID 证书时， 若提示是否仅在中国使用， 请选是。
- 支付结果请以服务端异步通知为准

## Author

LLPayiOSDev, iosdev@yintong.com.cn

## License

LLAPPaySDK is available under the MIT license. See the LICENSE file for more info.
