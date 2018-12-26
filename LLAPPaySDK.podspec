
Pod::Spec.new do |s|
  s.name             = 'LLAPPaySDK'
  s.version          = '2.7.6'
  s.summary          = 'LLAPPaySDK.'
  s.description      = <<-DESC
LLAPPaySDK 是连连支付的  Pay SDK ， 可以调起苹果的  Pay
                       DESC
  s.homepage         = 'https://github.com/LLPayiOSDev/LLAPPaySDK'
  s.license          = { :type => 'Copyright', :text => '© 2003-2018 Lianlian Yintong Electronic Payment Co., Ltd. All rights reserved.' }
  s.author           = { 'LLPayiOSDev' => 'iosdev@yintong.com.cn' }
  s.source           = { :git => 'https://github.com/LLPayiOSDev/LLAPPaySDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.source_files = 'LLAPPaySDK/**/*.{h,m}'
  s.public_header_files = 'LLAPPaySDK/**/*.h'
  s.ios.vendored_library = 'LLAPPaySDK/libLLAPPaySDK.a'
  s.dependency 'LLPay/Core'
end
