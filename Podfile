
# 添加第三方库的源
source 'https://github.com/CocoaPods/Specs.git'
#source 'http://code.yy.com/ci_team/Specs.git'
#source 'https://gitlab.huya.com/ci_team/Specs.git'

# Uncomment the next line to define a global platform for your project
# platform :ios, '8.0'

target 'Salmon' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for Salmon
  pod 'Bugly', '2.5.0'
  pod 'SVProgressHUD', '2.1.2'
  pod 'GCDWebServer', '~> 3.0'

  
  pod'React', :path => './SalmonRN/node_modules/react-native', :subspecs => [
  'Core',
  'CxxBridge', # Include this for RN >= 0.47
  'DevSupport', # Include this to enable In-App Devmenu if RN >= 0.43
  'RCTText',
  'RCTNetwork',
  'RCTWebSocket', # Needed for debugging
  'RCTAnimation', # Needed for FlatList and animations running on native UI thread
  'RCTImage',
  # Add any other subspecs you want to use in your project
  ]
  pod 'react-native-webview', :path => './SalmonRN/node_modules/react-native-webview'
  pod 'ReactNativeNavigation',:path => './SalmonRN/node_modules/react-native-navigation'
  pod 'yoga', :path => './SalmonRN/node_modules/react-native/ReactCommon/yoga'
  # Third party deps podspec link
  pod 'DoubleConversion', :podspec => './SalmonRN/node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
  pod 'glog', :podspec => './SalmonRN/node_modules/react-native/third-party-podspecs/glog.podspec'
  pod 'Folly', :podspec => './SalmonRN/node_modules/react-native/third-party-podspecs/Folly.podspec'
  
  pod 'RNFS', :path => './SalmonRN/node_modules/react-native-fs'

  target 'SalmonTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SalmonUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
