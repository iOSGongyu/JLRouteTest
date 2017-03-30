platform :ios, '8.0'
use_frameworks!

target 'JLRouteTest’ do

pod 'JLRoutes', '~> 2.0.1'

# 'node_modules'目录一般位于根目录中
# 但是如果你的结构不同，那你就要根据实际路径修改下面的`:path`
pod 'React', :path => './node_modules/react-native', :subspecs => [
    'Core',
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', # 这个模块是用于调试功能的
    # 在这里继续添加你所需要的模块
]
  # 如果你的RN版本 >= 0.42.0，请加入下面这行
pod "Yoga", :path => "./node_modules/react-native/ReactCommon/yoga"

end
