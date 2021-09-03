#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint onetwothree_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'onetwothree_sdk'
  s.version          = '0.0.1'
  s.summary          = 'A OneTwoThreeSDK Flutter plugin.'
  s.description      = <<-DESC
A OneTwoThreeSDK Flutter plugin.
                       DESC
  s.homepage         = 'http://2c2p.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { '2c2p' => 'nonthawatt.pho@2c2p.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  
  # OneTwoThreeSDK framework
  s.preserve_paths = 'Frameworks/*.xcframework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework OneTwoThreeSDK -ObjC -lstdc++ -lpthread -lresolv' }
  s.vendored_frameworks = 'Frameworks/OneTwoThreeSDK.xcframework'
end
